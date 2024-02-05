local QBCore = exports['qb-core']:GetCoreObject()

-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil
local inStash = false
local inTrash = false
local inArmoury = false
local inHelicopter = false
local inImpound = false
local inGarage = false

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function SetCarItemsInfo()
	local items = {}
	for _, item in pairs(Config.CarItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end

    Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

function TakeOutImpound(vehicle)
    local coords = Config.Locations["impound"][currentGarage]
    if coords then
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
		SetVehicleDirtLevel(veh, 0.0)
                SetEntityHeading(veh, coords.w)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('police:server:TakeOutImpound', vehicle.plate, currentGarage)
                closeMenuFull()
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, vehicle.vehicle, coords, true)
    end
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    if coords then
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            -- SetCarItemsInfo()
            SetVehicleNumberPlateText(veh, Lang:t('info.police_plate')..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['cdn-fuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            if Config.VehicleSettings[vehicleInfo] ~= nil then
                if Config.VehicleSettings[vehicleInfo].extras ~= nil then
			QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
		end
		if Config.VehicleSettings[vehicleInfo].livery ~= nil then
			SetVehicleLivery(veh, Config.VehicleSettings[vehicleInfo].livery)
		end
            end
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
            SetVehicleEngineOn(veh, true, true)
        end, vehicleInfo, coords, true)
    end
end

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        retval = true
    end
    return retval
end

local function SetWeaponSeries()
    for k, _ in pairs(Config.Items.items) do
        if k < 6 then
            Config.Items.items[k].info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end

function MenuGarage(currentSelection)
    local vehicleMenu = {
        {
            header = Lang:t('menu.garage_title'),
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicle",
                args = {
                    vehicle = veh,
                    currentSelection = currentSelection
                }
            }
        }
    end

    if IsArmoryWhitelist() then
        for veh, label in pairs(Config.WhitelistedVehicles) do
            vehicleMenu[#vehicleMenu+1] = {
                header = label,
                txt = "",
                params = {
                    event = "police:client:TakeOutVehicle",
                    args = {
                        vehicle = veh,
                        currentSelection = currentSelection
                    }
                }
            }
        end
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t('menu.close'),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function MenuImpound(currentSelection)
    local impoundMenu = {
        {
            header = Lang:t('menu.impound'),
            isMenuHeader = true
        }
    }
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify(Lang:t("error.no_impound"), "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = QBCore.Shared.Round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name

                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt =  Lang:t('info.vehicle_info', {value = enginePercent, value2 = currentFuel}),
                    params = {
                        event = "police:client:TakeOutImpound",
                        args = {
                            vehicle = v,
                            currentSelection = currentSelection
                        }
                    }
                }
            end
        end


        if shouldContinue then
            impoundMenu[#impoundMenu+1] = {
                header = Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            exports['qb-menu']:openMenu(impoundMenu)
        end
    end)

end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function(_, cb)
    SetNuiFocus(false, false)
    inFingerprint = false
    cb('ok')
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(_, cb)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
    cb("ok")
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Wait(1000)
    CreateThread(function()
        while isCalling do
            Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['LegacyFuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
           QBCore.Functions.Progressbar('impound', Lang:t('progressbar.impound'), 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'missheistdockssetup1clipboard@base',
                anim = 'base',
                flags = 1,
            }, {
                model = 'prop_notepad_01',
                bone = 18905,
                coords = { x = 0.1, y = 0.02, z = 0.05 },
                rotation = { x = 10.0, y = 0.0, z = 0.0 },
            },{
                model = 'prop_pencil_01',
                bone = 58866,
                coords = { x = 0.11, y = -0.02, z = 0.001 },
                rotation = { x = -120.0, y = 0.0, z = 0.0 },
            }, function() -- Play When Done
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)
                while NetworkGetEntityOwner(vehicle) ~= 128 do  -- Ensure we have entity ownership to prevent inconsistent vehicle deletion
                    NetworkRequestControlOfEntity(vehicle)
                    Wait(100)
                end
                QBCore.Functions.DeleteVehicle(vehicle)
                TriggerEvent('QBCore:Notify', Lang:t('success.impounded'), 'success')
                ClearPedTasks(ped)
            end, function() -- Play When Cancel
                ClearPedTasks(ped)
                TriggerEvent('QBCore:Notify', Lang:t('error.canceled'), 'error')
            end)
        end
    end
end)

RegisterNetEvent('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for _, v in pairs(result) do
                            QBCore.Functions.Notify(''..v..'')
                        end
                    end
                end, playerId)
            else
                QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
            end
        end
    end)
end)

RegisterNetEvent("police:client:VehicleMenuHeader", function (data)
    MenuGarage(data.currentSelection)
    currentGarage = data.currentSelection
end)


