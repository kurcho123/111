CreateThread(function()
    if Config.Housing ~= 'bcs_housing' then return end

    debugPrint("Using bcs_housing")

    function MapHomes(homes)
        return homes
    end

    function MapKeyHolders(keys)
        return keys
    end
end)
