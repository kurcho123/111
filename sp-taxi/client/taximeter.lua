RegisterCommand("+taximeter", function()
    if LocalPlayer.state.rentedVehicle then
        if taximeterActive == false then
            taximeterActive = true
            SendNUIMessage({action = "taximeter_state", value = "ON"})
            moneyToAdd = 0
            posDistance = 0
            SendNUIMessage({action = "taximeter_earned", value = moneyToAdd})
        elseif taximeterActive == true then
            taximeterActive = false
            SendNUIMessage({action = "taximeter_state", value = "OFF"})
            moneyToAdd = 0
            posDistance = 0
            SendNUIMessage({action = "taximeter_earned", value = moneyToAdd})
        end
    end
end)

RegisterKeyMapping('+taximeter', 'Activate/Deactivate Taximeter', 'keyboard', 'F10')