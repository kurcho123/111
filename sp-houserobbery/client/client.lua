local HouseData, OffSets = nil, nil
local InsideHouse = false
local ShowingItems = false
local CurrentEvent = {}
local CurrentCops = 0
local CurrentHouse = nil
local LoggedIn = false
local LockersIds = {}
local OtherInteractsIds = {}

-- Reputation robberies locals
local CanStartJob = true

QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    SetTimeout(450, function()
        QBCore.Functions.TriggerCallback("sp-houserobbery:server:get:config", function(ConfigData)
            Config = ConfigData
        end)
        LoggedIn = true
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    LoggedIn = false
end)

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

-- Code

RegisterNetEvent('sp-houserobbery:client:set:door:status')
AddEventHandler('sp-houserobbery:client:set:door:status', function(RobHouseId, bool)
    Config.HouseLocations[RobHouseId]['Opened'] = bool
end)

RegisterNetEvent('sp-houserobbery:client:set:locker:state')
AddEventHandler('sp-houserobbery:client:set:locker:state', function(RobHouseId, LockerId, Type, bool)
    Config.HouseLocations[RobHouseId]['Lockers'][LockerId][Type] = bool
end)

RegisterNetEvent('sp-houserobbery:client:set:extra:state')
AddEventHandler('sp-houserobbery:client:set:extra:state', function(RobHouseId, Id, bool)
    Config.HouseLocations[RobHouseId]['Extras'][Id]['Stolen'] = bool
end)

RegisterNetEvent('sp-houserobbery:server:reset:state')
AddEventHandler('sp-houserobbery:server:reset:state', function(RobHouseId)
    Config.HouseLocations[RobHouseId]['Opened'] = bool
    for k, v in pairs(Config.HouseLocations[RobHouseId]["Lockers"]) do
        v["Opened"] = false
        v["Busy"] = false
    end
    if Config.HouseLocations[RobHouseId]["Extras"] ~= nil then
        for k, v in pairs(Config.HouseLocations[RobHouseId]["Extras"]) do
            v['Stolen'] = false
        end
    end
end)

CreateThread(function()
    while true do
        Wait(4)
        if LocalPlayer.state.isLoggedIn then
            -- local ItemsNeeded = {[1] = {name = QBCore.Shared.Items["advancedlockpick"]["name"], image = QBCore.Shared.Items["advancedlockpick"]["image"]}, [2] = {name = QBCore.Shared.Items["zaglushitel"]["name"], image = QBCore.Shared.Items["zaglushitel"]["image"]}}
            NearRobHouse = false
            for k, v in pairs(Config.HouseLocations) do
                local PlayerCoords = GetEntityCoords(PlayerPedId())
                local Distance = GetDistanceBetweenCoords(PlayerCoords.x ,PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true)
                if Distance < 2.0 then
                    NearRobHouse = true
                    CurrentHouse = k
                    -- if not ShowingItems and not v['Opened'] then
                    --     ShowingItems = true
                    --     TriggerEvent('inventory:client:requiredItems', ItemsNeeded, true)
                    -- end
                end
            end
            if not NearRobHouse then
                -- if ShowingItems then
                --     ShowingItems = false
                --     TriggerEvent('inventory:client:requiredItems', ItemsNeeded, false)
                -- end
                Wait(1500)
                if not InsideHouse then
                    CurrentHouse = nil
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(4)
        if CurrentHouse ~= nil then
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            if not InsideHouse and Config.HouseLocations[CurrentHouse]['Opened'] then
                if ( GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.HouseLocations[CurrentHouse]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Coords']['Z'], true) < 3.0) then
                    lib.showTextUI('[E] - Влез', {
                        position = "right-center",
                        icon = 'house',
                        style = {
                            borderRadius = 0,
                            backgroundColor = '#38a2e5',
                            color = 'white'
                        }
                    })                        
                    if IsControlJustReleased(0, 38) then
                        EnterHouseRobbery()
                    end
                else
                    lib.hideTextUI()
                end
            elseif InsideHouse then
                if OffSets ~= nil then
                    if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.HouseLocations[CurrentHouse]['Coords']['X'] - OffSets.exit.x, Config.HouseLocations[CurrentHouse]['Coords']['Y'] - OffSets.exit.y, Config.HouseLocations[CurrentHouse]['Coords']['Z'] - OffSets.exit.z, true) < 1.4) then
                        lib.showTextUI('[E] - Излез', {
                            position = "right-center",
                            icon = 'house',
                            style = {
                                borderRadius = 0,
                                backgroundColor = '#38a2e5',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            LeaveHouseRobbery()
                        end
                    else
                        lib.hideTextUI()
                    end
                end
            end
        end
    end
end)

function IsRobbingHouse()
    local HouseDataToReturn = CurrentHouse
    if HouseDataToReturn ~= nil then
        return true
    else
        return false
    end
end

RegisterNetEvent('sp-houserobbery:client:lootShkaf', function()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(Config.HouseLocations[CurrentHouse]['Lockers']) do
        if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true) < 1.5) then
            if not Config.HouseLocations[CurrentHouse]['Lockers'][k]['Opened'] and not Config.HouseLocations[CurrentHouse]['Lockers'][k]['Busy'] then
                OpenLocker(k)
            end
        end
    end
end)

