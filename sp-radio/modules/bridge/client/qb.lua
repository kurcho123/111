if string.lower(Config.Framework) == 'qb' then
    core = exports[Config.CoreResource]:GetCoreObject()
    local logger = Logger.New('QB Bridge')

    PlayerData = core.Functions.GetPlayerData()

    if PlayerData?.citizenid and LocalPlayer.state.isLoggedIn then
        Citizen.CreateThread(function()
            bridge.loadSettings()
        end)
    end

    -- Handles state right when the player selects their character and location.
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = core.Functions.GetPlayerData()

        bridge.loadSettings()
    end)

    -- Handles job change
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo

        leaveRadio()
    end)

    -- Resets state on logout, in case of character change.
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = {}

        settings = json.decode(json.encode(Config.DefaultSettings))
        leaveRadio()
    end)

    RegisterNetEvent('qb-radio:onRadioDrop', function()
        leaveRadio()
    end)

    -- Handles state when PlayerData is changed. We're just looking for inventory updates.
    RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
        PlayerData = val
    end)

    RegisterNetEvent('fd_radio:use', function()
        toggleRadio()
    end)

    RegisterNetEvent('fd_radio:usedJammer', function()
        placeJammer()
    end)

    function bridge.hasItem(item, amount)
        local item = callback.await('fd_radio:hasItem', false, item, amount)

        if not item then
            return false
        end

        local count = item.count or item.amount

        if type(count) == 'number' then
            return count >= amount
        end

        return false
    end

    function bridge.beforeOpen()
        return bridge.hasItem(Config.UseItemName, 1)
    end

    function bridge.isDead()
        return LocalPlayer.state.isLoggedIn and (PlayerData.metadata.isdead or PlayerData.metadata.inlaststand)
    end

    function bridge.notify(message, type)
        core.Functions.Notify(message, type)
    end

    function bridge.checkRestrictedChannel(channel)
        return (Config.WhitelistedAccess[channel][PlayerData.job.name] and PlayerData.job.onduty) or
            Config.WhitelistedAccess[channel][PlayerData.gang.name]
    end

    function bridge.getIdentifier()
        return PlayerData?.citizenid or cache.player
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
        if PlayerData?.job?.name and PlayerData?.job?.onduty then
            logger:info("Current player job: " .. PlayerData.job.name .. "")
            return PlayerData?.job?.name
        end

        logger:info("Current player job: nil")
        return nil
    end
end
