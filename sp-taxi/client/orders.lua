inordersmenu = false

RegisterCommand("+taxiorders", function()
    if LocalPlayer.state.rentedVehicle and (not inordersmenu) and (not LocalPlayer.state.govOrderStarted) then
        SendNUIMessage({type = "show_orders", status = true})
        SetNuiFocus(true, true)
        inordersmenu = true
    end
end)

RegisterKeyMapping('+taxiorders', 'Show Taxi Orders', 'keyboard', 'J')