RegisterNetEvent('sp-houserobbery:client:lootProp', function()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(Config.HouseLocations[CurrentHouse]['Extras']) do
        if not v['Stolen'] then
            if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true) < 1.7) then
                StealPropItem(k)
            end
        end
    end
end)

local HasItem = false

TriggerEvent('chat:removeSuggestion', '/lockpick')

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(IsAdvanced)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    if CurrentHouse ~= nil and not Config.HouseLocations[CurrentHouse]['Opened'] then
        local hours = GetClockHours()
        if hours >= Config.MinimumTime or hours <= Config.MaximumTime then
            if CurrentCops >= Config.CopsNeeded then
                if IsAdvanced then
                    -- TriggerEvent("ds-lockpick:client:openLockpick", function(success)
                    --     if success then
                    --         LockpickFinish(true)
                    --     else
                    --         if math.random(1,100) <= 40 then
                    --             TriggerServerEvent('QBCore:Server:RemoveItem', 'advancedlockpick', 1)
                    --             TriggerServerEvent('evidence:server:CreateBloodDrop', nil, nil, GetEntityCoords(PlayerPedId()))
                    --             TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['advancedlockpick'], "remove")
                    --             QBCore.Functions.Notify("Ободохте пръста си.", "error")
                    --         end
                    --     end
                    -- end)

                    local success = exports['sp-minigame']:SkillBar({5000, 10000}, 5, 3) --SkillBar(duration(milliseconds or table{min(milliseconds), max(milliseconds)}), width%(number), rounds(number))
                    if success then
                        LockpickFinish(true)
                    else
                        if math.random(1,100) <= 40 then
                            TriggerServerEvent('QBCore:Server:RemoveItem', 'advancedlockpick', 1)
                            TriggerServerEvent('evidence:server:CreateBloodDrop', nil, nil, GetEntityCoords(PlayerPedId()))
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['advancedlockpick'], "remove")
                            QBCore.Functions.Notify("Ободохте пръста си.", "error")
                        end
                    end
                else
                    local success = exports['sp-minigame']:SkillBar({5000, 10000}, 5, 3) --SkillBar(duration(milliseconds or table{min(milliseconds), max(milliseconds)}), width%(number), rounds(number))
                    if success then
                        LockpickFinish(true)
                    else
                        if math.random(1,100) <= 35 then
                            TriggerServerEvent('QBCore:Server:RemoveItem', 'lockpick', 1)
                            TriggerServerEvent('evidence:server:CreateBloodDrop', nil, nil, GetEntityCoords(PlayerPedId()))
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['lockpick'], "remove")
                            QBCore.Functions.Notify("You cut your finger.", "error")
                        end
                    end
                end
            else
                QBCore.Functions.Notify("Изглежда, че не е правилното време, кво ще кажеш?", "inform")
            end
        else
            QBCore.Functions.Notify("Изглежда, че не е правилното време, кво ще кажеш?", "error")
        end
    end
