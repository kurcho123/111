local CurrentInjure = {}
local cam = nil
local xped = nil
local Opened = false
local BUILD = GetGameBuildNumber()
local bleeding = false

RegisterKeyMapping('hudxnp', 'Docnp', 'keyboard', Config.AlwaysOpenHudKey)
RegisterCommand('hudxnp', function()
    SendNUIMessage({  action = "hudAlways" })
end)

RegisterCommand('hudsize', function(source, args)
    if args[1] then 
        SendNUIMessage({  action = "hudSize", size = args[1] })
    end
end)

if Config.UseTarget == true then 
    if not Opened then
        if GetResourceState('ox_target') ~= 'missing' then
            Opened = true
            exports.ox_target:addGlobalPlayer({
                {
                    name = 'health',
                    icon = 'fas fa-medkit',
                    label = 'Медицинско Меню',
                    distance = 1.5,
                    groups = "ambulance",
                    -- canInteract = function(entity)
                    --     return IsPedDeadOrDying(entity)
                    -- end,
                    onSelect = function()
                        Audit()
                    end
                },
            })
        end
    end
end

 
RegisterKeyMapping('doc', 'Doc', 'keyboard', Config.Key)

Audit = function()
    job = false
    if Config.Framework == "ESX" then 
        for k,v in pairs(Config.Jobs) do
            if ESX.PlayerData.job.name == v then 
                job = true
            end
        end
        -- if ESX.PlayerData.job.name ~= Config.Job then 
        --     return
        -- end
    else 
        -- if QBCore.Functions.GetPlayerData().job.name ~= Config.Job then 
        --     return
        -- end
        for k,v in pairs(Config.Jobs) do
            if QBCore.Functions.GetPlayerData().job.name == v then 
                job = true
            end
        end
    end

    if job == false then 
        return
    end

    local ped = GetPedInFront()
    xped = ped

    if ped == 0 then 
        return
    end
     
    dead = IsEntityDead(ped)

    if Config.Framework ~= "ESX" and Config.UsingQbLastStand == true then
        dead = IsEntityPlayingAnim(ped, 'combat@damage@writhe', 'writhe_loop', 3) or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
    end

    if dead then 
        pedHeading = GetEntityHeading(ped)
        pedCoords = GetEntityCoords(ped)
        pedOffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
        cam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', GetEntityCoords(PlayerPedId()), GetEntityRotation(PlayerPedId()), 90.0, false, 2)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 3000, true, false, false)
        SetCamParams(cam, pedCoords.x , pedCoords.y, pedCoords.z + 3.5,  -90.0, 180.0, GetEntityHeading(PlayerPedId()) - 50.0, 43.0557, 1000, 0, 0, 2);    
    end

    Wait(1000)
    local bones = {}
    i = 0
    for k,v in pairs(Config.PlayerBones) do
        local bone = GetPedBoneIndex(ped, v)

        table.insert(bones, {
            bone = bone,
            bid = v,
            coords = GetWorldPositionOfEntityBone(ped, bone),
            label = Config.BoneLabelText[v].Label
        })
        i = i + 1
        local screen_coords, screenX, screenY = GetScreenCoordFromWorldCoord(bones[i].coords.x, bones[i].coords.y, bones[i].coords.z)
        bones[i].screen_coords = screen_coords
        bones[i].screenX = screenX
        bones[i].screenY = screenY
    end
    t_ped = NetworkGetPlayerIndexFromPed(ped)
    t_pid = GetPlayerServerId(t_ped)

    local plyPed = PlayerPedId()

    RequestAnimDict('amb@medic@standing@tendtodead@base')
    while not HasAnimDictLoaded('amb@medic@standing@tendtodead@base') do
        Wait(2)
    end
	TaskPlayAnim(plyPed,"amb@medic@standing@tendtodead@base","base", 6.0, -6.0, -1, 1, 0, 0, 0, 0)

    if Config.Framework == "ESX" then 
        ESX.TriggerServerCallback("sp-ambulance:getPlayerInfo", function(x)
            -- SetNuiFocus(1, 1)
            -- local cachecfg = copyTable(Config)
            -- cachecfg.Functions = nil
            -- SendNUIMessage({  action = "open", data = x, config = cachecfg, bones = bones, dead = dead })
            -- local cachet = {}
            -- injuresOld = x.injures
            -- for k,v in pairs(x.injures) do
            --     table.insert(cachet, k)
            -- end
            -- x.injures = cachet
            -- SetNuiFocus(1, 1)
            -- SendNUIMessage({  action = "checked", data = x, injuresOld = injuresOld,  config = Config.BoneLabelText  })

            
            local cachecfg = copyTable(Config)
            cachecfg.Functions = nil
            cachecfg.GetAlternativeBone = nil
            SetNuiFocus(1, 1)

            ananinami = {}
            for k,v in pairs(x.injures) do
                table.insert(ananinami, {
                    bid = k,
                    count = v
                })
            end
            x.injuresD = ananinami
 
  
            SendNUIMessage({  action = "open", data = x, config = cachecfg, bones = bones, dead = dead })
            local cachet = {}
            injuresOld = x.injures
            for k,v in pairs(x.injures) do
                table.insert(cachet, k)
            end
            x.injures = cachet
            SendNUIMessage({  action = "checked", data = x, injuresOld = injuresOld,  config = Config.BoneLabelText  })    
        end, t_pid)
    else 
        QBCore.Functions.TriggerCallback("sp-ambulance:getplayerinfo", function(x)
            local cachecfg = copyTable(Config)
            cachecfg.Functions = nil
            cachecfg.GetAlternativeBone = nil
            SetNuiFocus(1, 1)
            ananinami = {}
            for k,v in pairs(x.injures) do
                table.insert(ananinami, {
                    bid = k,
                    count = v
                })
            end
            x.injuresD = ananinami
            SendNUIMessage({  action = "open", data = x, config = cachecfg, bones = bones, dead = dead })
            local cachet = {}
            injuresOld = x.injures
            for k,v in pairs(x.injures) do
                table.insert(cachet, k)
            end
            x.injures = cachet
            SendNUIMessage({  action = "checked", data = x, injuresOld = injuresOld,  config = Config.BoneLabelText  })    
        end, t_pid)
    end
