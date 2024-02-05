local playerTalking = {}

local submixes = {}
local default = {}
local jammer = {}
local maxRange = 0

local logger = Logger.New('Range')

function initSubmixes()
    Citizen.CreateThread(function()
        -- Set default radio submix
        logger:info('Creating default radio submix')

        if not Config.UsePMARadioEffect then
            default = Submix:new('Radio_Default', 0)
            default:setEffectRadioFx()
            default:setEffectParamInt('default', 1)

            for _, submix in pairs(Config.DefaultRadioFilter) do
                if type(_) ~= 'string' then
                    default:setEffectParamFloat(submix.name, submix.value)
                end
            end

            default:storeBalance(Config.DefaultRadioFilter.volume.frontLeftVolume or 0.25, Config.DefaultRadioFilter.volume.frontRightVolume or 1.0)
        end

        logger:info('Setting mic clicks.')
        exports['pma-voice']:setVoiceProperty('micClicks', Config.MicClicks)

        -- Jammer Filter
        if Config.AllowJammers then
            logger:info('Creating jammer radio submix')
            jammer = Submix:new('Radio_Jammer', 0)
            jammer:setEffectRadioFx()
            jammer:setEffectParamInt('default', 1)

            for _, submix in pairs(Config.JammerFilter.effect) do
                jammer:setEffectParamFloat(submix.name, submix.value)
            end

            jammer:storeBalance(Config.JammerFilter.volume.frontLeftVolume or 0.25, Config.JammerFilter.volume.frontRightVolume or 1.0)
        end


        logger:info('Creating radio submixes for ranges')
        for _, filter in pairs(Config.Ranges) do
            submixes[_] = {
                submix = Submix:new(('Radio_%s'):format(_), 0),
                effect = filter
            }

            if filter.ranges?.max and filter.ranges?.max > maxRange then
                maxRange = filter.ranges?.max
            end

            submixes[_].submix:setEffectRadioFx()
            submixes[_].submix:setEffectParamInt('default', 1)

            for i, effect in pairs(filter.effect) do
                submixes[_].submix:setEffectParamFloat(effect.name, effect.value)
                -- SetAudioSubmixEffectParamFloat(submixes[_].id, 0, GetHashKey(effect.name), effect.value)
            end

            submixes[_].submix:storeBalance(filter.volume?.frontLeftVolume or 0.25, filter.volume?.frontRightVolume or 1.0)
        end
    end)
end

local function getEffect(id)
    local targetCoords = infinity.getPlayerCoords(id)
    local range = #(GetEntityCoords(cache.ped) - targetCoords)

    local submixToUse = nil
    local mute = false

    for _, filter in pairs(submixes) do
        if filter.effect.ranges then
            local checkRange = filter.effect.ranges
            if range > checkRange?.min and range < checkRange?.max then
                submixToUse = submixes[_].submix
                mute = checkRange.mute or false
            end
        end
    end

    if submixToUse ~= nil then
        submixToUse:resetBalance()
    end

    if submixToUse == nil and default ~= nil then
        submixToUse = default
    end

    if mute then
        if submixToUse ~= nil then
            submixToUse:setBalance(0.0, 0.0)
        end
    end

    if submixToUse ~= nil and range >= maxRange then
        mute = true
    end

    logger:info(('Using submix: %s for player: %s with range: %s muted: %s'):format(submixToUse, id, range, mute))
    return submixToUse, mute
end

function JammerShouldActivate(id)
    if Config.AllowJammers and (bridge.hasJob(Config.DisableJammerForJobs) or Config.DisableJammerForChannels[getCurrentChannel()] ~= nil) then
        logger:info('Jammer effect skipped.')
        return false
    end


    if Config.AllowJammers and utils.tableLength(insideJammerZones) > 0 then
        logger:info('Jammer effect shold be used.')
        return true
    end

    local isInsideJammerZone = callback.await("fd_radio:isInJammerZone", false, id)
    if Config.AllowJammers and isInsideJammerZone then
        logger:info('Jammer effect shold be used.')
        return true
    end

    logger:info('Jammer effect skipped.')
    return false
end

local function setCheckingLoop(id)
    CreateThread(function()
        while playerTalking[id] do
            if JammerShouldActivate(id) then
                logger:info('Using jammer effect for player: ' .. id)
                jammer:connect(id)

                Wait(50)
                goto continue
            end

            local effect, mute = getEffect(id)

            logger:info('Using effect for player: ' .. id)
            if effect ~= nil and not mute then
                effect:connect(id)
            end

            if mute then
                MumbleSetVolumeOverrideByServerId(id, 0.0)
            else
                local success, response = pcall(function()
                    local volume = exports[Config.PMAVoiceResource]:getRadioVolume()

                    return volume
                end)

                if success then
                    MumbleSetVolumeOverrideByServerId(id, response)
                else
                    MumbleSetVolumeOverrideByServerId(id, -1.0)
                end

            end

            Wait(50)
            ::continue::
        end

        playerTalking[id] = nil
    end)
end

RegisterNetEvent('pma-voice:setTalkingOnRadio', function(ply, talking)
    if not talking and playerTalking[ply] then
        logger:info('Disabling submix for player: ' .. ply .. '')
        MumbleSetSubmixForServerId(ply, -1)
        MumbleSetVolumeOverrideByServerId(ply, -1)
        playerTalking[ply] = talking

        return
    end

    local isSpectating = NetworkIsInSpectatorMode() or GetRenderingCam() ~= -1
    if isSpectating and not Config.disableAutoSpectateModeDetection then
        logger:info('Player spectating, disabling submix for player: ' .. ply .. '')
        return
    end

    playerTalking[ply] = talking

    if Config.AllowJammers and JammerShouldActivate(ply) then
        Wait(100)
        logger:info('Using jammer effect for player: ' .. ply .. '')
        jammer:connect(ply)

        setCheckingLoop(ply)

        return
    end

    if not Config.UseRanges then
        logger:info('Ranges disabled, skip')
        return
    end

    if Config.Framework ~= 'none' and bridge.hasJob(Config.DisableRangesForJobs) then
        logger:info('Player has job that disables ranges, skip')
        return
    end

    if Config.Framework ~= 'none' and bridge.hasJob(Config.DisableJammerForJobs) then
        logger:info('Player has job that disables jammers, skip')
        return
    end

    if Config.DisableRangeForChannels[getCurrentChannel()] ~= nil then
        logger:info('Channel range disabled, skip')
        return
    end

    local effect, mute = getEffect(ply)

    -- Wait before pma-voice runs their routine
    Wait(100)
    logger:info('Using effect for player: ' .. ply .. '')

    if effect ~= nil and not mute then
        effect:connect(ply)
    end

    if mute then
        MumbleSetVolumeOverrideByServerId(ply, 0.0)
    end

    setCheckingLoop(ply)
end)

initSubmixes()