end)

function LockpickFinish(Success)
 if Success then
   local Time = math.random(10000, 15000)
   LockpickAnim(Time)
   QBCore.Functions.Progressbar("lockpick-door123", "Разбивате", Time, false, true, {
       disableMovement = true,
       disableCarMovement = true,
       disableMouse = false,
       disableCombat = true,
   }, {}, {}, {}, function() -- Done
       TriggerServerEvent('sp-houserobbery:server:set:door:status', CurrentHouse, true)
       EnterHouseRobbery()
       StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
   end, function() -- Cancel
       StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
   end)
 else
    QBCore.Functions.Notify("Провали се!", "error")
 end
end

function EnterHouseRobbery()
    local HouseInterior = {}
    local CoordsTable = {x = Config.HouseLocations[CurrentHouse]['Coords']['X'], y = Config.HouseLocations[CurrentHouse]['Coords']['Y'], z = Config.HouseLocations[CurrentHouse]['Coords']['Z'] - Config.ZOffSet}
    OpenDoorAnim()
    InsideHouse = true
    Wait(350)

    local plyData = QBCore.Functions.GetPlayerData()

    TriggerEvent('animations:ToggleCanDoAnims', false)
    if math.random(1, 100) <= 55 and not plyData.job.name == "police" then
        exports['sp-dispatch']:HouseRobbery()
    end
    if Config.HouseLocations[CurrentHouse]['Tier'] == 1 then
        HouseInterior = exports['sp-robberyshells']:HouseRobTierOne(CoordsTable)
    elseif Config.HouseLocations[CurrentHouse]['Tier'] == 2 then
        HouseInterior = exports['sp-robberyshells']:HouseRobTierOne(CoordsTable)
    else
        HouseInterior = exports['sp-robberyshells']:HouseRobTierThree(CoordsTable)
    end
    HouseData, OffSets = HouseInterior[1], HouseInterior[2]

    for k, v in pairs(Config.HouseLocations[CurrentHouse]['Lockers']) do
        local zone = exports.ox_target:addBoxZone({
            coords = vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']),
            size = vec3(2, 2, 2),
            options = {
                { targetIcon = "fa-solid fa-house" },
                {
                    event = "sp-houserobbery:client:lootShkaf",
                    icon = "fas fa-lock",
                    label = "Претърси",
                    distance = 1,
                },
            }
        })

        table.insert(LockersIds, zone)
    end
    if Config.HouseLocations[CurrentHouse]['Extras'] ~= nil then
        for k, v in pairs(Config.HouseLocations[CurrentHouse]['Extras']) do
            if not v['Stolen'] then
                local zone = exports.ox_target:addBoxZone({
                    coords = vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']),
                    size = vec3(2, 2, 2),
                    options = {
                        { targetIcon = "fa-solid fa-house" },
                        {
                            event = "sp-houserobbery:client:lootProp",
                            icon = "fas fa-lock",
                            label = "Вземи",
                            distance = 1
                        },
                    }
                })

                table.insert(LockersIds, zone)
            end
        end
    end
end

function LeaveHouseRobbery()
    OpenDoorAnim()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    TriggerEvent('animations:ToggleCanDoAnims', true)
    exports['sp-robberyshells']:DespawnInterior(HouseData, function()
      SetEntityCoords(PlayerPedId(), Config.HouseLocations[CurrentHouse]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Coords']['Z'])
      DoScreenFadeIn(1000)
      CurrentHouse = nil
      HouseData, OffSets = nil, nil
      InsideHouse = false
      if CurrentEvent ~= nil then
        for k, v in pairs(CurrentEvent) do
            DeleteEntity(v)
        end
        CurrentEvent = {}
      end
    end)

    for k, v in pairs(LockersIds) do
        exports.ox_target:removeZone(v)
    end

    LockersIds = {}
end

function StealPropItem(Id)
   local StealObject = GetClosestObjectOfType(Config.HouseLocations[CurrentHouse]['Extras'][Id]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Extras'][Id]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Extras'][Id]['Coords']['Z'], 5.0, GetHashKey(Config.HouseLocations[CurrentHouse]['Extras'][Id]['PropName']), false, false, false)
   NetworkRequestControlOfEntity(StealObject)
   DeleteEntity(StealObject)
   TriggerServerEvent('sp-houserobbery:server:recieve:extra', CurrentHouse, Id)
