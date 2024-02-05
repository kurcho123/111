CreateThread(function()
    if Config.Housing ~= 'qb-houses' or Config.Framework ~= 'qb' then return end

    debugPrint("Using qb-houses")

    function MapHomes(homes)
        local mappedHomes = {}

        for _, home in ipairs(homes) do
            local mappedHome = {
                id = home.id,
                citizenid = home.citizenid,
                house = home.house,
                identifier = home.identifier,
                keyholders = json.decode(home.keyholders),
                label = home.label,
                name = home.name,
                owned = home.owned,
                price = home.price,
                tier = home.tier,
            }

            local coords = json.decode(home.coords)
            local doorCoords = { x = coords.enter.x, y = coords.enter.y }
            mappedHome.coords = doorCoords

            local keyholders = json.decode(home.keyholders)

            local ids = {}

            if type(keyholders) == "table" then
                for _, id in ipairs(keyholders) do
                    table.insert(ids, id)
                end
            end
            mappedHome.keyholders = ids

            mappedHomes[#mappedHomes + 1] = mappedHome
        end

        return mappedHomes
    end

    function MapKeyHolders(keys)
        return keys
    end
end)
