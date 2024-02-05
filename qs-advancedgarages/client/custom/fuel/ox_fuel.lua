if Config.Fuel ~= 'ox_fuel' then
    return
end

function SetFuel(vehicle, fuelLevel)
    Entity(vehicle).state.fuel = fuelLevel
end

function GetFuel(vehicle)
    return Entity(vehicle).state.fuel
end