end

function OpenLocker(LockerId)
    local Time = math.random(5000, 8000)
    if not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
    end
    LockpickAnim(Time)
    TriggerServerEvent('sp-houserobbery:server:set:locker:state', CurrentHouse, LockerId, 'Busy', true)
    QBCore.Functions.Progressbar("lockpick-locker", "Претърсвате шкафчето", Time, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
    }, {}, {}, {}, function() -- Done
    local rounds = math.random(2, 4)
    local success = exports['sp-minigame']:SkillBar({7000, 15000}, 5, rounds) --SkillBar(duration(milliseconds or table{min(milliseconds), max(milliseconds)}), width%(number), rounds(number))
    if success then
        if not Config.HouseLocations[CurrentHouse]['Lockers'][LockerId]['Opened'] then
            TriggerServerEvent('sp-houserobbery:server:locker:reward')
            TriggerServerEvent('sp-houserobbery:server:set:locker:state', CurrentHouse, LockerId, 'Busy', false)
            TriggerServerEvent('sp-houserobbery:server:set:locker:state', CurrentHouse, LockerId, 'Opened', true)
            StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
        else
            QBCore.Functions.Notify("Mmmmmm, in the mix...", "error")
            TriggerServerEvent('sp-houserobbery:server:send:log:abuser')
        end
    else
        OpeningSomething = false
        TriggerServerEvent('sp-houserobbery:server:set:locker:state', CurrentHouse, LockerId, 'Busy', false)
        StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    end
    end, function() -- Cancel
        OpeningSomething = false
        TriggerServerEvent('sp-houserobbery:server:set:locker:state', CurrentHouse, LockerId, 'Busy', false)
        StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    end)
end

function LockpickAnim(time)
  time = time / 1000
  local dict = "veh@break_in@0h@p_m_one@"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
  TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
  OpeningSomething = true
  CreateThread(function()
      while OpeningSomething do
          if math.random(1, 50) <= 20 then
            TriggerServerEvent('hud:Server:GainStress', 1)
          end
          TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
          Wait(2000)
          time = time - 2
          if time <= 0 then
              OpeningSomething = false
              StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
          end
      end
  end)
end

function OpenDoorAnim()
 local dict = "anim@heists@keycard@"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
 TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
 Wait(400)
 ClearPedTasks(PlayerPedId())
end

function IsWearingHandshoes()
  local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
  local model = GetEntityModel(PlayerPedId())
  local retval = true
  if model == GetHashKey("mp_m_freemode_01") then
      if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
          retval = false
      end
  else
      if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
          retval = false
      end
  end
  return retval
end

function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end

-- REPUTATION ROBBERIES

lib.callback.register('sp-houserobbery:client:can-start-job', function()
    print(CanStartJob, exports["sp-blackmarket-encrypted"]:CanPlayerInteract("isRobber", true), CurrentCops >= Config.CopsNeeded)
    return CanStartJob and exports["sp-blackmarket-encrypted"]:CanPlayerInteract("isRobber", true) and CurrentCops >= Config.CopsNeeded
end)

