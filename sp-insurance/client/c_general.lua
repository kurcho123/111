local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()
local employees = nil

-- =========== View cardOpen Events ================ -
RegisterNetEvent('sp-insurance:Client:viewHealthInsurance')
AddEventHandler('sp-insurance:Client:viewHealthInsurance',
    function(citizenID, citizenName, insuranceDate, insuranceExpire)
        if Config.Utility.MakeAnimation then
            --exports['rpemotes']:EmoteCommandStart(Config.Utility.Animation)
        end
        cardOpen = true
        SendNUIMessage({
            display = "viewHealthInsurance",
            citizenID = citizenID, citizenName = citizenName,
            insuranceDate = insuranceDate, insuranceExpire = insuranceExpire
        })
end)

RegisterNetEvent('sp-ambulance:client:closeUI', function()
    cardOpen = false
    SendNUIMessage({
        action = "close"
    })
end)

CreateThread(function()
    while true do
        Wait(0)
            if IsControlJustPressed(0, 177) then
                TriggerEvent('sp-ambulance:client:closeUI')
            end
    end
end)

-- =========== HEALTH INSURANCE ================ -
local PedsHealth = Config.Health.Peds
CreateThread(function()
    for _, item in pairs(PedsHealth) do
        RequestModel(item.hash)
        while not HasModelLoaded(item.hash) do
            Wait(100)
        end
        if item.ped == nil then
            item.ped = CreatePed(item.type, item.hash, item.vector4, item.a, false, true)
            SetBlockingOfNonTemporaryEvents(PedsHealth, true)
            SetPedDiesWhenInjured(item.ped, false)
            SetPedCanPlayAmbientAnims(item.ped, true)
            SetPedCanRagdollFromPlayerImpact(item.ped, false)
            SetEntityInvincible(item.ped, true)
            FreezeEntityPosition(item.ped, true)
        end
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Health.Peds) do
        name = "Health"..k
        exports[Config.Utility.Target]:AddBoxZone(name, vector3(v.vector4.x, v.vector4.y, v.vector4.z), 0.7, 0.5, {
            name= name,
            heading = 250,
            debugPoly = false,
            minZ = v.minZ,
            maxZ = v.maxZ
        }, {
            options = {{ event = "sp-insurance:Client:MenuHealthInsurance", icon = Language["IconHealth"], drawDistance = 2.0, label = Language["LabelHealth"]},
            {
                name = 'VicehospitalCheckin',
                event = "ambulance:client:checkin",
                icon = "fas fa-sign-in-alt",
                label = "Влизане в болницата",
                distance = 3.5,
            },},
            distance = 5.0,
        })
    end
end)

RegisterNetEvent('sp-insurance:Client:MenuHealthInsurance', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)

    local price1 = Config.Health.Prices.One
    local price2 = Config.Health.Prices.Two
    local price3 = Config.Health.Prices.Three

    lib.registerContext({
        id = 'Insurance',
        title = 'Health insurance',
        options = {
            {
                title = Language["xTime"],
                description = Language["InfoxTime"]..price1..Language["Currency"],
                icon = 'check',
                event = "sp-insurance:Client:AplicarHealthInsurance",
                args = 1
            },
            {
                title = Language["2xTime"],
                description = Language["Info2xTime"]..price2..Language["Currency"],
                icon = 'check',
                event = "sp-insurance:Client:AplicarHealthInsurance",
                args = 2
            },
            {
                title = Language["3xTime"],
                description = Language["Info3xTime"]..price3..Language["Currency"],
                icon = 'check',
                event = "sp-insurance:Client:AplicarHealthInsurance",
                args = 3
            },
        }
      })
     
      lib.showContext('Insurance')
end)

RegisterNetEvent('sp-insurance:Client:AplicarHealthInsurance', function(args)
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then 
        return Notify(Language["Dead"], "error", 5000) 
    end

    if IsPedSwimming(playerPed) then 
        return Notify(Language["Water"], "error", 5000) 
    end

    if (args ~= 1 and args ~= 2 and args ~= 3) then 
        return Notify("ERROR", "error", 5000) 
    end

    local cfgT = Config.Time[args]
QBCore.Functions.TriggerCallback('sp-insurance:Server:transformDate', function(cb)
    local charinfo = QBCore.Functions.GetPlayerData().charinfo
    local citizenid = QBCore.Functions.GetPlayerData().citizenid

    local input = lib.inputDialog('HealthInsurance', {
        {type = 'input', label = 'Имена', description = 'Въведете Вашите имена', required = true},
        {type = 'input', label = 'Вашето ЕГН( '..citizenid..' )', description = 'Въведете Вашето ЕГН', required = true}
    })

    if input and input[1] and input[2] then
        local nome = charinfo.firstname..' '..charinfo.lastname
        local citizenid = citizenid
        local date = cb.date
        local expire = cb.dateExpire

        QBCore.Functions.Progressbar("spawn_object", Language["Testing"], 5500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            Wait(Config.Utility.WaitTime)
            Notify(Language['Success'])
            Wait(5000)
            TriggerServerEvent('sp-insurance:Server:HealthInsurance', nome, args, citizenid, date, expire, cb.sDateExpire)
        end, function() -- Cancel
            QBCore.Functions.Notify(Language['error.canceled'], 'error', 5000)
        end)
    else
        QBCore.Functions.Notify('Трябва да попълните всички полета и да подпишете документа', 'error', 3500)
    end   
end, cfgT)
end)

if Config.Commands.Enable then
    RegisterCommand(Config.Commands.Command, function()
        local job = QBCore.Functions.GetPlayerData().job.name
        if Config.Commands.NeedJob == true then
            if job ~= Config.Commands.Job then
                return false
            end
        end
        local veh = QBCore.Functions.GetClosestVehicle()
        local plate = GetVehicleNumberPlateText(veh)
        TriggerServerEvent("sp-insurance:Server:CheckInsurance", plate)
    end)

    RegisterNetEvent('sp-insurance:Client:CheckInsurance', function()
        local job = QBCore.Functions.GetPlayerData().job.name
        if Config.Commands.NeedJob == true then
            if job ~= Config.Commands.Job then
                return false
            end
        end
        local veh = QBCore.Functions.GetClosestVehicle()
        local plate = GetVehicleNumberPlateText(veh)
        TriggerServerEvent("sp-insurance:Server:CheckInsurance", plate)
    end)
end


