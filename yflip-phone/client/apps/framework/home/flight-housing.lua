CreateThread(function()
    if Config.Housing ~= 'flight-housing' or Config.Framework ~= 'qb' then return end

    debugPrint("Using flight-housing")

    function MapHomes(homes)
        return homes
    end

    function MapKeyHolders(keys)
        return keys
    end
end)