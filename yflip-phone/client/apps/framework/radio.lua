OnRadio = false -- Whether the player is currently on the radio or not.

local pma = exports["pma-voice"]
local mumble = exports["mumble-voip"]
local toko = exports["tokovoip_script"]
local salty = exports['saltychat']

local currentRadioChannel = 0 -- The current radio channel the player is on.
local radioVolume = 50        -- The current radio volume.

local playersInChannel = 0

local function connectToChannel(channel)
    currentRadioChannel = channel

    if Config.Voice == "pma" then
        if OnRadio then
            pma:SetRadioChannel(0)
        else
            OnRadio = true
            pma:setVoiceProperty("radioEnabled", true)
        end

        pma:setRadioChannel(channel)
    elseif Config.Voice == "mumble" then
        if OnRadio then
            mumble:SetRadioChannel(0)
        else
            OnRadio = true
        end

        mumble:setRadioChannel(channel)
    elseif Config.Voice == "salty" then
        OnRadio = true

        salty:SetRadioChannel(channel, true)
    elseif Config.Voice == "toko" then
        print('Implement toko voip connect to radio channel')
    end
end

function LeaveRadioChannel()
    currentRadioChannel = 0
    OnRadio = false
    playersInChannel = 0

    if Config.Voice == "pma" then
        pma:setRadioChannel(0)
        pma:setVoiceProperty("radioEnabled", false)
    elseif Config.Voice == "mumble" then
        mumble:setRadioChannel(0)
    elseif Config.Voice == "salty" then
        salty:SetRadioChannel("", true)
        TriggerServerEvent('yflip-phone:server:radio:leave', currentRadioChannel)
    elseif Config.Voice == "toko" then
        print('Implement toko voip leave radio channel')
    end
end

local function onPlyerJoined(playerSrc)
    TriggerServerEvent('yflip-phone:server:radio:player-joined', playerSrc)
end

local function onPlayerLeft(playerSrc)
    TriggerServerEvent('yflip-phone:server:radio:player-left', playerSrc)
end

local function updateParticipantsOnLeave(channel, playerSrc)
    local players = lib.callback.await('yflip-phone:server:radio:get-participants', false, channel)
    for source in pairs(players) do
        if (source ~= playerSrc) then
            onPlayerLeft(source)
        end
    end
end

RegisterNuiCallback('radio:status', function(_, cb)
    cb({
        onRadio = OnRadio,
        radioChannel = currentRadioChannel,
        radioVolume = radioVolume,
        maxFrequency = Config.Radio.MaxFrequency,
        participants = playersInChannel
    })
end)

RegisterNuiCallback('radio:join', function(channel, cb)
    local src = GetPlayerServerId(PlayerId())

    local rChannel = tonumber(channel)
    if not rChannel then
        cb({ success = false, errorLabel = 'invalidChannel' })
        return
    end

    if rChannel > Config.Radio.MaxFrequency then
        cb({ success = false, errorLabel = 'maxChannelAllowed' })
        return
    end

    if rChannel == currentRadioChannel or rChannel == 0 then
        cb({ success = false, errorLabel = 'alreadyOnChannel' })
        return
    end

    if OnRadio then
        updateParticipantsOnLeave(currentRadioChannel, src)
    end

    debugPrint('Joining radio channel: ' .. channel)

    if Config.Radio.RestrictedChannels[rChannel] ~= nil then
        if Config.Radio.RestrictedChannels[rChannel][PlayerData.job.name] and GetDutyStatus() then
            connectToChannel(rChannel)
        else
            cb({ success = false, errorLabel = 'restrictedChannel' })
            return
        end
    else
        connectToChannel(rChannel)
    end

    playersInChannel = 0

    local players = lib.callback.await('yflip-phone:server:radio:get-participants', false, rChannel)
    for source in pairs(players) do
        playersInChannel = playersInChannel + 1

        if (source ~= src) then
            onPlyerJoined(source)
        end
    end

    cb({ success = true, participants = playersInChannel, volume = radioVolume })
end)

RegisterNuiCallback('radio:leave', function(_, cb)
    debugPrint('Joining radio channel: ' .. currentRadioChannel)

    local src = GetPlayerServerId(PlayerId())

    local lastChannel = currentRadioChannel
    LeaveRadioChannel()

    updateParticipantsOnLeave(lastChannel, src)

    cb({})
end)

RegisterNuiCallback('radio:volume-up', function(_, cb)
    if radioVolume <= 95 then
        radioVolume = radioVolume + 5

        if Config.Voice == "pma" then
            pma:setRadioVolume(radioVolume)
        elseif Config.Voice == "mumble" then

        elseif Config.Voice == "salty" then
            salty:SetRadioVolume(radioVolume)
        elseif Config.Voice == "toko" then

        end

        cb({ success = true, volume = radioVolume })
    else
        cb({ success = false, errorLabel = "maxVolumeReached" })
    end
end)

RegisterNuiCallback('radio:volume-down', function(_, cb)
    if radioVolume >= 10 then
        radioVolume = radioVolume - 5
        if Config.Voice == "pma" then
            pma:setRadioVolume(radioVolume)
        elseif Config.Voice == "mumble" then

        elseif Config.Voice == "salty" then
            salty:SetRadioVolume(radioVolume)
        elseif Config.Voice == "toko" then

        end

        cb({ success = true, volume = radioVolume })
    else
        cb({ success = false, errorLabel = "minVolumeReached" })
    end
end)

RegisterNuiCallback('radio:mute', function(_, cb)
    if Config.Voice == "pma" then
        pma:setRadioVolume(0)
    elseif Config.Voice == "mumble" then

    elseif Config.Voice == "salty" then
        salty:SetRadioVolume(0)
    elseif Config.Voice == "toko" then

    end

    cb({ success = true })
end)

--- state: string - (+ or -) ex: '+radiotalk' or '-radiotalk'
RegisterNuiCallback('radio:push-to-talk', function(state, cb)
    cb({})

    local command = state .. 'radiotalk'
    ExecuteCommand(command)
end)

-- * Exports
local function IsRadioOn()
    return OnRadio
end
exports("IsRadioOn", IsRadioOn)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource and OnRadio then
        LeaveRadioChannel()
    end
end)

RegisterNetEvent('yflip-phone:client:radio:player-joined', function()
    SendUIAction('radio:player-joined')
end)

RegisterNetEvent('yflip-phone:client:radio:player-left', function()
    playersInChannel = playersInChannel - 1
    SendUIAction('radio:player-left')
end)
