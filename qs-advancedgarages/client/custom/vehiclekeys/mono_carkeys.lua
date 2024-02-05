if Config.Vehiclekeys ~= 'mono_carkeys' then
    return
end

function AddVehiclekeys(vehicle, plate, item)
    if not item then return end
    if type(vehicle) ~= 'string' then return end
    TriggerServerEvent('mono_carkeys:CreateKey', plate)
end

function RemoveVehiclekeys(vehicle, plate)
    if type(vehicle) ~= 'string' then return end
    TriggerServerEvent('mono_carkeys:DeleteKey', 1, plate)
end