function HackTokis(tokisId)
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    local tokisLocationInfo = jobData.TokisLocations[tokisId]

    if not tokisLocationInfo.IsBeingHacked and not tokisLocationInfo.IsHacked then
        TriggerServerEvent("sp-houserobbery:server:update-tokis-location", true, true, tokisId)
        QBCore.Functions.Progressbar('hacking_tokis', "Свързвате устройствата си", 10000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@heists@prison_heiststation@cop_reactions',
            anim = 'cop_b_idle',
        }, {}, {}, function()
            local success = exports['sp-minigame']:SkillCheck(50, 5000, {'w','a','s','w','l','k','n','b'}, 1, 20, 3) --SkillCheck(speed(milliseconds), time(milliseconds), keys(string or table), rounds(number), bars(number), safebars(number))
            if success then
                tokisLocationInfo.HacksDone = tokisLocationInfo.HacksDone + 1
                TriggerServerEvent("sp-houserobbery:server:update-tokis-location-hacks", tokisId)

                if tokisLocationInfo.HacksDone == tokisLocationInfo.HacksAmount then
                    TriggerServerEvent("sp-houserobbery:server:update-tokis-location", false, true, tokisId)
                    TriggerServerEvent("sp-houserobbery:server:activate-generator")
                end

                TriggerServerEvent("sp-houserobbery:server:update-tokis-location", true, false, tokisId)
            else
                TriggerServerEvent("sp-houserobbery:server:update-tokis-location", true, false, tokisId)
            end
        end, function()
            TriggerServerEvent("sp-houserobbery:server:update-tokis-location", true, false, tokisId)
        end)
    else
        QBCore.Functions.Notify("Тази локация е заета или хакната...", 'error', 5000)
    end
end

function HackGenerator()
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    local generatorInfo = jobData.MainGenerator

    if not generatorInfo.IsBeingHacked and not generatorInfo.IsHacked and jobData.CanHackGenerator then
        TriggerServerEvent("sp-houserobbery:server:update-main-generator", true, true)
        QBCore.Functions.Progressbar('hacking_tokis', "Свързвате устройствата си", 10000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@heists@prison_heiststation@cop_reactions',
            anim = 'cop_b_idle',
        }, {}, {}, function()
            local number = 0
            if QBCore.Functions.GetPlayerData()["metadata"]["isHacker"] == true then
                if generatorInfo.HacksDone == 0 then
                    number = math.random(1000, 9999)
                elseif generatorInfo.HacksDone == 1 then
                    number = math.random(10000, 99999)
                elseif generatorInfo.HacksDone == 2 then
                    number = math.random(100000, 999999)
                end
            else
                if generatorInfo.HacksDone == 0 then
                    number = math.random(100000, 999999)
                elseif generatorInfo.HacksDone == 1 then
                    number = math.random(1000000, 9999999)
                elseif generatorInfo.HacksDone == 2 then
                    number = math.random(10000000, 99999999)
                end
            end
            exports['sp-minigame']:ShowNumber(number, 3000) --ShowNumber(code(number), time(milliseconds))
            local success = exports['sp-minigame']:KeyPad(number, 5000) --ShowNumber(code(number), time(milliseconds))
            if success then
                generatorInfo.HacksDone = generatorInfo.HacksDone + 1
                TriggerServerEvent("sp-houserobbery:server:update-generator-hacks")

                if generatorInfo.HacksDone == generatorInfo.HacksAmount then
                    TriggerServerEvent("sp-houserobbery:server:activate-door")
                    TriggerServerEvent("sp-houserobbery:server:update-main-generator", false, true)
                end

                TriggerServerEvent("sp-houserobbery:server:update-main-generator", true, false)
            else
                TriggerServerEvent("sp-houserobbery:server:update-main-generator", true, false)
            end
        end, function()
            TriggerServerEvent("sp-houserobbery:server:update-main-generator", true, false)
        end)
    else
        QBCore.Functions.Notify("Генераторът вече се хаква или не може да бъде достъпен в момента.", 'error', 10000)
    end
end

function StealPropItemReputation(Id)
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    local StealObject = GetClosestObjectOfType(jobData['Extras'][Id]['Coords']['X'], jobData['Extras'][Id]['Coords']['Y'], jobData['Extras'][Id]['Coords']['Z'], 5.0, GetHashKey(jobData['Extras'][Id]['PropName']), false, false, false)
    NetworkRequestControlOfEntity(StealObject)
    DeleteEntity(StealObject)
    TriggerServerEvent('sp-houserobbery:server:recieve-extra', groupId, Id)
end
 
