RegisterNetEvent("uniq-taxi:client:sendAlert")
AddEventHandler("uniq-taxi:client:sendAlert", function()
    local ped = PlayerPedId()
    local position = GetEntityCoords(ped)
    local fposition = {x = position.x, y = position.y, z = position.z}

    QBCore.Functions.TriggerCallback("uniq-taxi:server:addTaxiCall", function() end, fposition)
end)

RegisterCommand("calltaxi", function()
    TriggerEvent("uniq-taxi:client:sendAlert")
end)