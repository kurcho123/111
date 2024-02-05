if Config.Vehiclekeys ~= 'vehicles_keys' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    TriggerServerEvent('vehicles_keys:selfGiveVehicleKeys', plate)
end

function RemoveVehiclekeys(vehicle, plate)
    return
end
