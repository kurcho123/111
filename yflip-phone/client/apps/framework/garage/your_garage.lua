CreateThread(function()
    if Config.Garages ~= 'your_garage' or Config.Framework ~= 'your_framework' then return end

    debugPrint("Using your_garage")

    function GetVehicleLabel(model)
        -- * Implement your garage logic here.

        return {}
    end

    function FindVehicleByPlate(plate)
        -- * Implement your garage logic here.

        return lib.callback.await('yflip-phone:server:garage:find-vehicle-by-plate', false, plate)
    end

    function MapVehiclesData(vehicles)
        -- * Implement your garage logic here.

        return {}
    end
end)