end

RegisterCommand('doc', Audit)
RegisterNetEvent('health:audit')
AddEventHandler('health:audit', Audit) 
-- GetBonePosFromCamera = function(bone)

 
DebugThread = function()
    entity = xped
    while true do 
        local bones = {}
        i = 0
        for k,v in pairs(Config.PlayerBones) do
            local bone = GetPedBoneIndex(entity, v)
            table.insert(bones, {
                bone = bone,
                coords = GetWorldPositionOfEntityBone(entity, bone)
            })
            i = i + 1
            -- DrawText3D(bones[i].coords.x, bones[i].coords.y, bones[i].coords.z, bones[i].bone .. " " .. k)
            -- toScreenPosition(bones[i].coords, cam)
            -- WorldToScreen(bones[i].coords.x, bones[i].coords.y, bones[i].coords.z)
        --    print( RaycastBoneToScreen(bones[i].coords))

      
          
        end

        Citizen.Wait(0)
    end 

end



Citizen.CreateThread(function()
    while Config.EnableBleeding do 
        if bleeding == true then
            local inj = tl(CurrentInjure)
            local ped = PlayerPedId()
            inj = inj * Config.BleedingHitDamage
            if inj ~= 0 then 
                inj = inj * Config.BleedingMultiplier
                SetEntityHealth(ped,  GetEntityHealth(ped) - inj)
            end
            
            if Config.DisableSetPlayerHealthRecharge == true then 
                SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
            else 
                SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
            end
        end
       Citizen.Wait(Config.BleedingPerMillisecond)
    end
end)
 
function tl(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function copyTable(original)
    local copy = {}
    for key, value in pairs(original) do
        if type(value) == "table" then
            copy[key] = copyTable(value)
        else
            copy[key] = value
        end
    end
    return copy
end

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdade', function(job)
    QBCore.Functions.GetPlayerData().job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)	 
           if NetworkIsPlayerActive(PlayerId()) then
             SendNUIMessage({ action = "theme", theme = Config.Theme  })
           break
        end
    end
end)