RegisterNetEvent("police:client:ImpoundMenuHeader", function (data)
    MenuImpound(data.currentSelection)
    currentGarage = data.currentSelection
end)

RegisterNetEvent('police:client:TakeOutImpound', function(data)
    if inImpound then
        local vehicle = data.vehicle
        TakeOutImpound(vehicle)
    end
end)

RegisterNetEvent('police:client:TakeOutVehicle', function(data)
    if inGarage then
        local vehicle = data.vehicle
        TakeOutVehicle(vehicle)
    end
end)

RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local currentEvidence = data.currentEvidence
    local pos = GetEntityCoords(PlayerPedId())
    local takeLoc = Config.Locations["evidence"][currentEvidence]

    if not takeLoc then return end

    if #(pos - takeLoc) <= 1.0 then
        local drawer = exports['qb-input']:ShowInput({
            header = Lang:t('info.evidence_stash', {value = currentEvidence}),
            submitText = "open",
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'slot',
                    text = Lang:t('info.slot')
                }
            }
        })
        if drawer then
            if not drawer.slot then return end
            TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer.slot}), {
                maxweight = 4000000,
                slots = 500,
            })
            TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer.slot}))
        end
    else
        exports['qb-menu']:closeMenu()
    end
end)

RegisterNetEvent('qb-policejob:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('qb-police:client:scanFingerPrint', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showFingerprint", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('qb-police:client:openArmoury', function()
    local authorizedItems = {
        label = Config.Items.label,
        slots = Config.Items.slots,
        items = {}
    }
    local index = 1
    for _, armoryItem in pairs(Config.Items.items) do
        for i=1, #armoryItem.authorizedJobGrades do
            if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                index = index + 1
            end
        end
    end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
end)

RegisterNetEvent('qb-police:client:spawnHelicopter', function(k)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
    else
        local coords = Config.Locations["helicopter"][k]
        if not coords then coords = GetEntityCoords(PlayerPedId()) end
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            SetVehicleLivery(veh , 0)
            SetVehicleMod(veh, 0, 48)
            SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, Config.PoliceHelicopter, coords, true)
    end
end)

RegisterNetEvent("qb-police:client:openStash", function()
    TriggerServerEvent("qb-police:server:openStash")
    exports.ox_inventory:openInventory("stash", "policestash_" .. QBCore.Functions.GetPlayerData().citizenid)
    -- TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
    -- TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
end)

RegisterNetEvent('qb-police:client:openTrash', function()
    TriggerServerEvent("qb-police:server:openTrash")
    -- TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
    --     maxweight = 4000000,
    --     slots = 300,
    -- })
    -- TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
end)

--##### Threads #####--
local dutylisten = false
local function dutylistener()
    dutylisten = true
    CreateThread(function()
        while dutylisten do
            if PlayerJob.name == "police" then
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("QBCore:ToggleDuty")
                    TriggerServerEvent("police:server:UpdateCurrentCops")
                    TriggerServerEvent("police:server:UpdateBlips")
                    dutylisten = false
                    break
                end
            else
                break
            end
            Wait(0)
        end
    end)
end

-- Personal Stash Thread
local function stash()
    CreateThread(function()
        while true do
            Wait(0)
            if inStash and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
                    TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
                    break
                end
            else
                break
            end
        end
    end)
end