function OpenLockerReputation(LockerId)
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    local Time = math.random(10000, 15000)
     if not IsWearingHandshoes() then
         TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
     end
     LockpickAnim(Time)
     TriggerServerEvent('sp-houserobbery:server:set-locker-state', groupId, LockerId, 'Busy', true)
     QBCore.Functions.Progressbar("lockpick-locker", "Претърсвате шкафчето", Time, false, true, {
     disableMovement = true,
     disableCarMovement = true,
     disableMouse = false,
     disableCombat = true,
     }, {}, {}, {}, function() -- Done
     local rounds = math.random(3, 5)
     local success = exports['sp-minigame']:SkillBar({5000, 10000}, 5, rounds) --SkillBar(duration(milliseconds or table{min(milliseconds), max(milliseconds)}), width%(number), rounds(number))
     if success then
         if not jobData['Lockers'][LockerId]['Opened'] then
            TriggerServerEvent('sp-houserobbery:server:set-locker-state', groupId, LockerId, 'Busy', false)
            TriggerServerEvent('sp-houserobbery:server:set-locker-state', groupId, LockerId, 'Opened', true)
            TriggerServerEvent('sp-houserobbery:server:locker-reward')
            StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
         else
             QBCore.Functions.Notify("Mmmmmm, in the mix...", "error")
             TriggerServerEvent('sp-houserobbery:server:send:log:abuser')
         end
     else
         OpeningSomething = false
         TriggerServerEvent('sp-houserobbery:server:set-locker-state', groupId, LockerId, 'Busy', false)
         StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
     end
     end, function() -- Cancel
         OpeningSomething = false
         TriggerServerEvent('sp-houserobbery:server:set-locker-state', groupId, LockerId, 'Busy', false)
         StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
     end)
end

function LeaveHouseRobberyReputation(exitCoords)
    OpenDoorAnim()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    TriggerEvent('animations:ToggleCanDoAnims', true)
    exports['sp-robberyshells']:DespawnInterior(HouseData, function()
      SetEntityCoords(PlayerPedId(), exitCoords['x'], exitCoords['y'], exitCoords['z'])
      DoScreenFadeIn(1000)
      CurrentHouse = nil
      HouseData, OffSets = nil, nil
      InsideHouse = false
      if CurrentEvent ~= nil then
        for k, v in pairs(CurrentEvent) do
            DeleteEntity(v)
        end
        CurrentEvent = {}
      end
    end)

    for k, v in pairs(LockersIds) do
        exports.ox_target:removeZone(v)
    end
    LockersIds = {}
end

