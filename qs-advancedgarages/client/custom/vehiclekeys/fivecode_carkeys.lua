if Config.Vehiclekeys ~= 'fivecode_carkeys' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    DecorSetInt(vehicle, 'owner', GetPlayerServerId(PlayerId()))
end

function RemoveVehiclekeys(vehicle, plate)
    return
end