-- Police Trash Thread
local function trash()
    CreateThread(function()
        while true do
            Wait(0)
            if inTrash and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
                        maxweight = 4000000,
                        slots = 300,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Fingerprint Thread
local function fingerprint()
    CreateThread(function()
        while true do
            Wait(0)
            if inFingerprint and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:scanFingerPrint")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Armoury Thread
local function armoury()
    CreateThread(function()
        while true do
            Wait(0)
            if inArmoury and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:openArmoury")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Helicopter Thread
local function heli()
    CreateThread(function()
        while true do
            Wait(0)
            if inHelicopter and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:spawnHelicopter")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Police Impound Thread
local function impound()
    CreateThread(function()
        while true do
            Wait(0)
            if inImpound and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    if IsControlJustReleased(0, 38) then
                        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        break
                    end
                end
            else
                break
            end
        end
    end)
end

-- Police Garage Thread
local function garage()
    CreateThread(function()
        while true do
            Wait(0)
            if inGarage and PlayerJob.name == "police" then
                if PlayerJob.onduty then sleep = 5 end
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    if IsControlJustReleased(0, 38) then
                        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        break
                    end
                end
            else
                break
            end
        end
    end)
end

CreateThread(function()
    -- Toggle Duty
    for k, v in pairs(Config.Locations["duty"]) do
        exports.ox_target:addBoxZone({
            coords = vector3(v.x, v.y, v.z),
            size = vec3(1, 1, 2),
            options = {
                { targetIcon = "fa-solid fa-user-clock" },
                {
                    label = "Влез/Излез На/От Смяна",
                    groups = "police",
                    icon = "fas fa-sign-in-alt",
                    event = "qb-policejob:ToggleDuty",
                    distance = 1.5
                }
            }
        })
    end

    -- Personal Stash
    -- for k, v in pairs(Config.Locations["stash"]) do
    --     exports.ox_target:addBoxZone({
    --         coords = vector3(v.x, v.y, v.z),
    --         size = vec3(1.5, 1.5, 2),
    --         options = {
    --             { targetIcon = "fa-solid fa-box" },
    --             {
    --                 label = "Отвори лично шкафче",
    --                 groups = "police",
    --                 icon = "fas fa-dungeon",
    --                 event = "qb-police:client:openStash",
    --                 distance = 1.5
    --             }
    --         }
    --     })
    -- end

    -- Police Trash
    -- for k, v in pairs(Config.Locations["trash"]) do
    --     exports.ox_target:addBoxZone({
    --         coords = vector3(v.x, v.y, v.z),
    --         size = vec3(1.5, 1.5, 2),
    --         options = {
    --             { targetIcon = "fa-solid fa-box" },
    --             {

    --                 label = "Хвърли боклук",
    --                 groups = "police",
    --                 icon = "fas fa-trash",
    --                 event = "qb-police:client:openTrash",
    --                 distance = 1.5
    --             }
    --         }
    --     })
    -- end

    -- Fingerprint
    for k, v in pairs(Config.Locations["fingerprint"]) do
        exports.ox_target:addBoxZone({
            coords = vector3(v.x, v.y, v.z),
            size = vec3(1.5, 1.5, 2),
            options = {
                { targetIcon = "fa-solid fa-fingerprint" },
                {

                    label = "Вземи пръстов отпечатък",
                    groups = "police",
                    icon = "fas fa-fingerprint",
                    event = "qb-police:client:scanFingerPrint",
                    distance = 1.5
                }
            }
        })
    end
end)
local RadialOption = nil

local HasVehicleOut = false

function EnterGarageZone()
    lib.showTextUI('Паркинг', {
        position = "right-center"
    })

    RadialOption = exports['qb-radialmenu']:AddOption({
        id = 'put_pol_veh',
        title = 'Прибери Автомобил',
        icon = 'blips',
        type = 'client',
        event = 'sp-policejob:client:delete-vehicle',
        shouldClose = true,
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and IsPedInAnyVehicle(PlayerPedId(), false) and Data.job ~= nil and Data.job.name == "police")
        end
    }, RadialOption)
end

function ExitGarageZone()
    lib.hideTextUI()

    exports['qb-radialmenu']:RemoveOption(RadialOption)
end

local box = lib.zones.box({
	name = "PDGarage",
	coords = vec3(438.4, -984.2, 26.0),
	size = vec3(5.55, 32.95, 2.65),
	rotation = 0.0,
    onEnter = EnterGarageZone,
    onExit = ExitGarageZone
})

--------------
local RadialFIXOption = nil

--local HasVehicleOut = false

function EnterFIxZone()
    lib.showTextUI('Поправи МПС', {
        position = "right-center"
    })

    RadialFIXOption = exports['qb-radialmenu']:AddOption({
        id = 'put_pol_veh',
        title = 'Поправи Автомобил',
        icon = 'ped-tool-shop',
        type = 'client',
        event = 'sp-policejob:client:fixCar',
        shouldClose = true,
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and IsPedInAnyVehicle(PlayerPedId(), false) and Data.job ~= nil and Data.job.name == "police")
        end
    }, RadialFIXOption)
end

function ExitFIxZone()
    lib.hideTextUI()
    exports['qb-radialmenu']:RemoveOption(RadialFIXOption)
end

local box = lib.zones.box({
	name = "PoliceFIx",
	coords = vec3(455.0, -973.0, 26.0),
	size = vec3(6.0, 11.0, 3),
	rotation = 0.0,
    onEnter = EnterFIxZone,
    onExit = ExitFIxZone
})
-------------

RegisterNetEvent("sp-policejob:client:delete-vehicle", function()
    if HasVehicleOut == true then
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        TaskLeaveVehicle(PlayerPedId(), car)
        Wait(2000)
        NetworkFadeOutEntity(car, true,false)
        Wait(500)
        QBCore.Functions.DeleteVehicle(car)
        HasVehicleOut = false
    end
end)

RegisterNetEvent('sp-policejob:client:delete-vehicle-money', function()
    if HasVehicleOut == true then
        Wait(2000)
        TriggerServerEvent('sp-policejob:server:removemoney')
        HasVehicleOut = false
    end
end)


function SpawnVehicle(vehName)
    for k, v in pairs(Config.PoliceVehs.SpawnPoints) do
        local isPositionOccupied = IsPositionOccupied(v.x, v.y, v.z, 10, false, true, false, false, false, 0, false)
        if not isPositionOccupied then
            QBCore.Functions.LoadModel(vehName)
            polVeh = CreateVehicle(vehName, v.x, v.y, v.z, v.w, true, true)
        
            local VehiclePlate = GetVehicleNumberPlateText(polVeh)
            local networkID = NetworkGetNetworkIdFromEntity(polVeh)
            SetEntityAsMissionEntity(polVeh)
            SetNetworkIdExistsOnAllMachines(networkID, true)
            NetworkRegisterEntityAsNetworked(polVeh)
            SetNetworkIdCanMigrate(networkID, true)
            SetVehicleDirtLevel(polVeh, 0)
            SetVehicleEngineOn(polVeh, true, true)
            SetVehicleDoorsLocked(polVeh, 1)

            for i = 0, 13 do
                --print(IsVehicleExtraTurnedOn(polVeh, i ), " Before starting")
                SetVehicleExtra(polVeh, i, 0)
                --print(IsVehicleExtraTurnedOn(polVeh, i ), " After starting")
            end

            TriggerEvent("vehiclekeys:client:SetOwner", VehiclePlate)
            exports["cdn-fuel"]:SetFuel(polVeh, 100)

            HasVehicleOut = true

            return
        end
    end

    QBCore.Functions.Notify("Всички паркоместа са блокирани.", "error", 3000)
end

RegisterNetEvent("sp-police:client:vehicle-menu", function()
    local PlyData = QBCore.Functions.GetPlayerData()

    --print("vlizam li?")

    if PlyData.job.name ~= "police" and PlyData.job.name ~= "fbi" then QBCore.Functions.Notify("Не си полицай.", "error", 3000) return end

    local PlyRosterData = lib.callback.await('sp-policejob:server:get-officer-roster-data', false)

    local Menu = {
        id = 'pol-veh-menu',
        title = 'Полицейски Автомобили',
        options = {
            {
                title = 'Върни Автомобил',
                description = 'Връща автомобил ако той не може да бъде прибра, срещу $20',
                icon = 'money-check-dollar',
                event = 'sp-policejob:client:delete-vehicle-money',
            }
        }
    }

    for vehSpawnCode, vehData in pairs(Config.PoliceVehs.Vehicles) do
        if vehData.Job == PlyData.job.name then
            if vehData.RequiredRank ~= nil then
                table.insert(Menu.options, {
                    title = vehData.DisplayName,
                    icon = 'car',
                    arrow = true,
                    disabled = PlyData.job.grade.level < vehData.RequiredRank or HasVehicleOut == true,
                    onSelect = function()
                        SpawnVehicle(vehSpawnCode)
                    end
                })
            elseif vehData.RequiredRoster ~= nil then
                table.insert(Menu.options, {
                    title = vehData.DisplayName,
                    icon = 'car',
                    arrow = true,
                    disabled = PlyRosterData[vehData.RequiredRoster] == false or HasVehicleOut == true,
                    onSelect = function()
                        SpawnVehicle(vehSpawnCode)
                    end
                })
            end
        end
    end

    lib.registerContext(Menu)
    lib.showContext('pol-veh-menu')
end)

RegisterNetEvent("sp-policejob:client:411", function(plyName, message)
    local Player = QBCore.Functions.GetPlayerData()

    if Player.job.name == "police" then 
        TriggerEvent('chat:addMessage', {
            color = "blue",
            multiline = true,
            args = {'411 | '.. plyName, message}
        })
    end
end)

RegisterNetEvent("sp-policejob:client:611", function(plyName, message)
    local Player = QBCore.Functions.GetPlayerData()

    if Player.job.name == "police" or Player.job.name == "lawyer" then 
        TriggerEvent('chat:addMessage', {
            color = "blue",
            multiline = true,
            args = {'611 | '.. plyName, message}
        })
    end
end)

CreateThread(function()
    exports.ox_target:addGlobalPlayer({
        {
            name = 'lawyer_check',
            icon = 'fa-solid fa-money-check',
            label = 'Дай Адвокатски Чек',
            distance = 1.5,
            groups = "police",
            onSelect = function(data)
                print(data)
                local player, distance = QBCore.Functions.GetClosestPlayer()

                if distance <= 2 and player ~= -1 then
                    local plyId = GetPlayerServerId(player)

                    local alert = lib.alertDialog({
                        header = 'Адвокатски Чек',
                        content = 'Сигурени ли сте, че искате да дадете адвокатски чек на гражданин с Щатско ID: ' .. plyId .. "?",
                        centered = true,
                        cancel = true
                    })

                    if alert == "confirm" then
                        TriggerServerEvent("sp-policejob:server:give-lawyer-check", plyId)
                    end
                end
            end
        }
    })
end)