function EnterHouseRobberyReputation()
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)

    if jobData == nil then
        local HouseInterior = {}
        local CoordsTable = {x = jobData.Coords.x, y = jobData.Coords.y, z = jobData.Coords.z - Config.ZOffSet}
        OpenDoorAnim()
        InsideHouse = true
        Wait(350)

        TriggerEvent('animations:ToggleCanDoAnims', false)
        if math.random(1, 100) <= 55 then
            exports['sp-dispatch']:HouseRobbery()
        end

        HouseInterior = exports['sp-robberyshells']:HouseRobTierThree(CoordsTable) 
        HouseData, OffSets = HouseInterior[1], HouseInterior[2]
    else
        if jobData.CanEnter then
            local HouseInterior = {}
            local CoordsTable = {x = jobData.Coords.x, y = jobData.Coords.y, z = jobData.Coords.z - Config.ZOffSet}
            OpenDoorAnim()
            InsideHouse = true
            Wait(350)
    
            TriggerEvent('animations:ToggleCanDoAnims', false)
            if math.random(1, 100) <= 55 then
                exports['sp-dispatch']:HouseRobbery()
            end
    
            HouseInterior = exports['sp-robberyshells']:HouseRobTierThree(CoordsTable) 
            HouseData, OffSets = HouseInterior[1], HouseInterior[2]
    
            for k, v in pairs(jobData['Lockers']) do
                local zone = exports.ox_target:addBoxZone({
                    coords = vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']),
                    size = vec3(2, 2, 2),
                    options = {
                        { targetIcon = "fa-solid fa-house" },
                        {
                            icon = "fas fa-lock",
                            label = "Претърси",
                            distance = 1,
                            onSelect = function()
                                if not jobData['Lockers'][k]['Opened'] and not jobData['Lockers'][k]['Busy'] then
                                    OpenLockerReputation(k)
                                end
                            end,
                            canInteract = function()
                                local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    
                                if not jobData['Lockers'][k]['Opened'] and not jobData['Lockers'][k]['Busy'] then 
                                    return true
                                end
    
                                return false
                            end
                        },
                    }
                })
    
                table.insert(LockersIds, zone)
            end
            if jobData['Extras'] ~= nil then
                for k, v in pairs(jobData['Extras']) do
                    if not v['Stolen'] then
                        local zone = exports.ox_target:addBoxZone({
                            coords = vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']),
                            size = vec3(2, 2, 2),
                            options = {
                                { targetIcon = "fa-solid fa-house" },
                                {
                                    icon = "fas fa-lock",
                                    label = "Вземи",
                                    distance = 1,
                                    onSelect = function()
                                        if not v['Stolen'] then
                                            StealPropItemReputation(k)
                                        end
                                    end,
                                    canInteract = function()
                                        local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
            
                                        if not jobData['Extras'][k]['Stolen'] then 
                                            return true
                                        end
            
                                        return false
                                    end
                                },
                            }
                        })
    
                        table.insert(LockersIds, zone)
                    end
                end
            end
    
            -- local zone = exports.ox_target:addBoxZone({
            --     coords = jobData['ExitCoords'],
            --     size = vec3(2, 2, 2),
            --     options = {
            --         { targetIcon = "fa-solid fa-house" },
            --         {
            --             icon = "fas fa-right-from-bracket",
            --             label = "Излез",
            --             distance = 1,
            --             onSelect = function()
            --                 LeaveHouseRobberyReputation(jobData['CoordsTable'])
            --             end
            --         },
            --     }
            -- })
        
            -- table.insert(LockersIds, zone)
    
            -- TriggerServerEvent("sp-houserobbery:server:remove-house-blip")
        else
            QBCore.Functions.Notify("Искаш полицаите да те видят ли?", "primary", 5000)
        end
    end
end

function CheckTokisState(tokisId)
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    local tokisLocationInfo = jobData.TokisLocations[tokisId]

    QBCore.Functions.Notify({text = "Статус на тока", caption = "Хакове: " .. tokisLocationInfo.HacksDone .. "/" .. tokisLocationInfo.HacksAmount})
end

function CheckGeneratorState()
    local jobData, groupId = lib.callback.await('sp-houserobbery:server:get-job-data', false)
    local generatorInfo = jobData.MainGenerator

    QBCore.Functions.Notify({text = "Статус на генератора", caption = "Хакове: " .. generatorInfo.HacksDone .. "/" .. generatorInfo.HacksAmount})
end

RegisterNetEvent("sp-houserobbery:client:start-job", function(HouseData)
    for _, tokisInfo in pairs(HouseData.TokisLocations) do
        local zone = exports.ox_target:addBoxZone({
            coords = tokisInfo.Coords,
            size = vector3(1, 1, 3),
            options = {
                { targetIcon = "fa-solid fa-house" },
                {
                    label = "Провери статус",
                    icon = "fas fa-circle-info",
                    distance = 2,
                    onSelect = function()
                        CheckTokisState(_)
                    end
                },
                {
                    label = "Хакни",
                    icon = "fas fa-user-secret",
                    distance = 2,
                    onSelect = function()
                        HackTokis(_)
                    end
                },
            }
        })

        table.insert(OtherInteractsIds, zone)
    end

    local zone = exports.ox_target:addBoxZone({
        coords = HouseData.MainGenerator.Coords,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-house" },
            {
                label = "Провери статус",
                icon = "fas fa-circle-info",
                distance = 2,
                onSelect = CheckGeneratorState
            },
            {
                label = "Хакни",
                icon = "fas fa-user-secret",
                distance = 2,
                onSelect = HackGenerator
            },
        }
    })

    table.insert(OtherInteractsIds, zone)
