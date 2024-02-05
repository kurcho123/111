if Config.Vehiclekeys ~= 'F_RealCarKeysSystem' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    TriggerServerEvent('F_RealCarKeysSystem:generateVehicleKeys', plate)
end

function RemoveVehiclekeys(vehicle, plate)
    return
end
