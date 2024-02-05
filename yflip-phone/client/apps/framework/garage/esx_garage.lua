CreateThread(function()
    if Config.Garages ~= 'esx_garage' or Config.Framework ~= 'esx' then return end

    debugPrint("Using esx_garage")

    function GetVehicleLabel(model)
        local vehicleLabel = GetDisplayNameFromVehicleModel(model):lower()

        if not vehicleLabel or vehicleLabel == 'null' or vehicleLabel == 'carnotfound' then
            vehicleLabel = 'Unknown'
        else
            local text = GetLabelText(vehicleLabel)
            if text and text:lower() ~= 'null' then
                vehicleLabel = text
            end
        end
        return vehicleLabel
    end

    function FindVehicleByPlate(plate)
        local vehicles = GetGamePool('CVehicle')
        for i = 1, #vehicles do
            local vehicle = vehicles[i]
            if DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub('%s+', '') == plate:gsub('%s+', '') then
                return GetEntityCoords(vehicle)
            end
        end

        return lib.callback.await('yflip-phone:server:garage:find-vehicle-by-plate', false, plate)
    end

    function MapVehiclesData(vehicles)
        if vehicles then
            for i = 1, #vehicles do
                vehicles[i].vehicle = GetDisplayNameFromVehicleModel(vehicles[i].model):lower()

                vehicles[i].model = GetVehicleLabel(vehicles[i].model)
            end
        end

        return vehicles
    end
end)
