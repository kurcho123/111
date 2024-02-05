if Config.Vehiclekeys ~= 'xd_locksystem' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    exports['xd_locksystem']:givePlayerKeys(plate)
end

function RemoveVehiclekeys(vehicle, plate)
    return
end
