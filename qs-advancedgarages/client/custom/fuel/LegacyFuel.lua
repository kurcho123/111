if Config.Fuel ~= 'LegacyFuel' then
    return 100.0
end

function SetFuel(vehicle, fuelLevel)
    local success, error = pcall(function()
        exports['LegacyFuel']:SetFuel(vehicle, fuelLevel)
    end)

    if not success then
        Debug('You did not configure your fuel system and it is set to 100.0 in fuel, check in Config.Fuel')
        return 100.0
    end
end

function GetFuel(vehicle)
    return exports['LegacyFuel']:GetFuel(vehicle)
end