end)

RegisterNetEvent("sp-houserobbery:client:add-house-enter-point", function(HouseData)
    local zone = exports.ox_target:addBoxZone({
        coords = HouseData.Coords,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-house" },
            {
                label = "Влез",
                icon = "fas fa-right-to-bracket",
                distance = 2,
                onSelect = EnterHouseRobberyReputation
            },
        }
    })

    local zone2 = exports.ox_target:addBoxZone({
        coords = HouseData['ExitCoords'],
        size = vec3(2, 2, 2),
        options = {
            { targetIcon = "fa-solid fa-house" },
            {
                icon = "fas fa-right-from-bracket",
                label = "Излез",
                distance = 1,
                -- onSelect = LeaveHouseRobberyReputation
                onSelect = function()
                    LeaveHouseRobberyReputation(HouseData['CoordsTable'])
                end
            },
        }
    })

    table.insert(OtherInteractsIds, zone)
    table.insert(OtherInteractsIds, zone2)
end)

RegisterNetEvent("sp-houserobbery:client:cooldown-player", function()
    CanStartJob = false
    Citizen.SetTimeout(900000, function()
        CanStartJob = true
    end)
end)

RegisterNetEvent("sp-houserobbery:client:clear-everything", function()
    for k, v in pairs(OtherInteractsIds) do
        exports.ox_target:removeZone(v)
    end

    OtherInteractsIds = {}

    CanStartJob = false
    Citizen.SetTimeout(900000, function()
        CanStartJob = true
    end)
end)

local Items = {
    ["bigtv"] = {
        hashKey = GetHashKey("ex_prop_ex_tv_flat_01"),
        bone = 60309,
        x = -0.05, 
        y = 0.2, 
        z = 0.35,
        rotX = -145.0, 
        rotY = 100.0, 
        rotZ = 0.0,
    },
    ["computer"] = {
        hashKey = GetHashKey("prop_laptop_01a"),
        bone = 60309,
        x = 0.025, 
        y = 0.08, 
        z = 0.255,
        rotX = -45.0, 
        rotY = 290.0, 
        rotZ = 0.0,
    },
    ["microwave"] = {
        hashKey = GetHashKey("prop_micro_01"),
        bone = 60309,
        x = 0.025, 
        y = 0.08, 
        z = 0.255,
        rotX = -145.0, 
        rotY = 290.0, 
        rotZ = 0.0,
    },
}

local isDoingItemAnim = false
local HouseObject = nil
local sleep = 200
CreateThread(function()
    while true do
        if isDoingItemAnim == false then
            for k, v in pairs(Items) do 
                if exports.ox_inventory:Search('count', k) > 0 then
                    isDoingItemAnim = k
                    break
                end
            end

            if HouseObject ~= nil then
                DeleteObject(HouseObject)
                HouseObject = nil
                StopAnimTask(ped, "anim@heists@box_carry@", "idle", 1.0)
            end
        else
            local ped = PlayerPedId()
            RequestAnimDict('anim@heists@box_carry@')
            while not HasAnimDictLoaded('anim@heists@box_carry@') do
                Wait(2)
            end

            if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                sleep = 1
                if HouseObject == nil then 
                    HouseObject = CreateObject(Items[isDoingItemAnim].hashKey, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(HouseObject, ped, GetPedBoneIndex(PlayerPedId(), Items[isDoingItemAnim].bone), Items[isDoingItemAnim].x, Items[isDoingItemAnim].y, Items[isDoingItemAnim].z, Items[isDoingItemAnim].rotX, Items[isDoingItemAnim].rotY, Items[isDoingItemAnim].rotZ, true, true, false, true, 1, true)
                end
            end

            DisableControlAction(0, 21, true)

            if exports.ox_inventory:Search('count', isDoingItemAnim) <= 0 then
                isDoingItemAnim = false

                sleep = 200
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent("sp-drugs:client:start-job", function()
    QBCore.Functions.Notify("Нямаш нищо, което да ми послужи на мен?", "error", 3000)
end)