if Config.Vehiclekeys ~= 'wasabi_carlock' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    exports.wasabi_carlock:GiveKey(plate)
end

function RemoveVehiclekeys(vehicle, plate)
    exports.wasabi_carlock:RemoveKey(plate)
end