RegisterNetEvent("sp-ambulance:docStatus")
AddEventHandler("sp-ambulance:docStatus", function(status)
    x = {
        ["success"] = function()
            Notify('success', Config.Langs[Config.Lang]["succeed_treat"])
            -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = Config.Langs[Config.Lang]["succeed_treat"] })
            Config.Functions.PlayAnim(Config.Anims["treat"].lib, Config.Anims["treat"].anim)
        end,
        ["wrong"] = function()
            Notify('error', Config.Langs[Config.Lang]["no_item"])
            -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = Config.Langs[Config.Lang]["no_item"] })
            Config.Functions.PlayAnim(Config.Anims["fail"].lib, Config.Anims["fail"].anim)
        end,
        ["no_item"] = function()
            Notify('error', Config.Langs[Config.Lang]["no_item"])
            -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = Config.Langs[Config.Lang]["no_item"] })
            Config.Functions.PlayAnim(Config.Anims["fail"].lib, Config.Anims["fail"].anim)
        end
    }
    x[status]()
end)

 
function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

RegisterNUICallback("close", function(data, cb)
    SetNuiFocus(0, 0)

    local ped = PlayerPedId()
    StopAnimTask(ped, "amb@medic@standing@tendtodead@base", "base", 1.0)

    if cam ~= nil then 
        RenderScriptCams(false, false, 0, true, true, true)
        DestroyCam(cam, true)
        cam = nil
    end
end)

RegisterNUICallback("rev", function(data, cb)
    local ped = PlayerPedId()

    QBCore.Functions.Progressbar('treating-patient', "Съживявате пациента", 20000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "missheistfbi3b_ig8_2",
        anim = "cpr_loop_paramedic",
    }, {}, {}, function()
        Revive(data)
        StopAnimTask(ped, "missheistfbi3b_ig8_2", "cpr_loop_paramedic", 1.0)
    end, function()
        StopAnimTask(ped, "missheistfbi3b_ig8_2", "cpr_loop_paramedic", 1.0)
    end)
end)

RegisterNUICallback("checkTreatment", function(data, cb)
    local canTreat = lib.callback.await('sp-ambulance:canTreat', false, data)

    if canTreat == true then
        local ped = PlayerPedId()
        local pedInFront = GetPedInFront()
        local isPedInFrontDead = IsEntityPlayingAnim(pedInFront, 'combat@damage@writhe', 'writhe_loop', 3) or IsEntityPlayingAnim(pedInFront, 'dead', 'dead_a', 3)

        local animDict = "mini@repair"
        local anim = "fixing_a_ped"

        if isPedInFrontDead then
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
            anim = "machinic_loop_mechandplayer"
        end

        QBCore.Functions.Progressbar('treating-patient', "Лекувате пациента", 20000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = animDict,
            anim = anim
        }, {}, {}, function()
            TaskPlayAnim(ped,animDict,anim, 6.0, -6.0, -1, 1, 0, 0, 0, 0)
            local success = exports['sp-minigame']:SkillBar({5000, 10000}, 20, 1) --SkillBar(duration(milliseconds or table{min(milliseconds), max(milliseconds)}), width%(number), rounds(number))
            if success then
                TriggerServerEvent("sp-ambulance:checkTreatment", data)
            end

            StopAnimTask(ped, animDict, anim, 1.0)
        end, function()
            StopAnimTask(ped, animDict, anim, 1.0)
        end)
    end
 
    SetNuiFocus(0, 0)

    if cam ~= nil then 
        RenderScriptCams(false, false, 0, true, true, true)
        DestroyCam(cam, true)
        cam = nil
    end
end)


RegisterNUICallback("checkItems", function(data, cb)
    if Config.Framework == "ESX" then
        ESX.TriggerServerCallback("sp-ambulance:checkItems", function(x)
            return cb(x)
        end)
    else 
        QBCore.Functions.TriggerCallback("sp-ambulance:checkItems", function(x)
            return cb(x)
        end)
    end
end)

