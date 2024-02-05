if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetPlayerData()
    return ESX.GetPlayerData()
end

function GetPlayers()
    return ESX.Game.GetPlayers()
end

function GetPlayerIdentifier()
    return GetPlayerData().identifier
end

function GetJobName()
    return GetPlayerData()?.job?.name
end

function GetJobGrade()
    return GetPlayerData()?.job?.grade
end

function SpawnGiveVehicle(model, generatedPlate, playerID, playerName, vehicleType, addcommand)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle)
        if DoesEntityExist(vehicle) then
            local carExist = true
            SetEntityVisible(vehicle, false)
            SetEntityCollision(vehicle, false)

            local newPlate = generatedPlate
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
            vehicleProps.plate = newPlate
            TriggerServerEvent('advancedgarages:server:setVehicle', vehicleProps, model, playerID, vehicleType, addcommand)
        end
    end)
end

function SpawnVehicleEvents(vehicle, plate)
    if GetResourceState(Config.Framework .. '-wheelstancer') == 'started' then
        -- You can ignore this, it only works with tuff-wheelstancer
        TriggerServerCallback('advancedgarages:server:GetStanceValues', function(stance_value)
            if stance_value ~= nil then
                Wait(500)
                local veh = GetVehiclePedIsIn(PlayerPedId())
                TriggerServerEvent('Stancer_sv:LoadStanceValues', stance_value, VehToNet(veh))
            end
        end, plate)
    end
    -- You can add your events here when the vehicle spawns
end

function GetVehiclePropertiesFramework(vehicle)
    return ESX.Game.GetVehicleProperties(vehicle)
end

function SetVehiclePropertiesFramework(vehicle, props)
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function ToggleHud(bool)
    if bool then
        Debug('Event to show the hud [../client/custom/framework/esx.lua line 25]')
    else
        Debug('Event to hide the hud [../client/custom/framework/esx.lua line 27]')
    end
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'error' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'success' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('HelpNotification', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('HelpNotification', false)
    else
        if beep == nil then
            beep = true
        end
        BeginTextCommandDisplayHelp('HelpNotification')
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = text:len() / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
