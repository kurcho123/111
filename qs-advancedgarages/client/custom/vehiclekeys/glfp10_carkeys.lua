if Config.Vehiclekeys ~= 'glfp10_carkeys' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    if not item then return end
    if type(vehicle) ~= 'string' then return end

    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    TriggerServerEvent('carkeys:server:buyKey', plate, model)
end

function RemoveVehiclekeys(vehicle, plate)
    return
end