RegisterNUICallback("startTreat", function(data, cb)
    local cachedTreat = data
    if Config.Framework == "ESX" then
        ESX.TriggerServerCallback("sp-ambulance:checkItems", function(items)
            i = 0
            for x,y in pairs(Config.Treatment[cachedTreat.clvl]) do
                if items[y] then 
                    i = i + 1
                end
            end
            if (i == #Config.Treatment[cachedTreat.clvl]) then 
                Config.Functions.TreatingMiniGame(cachedTreat)
            end 
        end)
    else 
        QBCore.Functions.TriggerCallback("sp-ambulance:checkItems", function(items)
            i = 0
            for x,y in pairs(Config.Treatment[cachedTreat.clvl]) do
                if items[y] then 
                    i = i + 1
                end
            end
            if (i == #Config.Treatment[cachedTreat.clvl]) then 
                Config.Functions.TreatingMiniGame(cachedTreat)
            end 
        end)
    
    end
end)
 
RegisterNUICallback("action", function(data, cb)
    pid = data.pid
    SetNuiFocus(0, 0)
    x = {
        ["check"] = function()
            Config.Functions.PlayAnim(Config.Anims["check"].lib, Config.Anims["check"].anim)
            if Config.Framework == "ESX" then
                ESX.TriggerServerCallback("sp-ambulance:getPlayerInfo", function(x)
                    local cachet = {}
                    injuresOld = x.injures
                    for k,v in pairs(x.injures) do
                        table.insert(cachet, k)
                    end
                    x.injures = cachet
                    SetNuiFocus(1, 1)
                    SendNUIMessage({  action = "checked", data = x, injuresOld = injuresOld,  config = Config.BoneLabelText  })
                end, pid)
            else 
                QBCore.Functions.TriggerCallback("sp-ambulance:getPlayerInfo", function(x)
                    local cachet = {}
                    injuresOld = x.injures
                    for k,v in pairs(x.injures) do
                        table.insert(cachet, k)
                    end
                    x.injures = cachet
                    SetNuiFocus(1, 1)
                    SendNUIMessage({  action = "checked", data = x, injuresOld = injuresOld,  config = Config.BoneLabelText  })
                end, pid)
            end
        end,
        ["treat"] = function()
            if Config.EnableFastTreatment == true then 
                if Config.Framework == "ESX" then
                    ESX.TriggerServerCallback("sp-ambulance:fastTreatment", function(x)
                        if x == true then 
                            if Config.FastTreatMiniGame == true then 
                                Config.Functions.FastTreatingMiniGame(pid)
                            else
                                TriggerServerEvent("sp-ambulance:fastTreatPlayer", pid)
                                Notify('success', Config.Langs[Config.Lang]["succeed_treat"])
                                -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = Config.Langs[Config.Lang]["succeed_treat"] })
                            end
                        else 
                            TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = Config.Langs[Config.Lang]["no_money"] })
                        end
                    end, pid)  
                else 
                    QBCore.Functions.TriggerCallback("sp-ambulance:fastTreatment", function(x)
                        if x == true then 
                            if Config.FastTreatMiniGame == true then 
                                Config.Functions.FastTreatingMiniGame(pid)
                            else
                                TriggerServerEvent("sp-ambulance:fastTreatPlayer", pid)
                                Notify('success', Config.Langs[Config.Lang]["succeed_treat"])
                                -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = Config.Langs[Config.Lang]["succeed_treat"] })
                            end
                        else 
                            Notify('error', Config.Langs[Config.Lang]["no_money"])
                            -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = Config.Langs[Config.Lang]["no_money"] })
                        end
                    end, pid)  
                end
            else 
                Notify('error', Config.Langs[Config.Lang]["no_skill"])

                -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = Config.Langs[Config.Lang]["no_skill"] })
            end
        end,
        ["close"] = function() end
    }
    x[data.type]()
end)

if Config.Framework == "ESX" then
    Citizen.CreateThread(function()
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        ESX.PlayerData = ESX.GetPlayerData()
    end)
else 
    Citizen.CreateThread(function()
        while QBCore.Functions.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
    
        QBCore.Functions.PlayerData = QBCore.Functions.GetPlayerData()
    end)
end


RegisterNetEvent("sp-ambulance:updateInjures")
AddEventHandler("sp-ambulance:updateInjures", function(injures, t_pid)
    if injures ~= nil then 
        CurrentInjure = injures
    end

end)

RegisterNetEvent("sp-ambulance:hitRecieve")
AddEventHandler("sp-ambulance:hitRecieve", function(bone, injures)
    CurrentInjure = injures

    local cachet = {}

    for k,v in pairs(CurrentInjure.injures) do
        table.insert(cachet, k)
    end

    SendNUIMessage({ action = "damageTaken", CurrentInjure = cachet, config = Config.BoneLabelText })

    if bleeding == false then 
        bleeding = true
        Notify('error', Config.Langs[Config.Lang]["fail_bleed"])
    end

end)

