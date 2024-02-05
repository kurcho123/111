PlayerData = nil

function bridge.beforeOpen()
    return true
end

function bridge.beforeClose()
    return true
end

function bridge.opened()

end

function bridge.notify(message, type)
    print(message, type)
end

function bridge.standaloneCheckRestrictedChannel(channel)
    local allowed = callback.await("fd_radio:isAceAllowed", false, channel)

    return allowed
end

function bridge.checkRestrictedChannel(channel)
    return false
end

function bridge.isDead()
    return IsEntityDead(cache.ped)
end

function bridge.hasItem()
    return true
end

function bridge.getIdentifier()
    local license, steamid = callback.await("fd_radio:getIdentifiers", false)

    if not license then
        license = GetPlayerServerId(cache.player)
    end

    return license
end

function bridge.loadSettings()
    local loadedSettings = GetResourceKvpString(settingsName())
    if not loadedSettings then
        return loadSettings()
    end

    settings = json.decode(loadedSettings)
    Wait(100)

    loadSettings()
end

function bridge.hasJob(table)
    return false
end

function bridge.getJob()
    return nil
end
