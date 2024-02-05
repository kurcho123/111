CreateThread(function()
    if Config.Housing ~= 'your_housing' or Config.Framework ~= 'your_framework' then return end

    debugPrint("Using your_housing")

    function MapHomes(homes)
        local mappedHomes = {}

        -- * Implement your housing logic here.

        return mappedHomes
    end

    function MapKeyHolders(keys)
        -- * Implement your housing logic here.
        
        return keys
    end
end)