RegisterNetEvent("sp-ambulance:hitRecieveVuran")
AddEventHandler("sp-ambulance:hitRecieveVuran", function(bone, injures)
    local cachet = {}

    for k,v in pairs(CurrentInjure.injures) do
        table.insert(cachet, k)
    end

    SendNUIMessage({ action = "damageTaken", CurrentInjure = cachet, config = Config.BoneLabelText })
end)

RegisterNetEvent("sp-ambulance:stopBlooding")
AddEventHandler("sp-ambulance:stopBlooding", function()
    bleeding = false
    Notify('success', Config.Langs[Config.Lang]["start_bleeding"])
    Citizen.SetTimeout((Config.StopBleedingTime * 60 * 1000), function()
        if bleeding == false then
            Notify('error', Config.Langs[Config.Lang]["stop_bleeding"])
            bleeding = true
        end
    end)
end)

RegisterNetEvent("sp-ambulance:stop-bleeding-revive")
AddEventHandler("sp-ambulance:stop-bleeding-revive", function()
    bleeding = false
    Notify('success', "Спряхте да кървите...")
end)


AimBool = function(entity, player)
    if Config.OnlyWithAim == true then 
        return (IsEntityAPed(entity) and IsPedShooting(player))
    else
        return IsPedShooting(player)
    end
end

AimBoolFirst = function()
    if Config.OnlyWithAim == true then 
        return IsPlayerFreeAiming(PlayerId())
    else
        return true
    end
end

Citizen.CreateThread(function()                              
    while true do                                           
            local sleepThread = 250                                                                                               
            local player = PlayerPedId()         
            if AimBoolFirst() then   
                sleepThread = 0        
                local entity = getEntity(PlayerId())    
                local hit, coords, entity = RayCastGamePlayCamera(1000.0)
                if AimBool(entity, player) then
                    t_ped = NetworkGetPlayerIndexFromPed(entity)
                    t_pid = GetPlayerServerId(t_ped)
 
                    if t_pid ~= 0 then 
                        bones = {}
                        i = 0
                        for k,v in pairs(Config.PlayerBones) do
                            local bone = GetPedBoneIndex(entity, v)
                            table.insert(bones, {
                                bone = bone,
                                coords = GetWorldPositionOfEntityBone(entity, bone),
                                bid = v
                            })

                            i = i + 1
                            
                            -- DrawText3D(bones[i].coords.x, bones[i].coords.y, bones[i].coords.z, bones[i].bone .. " " .. k)
                        end
                        local position = GetEntityCoords(GetPlayerPed(-1))
                        local hittedbone = GetClosestBone(coords, bones)
                        if hittedbone then                   
                            local exist, weapon = GetCurrentPedWeapon(player)
                            damage = {
                                name = "Unkown",
                                label = "Shot by a gun",
                            }
                            if exist and Config.Weapons[weapon] then 
                                damage = {
                                    name = Config.Weapons[weapon],
                                    label = Config.WeaponsLabel[weapon],
                                }
                            end
                            -- print(hittedbone)

                            TriggerServerEvent('sp-ambulance:hitPlayer', t_pid, hittedbone.bone, damage)
                            -- DrawText3D(coords.x, coords.y, coords.z, hittedbone)
                        end
                        -- DrawLine(position.x, position.y , position.z, coords.x, coords.y, coords.z, 255, 0, 0, 255)

                        if Config.DebugMode == true then 
                            DrawLine(position.x, position.y , position.z, coords.x, coords.y, coords.z, 255, 0, 0, 255)
                        end
                    end
                end
            end
        Citizen.Wait(sleepThread)
    end
end)


RegisterNetEvent("esx:playerLoaded", function()
    Wait(5000)
    for k,v in pairs(Config.PlayerBones) do
        Config.BoneLabelText[v].bid = GetPedBoneIndex(PlayerPedId(), v)
        Config.BoneLabelText[v].value = v
    end
end)
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(5000)
    for k,v in pairs(Config.PlayerBones) do
        Config.BoneLabelText[v].bid = GetPedBoneIndex(PlayerPedId(), v)
        Config.BoneLabelText[v].value = v
    end
end)
 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)	 
        if NetworkIsPlayerActive(PlayerId()) then
            for k,v in pairs(Config.PlayerBones) do
                Config.BoneLabelText[v].bid = GetPedBoneIndex(PlayerPedId(), v)
                Config.BoneLabelText[v].value = v
            end
            break
        end
    end
