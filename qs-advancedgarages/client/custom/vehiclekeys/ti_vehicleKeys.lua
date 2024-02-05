if Config.Vehiclekeys ~= 'ti_vehicleKeys' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    exports['ti_vehicleKeys']:addTemporaryVehicle(plate)
end

function RemoveVehiclekeys(vehicle, plate)
    return
end
