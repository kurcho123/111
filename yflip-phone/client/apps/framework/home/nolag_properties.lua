CreateThread(function()
    if Config.Housing ~= 'nolag_properties' then return end

    debugPrint("Using nolag_properties")

    function MapHomes(homes)
        return homes
    end

    function MapKeyHolders(keys)
        return keys
    end
end)

lib.callback.register('yflip-phone:client:home:remove-key-holder', function(data)
    local success = lib.callback.await('nolag_properties:server:removeKey', false, data.house, data.removedKeyHolder)
    return success
end)

lib.callback.register('yflip-phone:client:home:add-key-holder', function(data)
    local success = lib.callback.await('nolag_properties:server:addKey', false, data.house, tonumber(data.targetSource))
    return success
end)