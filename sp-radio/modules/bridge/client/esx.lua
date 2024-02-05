if string.lower(Config.Framework) == 'esx' then
    core = nil
    local logger = Logger.New('ESX Bridge')

    local success, _ = pcall(function()
        return exports['es_extended']['getSharedObject']
    end)

    if not success then
        while core == nil do
            TriggerEvent('esx:getSharedObject', function(obj) core = obj end)
            Citizen.Wait(0)
        end
    else
        core = exports['es_extended']:getSharedObject()
    end

    PlayerData = core.GetPlayerData()

    if PlayerData ~= nil then
        Citizen.CreateThread(function()
            bridge.loadSettings()
        end)
    end

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer

        bridge.loadSettings()
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        PlayerData = nil

        settings = json.decode(json.encode(Config.DefaultSettings))
        leaveRadio()
    end)

    RegisterNetEvent('esx:setJob', function(job)
        PlayerData.job = job

        leaveRadio()
    end)

    RegisterNetEvent('fd_radio:use', function()
        toggleRadio()
    end)

    RegisterNetEvent('fd_radio:usedJammer', function()
        placeJammer()
    end)

    function bridge.hasItem(item, amount)
        local hasItem = callback.await('fd_radio:hasItem', false, item, amount)

        return hasItem
    end

    function bridge.getIdentifier()
        return PlayerData?.identifier or GetPlayerServerId(PlayerId())
    end


    function bridge.beforeOpen()
        return bridge.hasItem(Config.UseItemName, 1)
    end

    function bridge.isDead()
        return IsEntityDead(cache.ped)
    end

    function bridge.notify(message, type)
        core.ShowNotification(message)
    end

    function bridge.checkRestrictedChannel(channel)
        return Config.WhitelistedAccess[channel][PlayerData.job.name] ~= nil
    end

    function bridge.getIdentifier()
        return PlayerData?.identifier or cache.player
    end

    function bridge.hasJob(table)
        for _, job in pairs(table) do
            if job == PlayerData.job.name then
                logger:info("Player has " .. job .. " job")
                return true
            end
        end

        logger:info("Any jobs did not match")
        return false
    end

    function bridge.getJob()
        if PlayerData?.job?.name then
            logger:info("Current player job: " .. PlayerData.job.name .. "")
            return PlayerData?.job?.name
        end

        logger:info("Current player job: nil")
        return nil
    end
end
