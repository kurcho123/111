CreateThread(function()
    if Config.Housing ~= 'ps-housing' or Config.Framework ~= 'qb' then return end

    debugPrint("Using ps-housing")

    function MapHomes(homes)
        return homes
    end

    function MapKeyHolders(keys)
        return keys
    end
end)
