function formatChannel(channel)
    return 'channel_' .. channel
end

function hasList(channel)
    if channel == nil then
        return false
    end

    if channel == 0 then
        return false
    end

    if Config.AllChanelsHaveUserList then
        return true
    end

    if Config.WhitelistedAccess[channel] ~= nil and Config.AllWhitelistedChannelsHaveUserList then
        return true
    end

    if Config.ChannelsWhichHasList[channel] ~= nil then
        return true
    end

    return false
end

function canBeLocked(channel)
    if channel == nil then
        return false
    end

    if channel == 0 then
        return false
    end

    if Config.AllChannelsCanBeLocked then
        return true
    end

    if not Config.AllChannelsCanBeLocked and Config.ChannelsWhichCanBeLocked[tonumber(channel)] ~= nil then
        return true
    end

    return false
end