end)

GetClosestBone = function(aimCoord, bones) 
    local x = false
    local cacheTable = bones

    for k,v in pairs(bones) do
        dists = #(bones[k].coords - aimCoord)
        cacheTable[k].dist = dists
    end

    table.sort(cacheTable, function(a,b) return a.dist < b.dist end)

    -- x = cacheTable[1].bone
    
    return cacheTable[1]
end

DrawText3D = function(x, y, z, text)
    if Config.DebugMode == false then 
        return
    end
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
 
function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end
 

function getEntity(player)                                          
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)     
    return entity                                                   
end
 
 
AddEventHandler('playerSpawned', function(spawn)
    if Config.RemoveInjuresWhenRevive == true then 
        CurrentInjure = {}
        TriggerServerEvent('sp-ambulance:removeAllInjures')
    end
end)


function CameraTransition(cam, startPos, endPos, duration)
    local startTime = GetGameTimer()
    local endTime = startTime + duration

    while GetGameTimer() < endTime do
        local progress = (GetGameTimer() - startTime) / duration
        local currentPos = LerpVector3(startPos, endPos, progress)

        SetCamCoord(cam, currentPos.x, currentPos.y, currentPos.z)

        Citizen.Wait(0)
    end

    SetCamCoord(cam, endPos.x, endPos.y, endPos.z)
end

function LerpVector3(startPos, endPos, progress)
    local x = Lerp(startPos.x, endPos.x, progress)
    local y = Lerp(startPos.y, endPos.y, progress)
    local z = Lerp(startPos.z, endPos.z, progress)

    return vector3(x, y, z)
end

function Lerp(startValue, endValue, progress)
    return startValue + (endValue - startValue) * progress
end

RegisterNetEvent("sp-ambulance:dmg")
AddEventHandler("sp-ambulance:dmg", function(victim, attacker, attacker_ped, victim_ped, damage, LastDamagedBone)
    if Config.ExperimentalFeatures == false then return end
    local alt = Config.GetAlternativeBone(LastDamagedBone)
    if alt ~= false and damage then 
        TriggerServerEvent('sp-ambulance:hitPlayer', victim, GetPedBoneIndex(victim_ped, alt), damage)
    end
end)

RegisterNetEvent("gameEventTriggered")
AddEventHandler("gameEventTriggered", function(event, args)
    local playerId = PlayerId()  -- Mevcut oyuncunun ID'si
    local victim = GetPlayerServerId(playerId)  -- Mevcut oyuncunun sunucu ID'si

    if event == "CEventNetworkEntityDamage" and args[1] == playerId then
        local damage = { name = "nd", label = "Not detected!" }
        local i = 1
        local attacker = args[i + 1]

        i = i + 3

        if BUILD >= 2060 then i = i + 1 end
        if BUILD >= 2189 then i = i + 1 end

        i = i + 6

        local vehicleDamageTypeFlag = args[i + 1]

        local attacker_ped = attacker
        attacker = NetworkGetPlayerIndexFromPed(attacker)
        attacker = GetPlayerServerId(attacker)

        if victim == attacker and vehicleDamageTypeFlag == 0 then
            damage = { name = "fdm", label = "Fall Damage" }
        end

        if vehicleDamageTypeFlag ~= 0 and GetVehiclePedIsIn(attacker_ped, false) ~= 0 then
            damage = { name = "veh", label = "Vehicle Damage" }
        end

        if IsPedArmed(attacker_ped, 1) then
            damage = { name = "melee", label = "Melee Damage" }
        else
            damage = { name = "fist", label = "Fist attack" }
        end

        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(playerId)

        if damage.name == "nd" then return end

        -- TriggerEvent("sp-ambulance:dmg", victim, attacker, attacker_ped, playerId, damage, LastDamagedBone)
    end
end)

function GetPlayerInjuries() 
    local pid =  QBCore.Functions.GetPlayerData().source
    
    local injuries = lib.callback.await('sp-ambulance:getplayerinfo', false, pid)

    local ananinami = {}

    for k,v in pairs(injuries.injures) do
        table.insert(ananinami, {
            bid = k,
            count = v
        })
    end

    return ananinami
end

exports("GetPlayerInjuries", GetPlayerInjuries)