if Config.Vehiclekeys ~= 'qs-vehiclekeys' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    if not item then return end
    if type(vehicle) ~= 'string' then return end
    exports['qs-vehiclekeys']:GiveKeys(plate, vehicle)
end

function RemoveVehiclekeys(vehicle, plate)
    if type(vehicle) ~= 'string' then return end
    exports['qs-vehiclekeys']:RemoveKeys(plate, vehicle)
end
