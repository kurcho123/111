local QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()
local ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()
local ox_inventory = GetResourceState('ox_inventory') == 'started' and exports.ox_inventory

local PlayerData = LocalPlayer.state.isLoggedIn and Config.Functions.PlayerDataClient() -- get player data on resource restart
local loaded = false -- this variable is changed once evidence has been fetched from the server

-- add qb-target to check player ID
-- add health status check

-- evidence tables

local CurrentStatusList = {}
local Evidence, NetEvidence, CarEvidence, EvGrid = {}, {}, {}, {}
local AreaEvidence, CamEvidence, AreaNetEvidence, AreaNetEvidenceCache = {}, {}, {}, {}
local CurrentEvidence, SendPacket = nil, {}

-- random variables

local curserial, curwephash, curslot = LocalPlayer.state.curserial or nil, LocalPlayer.state.curwephash or nil, LocalPlayer.state.curslot or nil
local vehlookup = {}
local gsr, shotAmount, gsrpos, freeaiming, curPlayerId, isfreeaiming, selectedwep, gsrwashoff = 0, 0, false, false, nil, nil, nil, 0 -- gsr related variables
local inmenu, newmenu = false, false
local JustBled = false
local lastdamaged, lastwep, boneindex = nil, nil, nil
local gsrtimeout, bloodtimeout, casingtimeout, impacttimeout, alerttimeout = false, false, false, false, {}
local damagetypes = {[2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [8] = true, [11] = true, [14] = true} -- damage types that produce blood, do not touch unless you have researched the native
local AuthorizedJobs, ActiveLEO, ActiveEMS, ActiveFR = Config.AuthorizedJobs, false, false, false
local inventoryMetadata = Config.Inventory.CustomMetadata.Enabled and Config.Inventory.CustomMetadata.Field or Config.Inventory.Ox and 'metadata' or 'info'
local itemSerial = Config.Inventory.Ox and 'serial' or 'serie'
local itemQuality = Config.Inventory.Ox and 'durability' or 'quality'
local events = {}
local nogloves, cleaningWeapon = false, false

-- flashlight configs

local usingflashlight = false -- do not touch
local curopac = 200 -- opacity of current pickup
local cursize = 0.1
local flashdist = 8 -- distance flashlight reveals evidence
local curdist = 2 -- distance current evidence drop is visible
local areadist = 20 -- distance that evidence is cached, larger radius will decrease preformance but be less 'choppy' moving with a flashlight
local areanetdist = 100 -- distance that evidence attached to networked entities will be cached
local pudist = 1.5 -- distance the player must be within to have a current evidence pickup
local curbucket = 0
local time = nil -- used to compare time

-- Camera Config

local camlim = 20 -- limits how many 3D text tags are drawn by the camera, due to fivem limitations, only 32 tags can be drawn at a time, any more will appear in the top left corner of the screen
local camdist = 10 -- distance camera reveals evidence
local cammin = 2 -- distance evidence has to be away from ped to be tagged
local camopac = 170 -- opacity of evidence markers drawn by camera
local markersize = {
    ['blood'] = 0.045, -- size of blood marker
    ['casing'] = 0.045, -- size of casing marker
    ['fingerprint'] = 0.045, -- size of fingerprint marker
    ['impact'] = 0.030, -- size of impact marker
    ['netimpact'] = 0.030, -- size of net impact marker
    ['netpedimpact'] = 0.045, -- size of net impact marker
    ['tampering'] = 0.030, -- size of tampering marker
    ['fragment'] = 0.045, -- size of vehicle fragment
}

local markercolor = {
    ['blood'] = {r = 214, g = 48, b = 36}, -- blood marker color
    ['casing'] = {r = 97, g = 230, b = 87}, -- casings marker color
    ['fingerprint'] = {r = 67, g = 209, b = 166}, -- fingerprint marker color 
    ['impact'] = {r = 197, g = 197, b = 197}, -- impact marker color
    ['netimpact'] = {r = 197, g = 197, b = 197}, -- net impact marker color
    ['netpedimpact'] = {r = 214, g = 48, b = 36}, -- blood marker color
    ['tampering'] = {r = 197, g = 197, b = 197}, -- tampering marker color
    ['fragment'] = {r = 235, g = 52, b = 213}, -- fragment marker color
}

-------------- initalization ------------------

if PlayerData and PlayerData.job then
    ActiveLEO = AuthorizedJobs.LEO.Check()
    ActiveEMS = AuthorizedJobs.EMS.Check()
    ActiveFR = AuthorizedJobs.FirstResponder.Check()
end

if Config.UseConfigCalibers then
    if Config.Inventory.Ox then -- check calibers
        for k, v in pairs(exports.ox_inventory:Items()) do 
            if v.weapon then 
                local hash = v.hash or joaat(k)

                if not Config.NoCasingWeapon[hash] and GetWeaponDamageType(hash) == 3 then
                    if not Config.Calibers[hash] then print(('Missing caliber for %s, please add to your config or add to No'):format(v.name)) end
                end
            end 
        end
    elseif not Config.Inventory.Ox and Config.Framework.QB then
        for k, v in pairs(QBCore.Shared.Weapons) do 
            if v.weapon then 
                local hash = v.hash or joaat(k)

                if not Config.NoCasingWeapon[hash] and GetWeaponDamageType(hash) == 3 then
                    if not Config.Calibers[hash] then print(('Missing caliber for %s, please add to your config or add to No'):format(v.name)) end
                end
            end 
        end
    end
end


------------- framework startup events -----------------------

function CreatePlayerDataEvents(name)
    RegisterNetEvent(name, function() -- fetch player data on player loaded
        PlayerData = Config.Functions.PlayerDataClient()

        while not next(PlayerData) do
            Wait(1000)
            PlayerData = Config.Functions.PlayerDataClient()
        end

        ActiveLEO = AuthorizedJobs.LEO.Check()
        ActiveEMS = AuthorizedJobs.EMS.Check()
        ActiveFR = AuthorizedJobs.FirstResponder.Check()

        if ActiveLEO or ActiveEMS or ActiveFR then FetchEv() end
    end)
end

if Config.Framework.QB then
    if Config.Inventory.QB then 
        if not QBCore.Shared.Items['filled_evidence_bag'].useable then 
            print('You have not made your Filled Evidence Bag useable in qb-core/shared/items.lua.') 
            print('You will not be able to use the evidence bag to access to the evidence bag menu') 
            print('until you update your shared/items.lua to set the useable field to true for the') 
            print('Filled Evidence Bag item.') 
        end 
    end

    events = {
        ['QBCore:Client:OnPlayerLoaded'] = true,
        ['QBCore:Client:OnPlayerUnload'] = true,
        ['QBCore:Client:OnJobUpdate'] = true,
    }

    for k, v in pairs(QBCore.Shared.Vehicles) do
        vehlookup[v.hash or joaat(k)] = ('%s %s'):format(v.brand, v.name)
        if not v.hash then print(('%s vehicle is missing a hash in your QBShared.Vehicles table, hashed name temporarily'):format(k)) end
    end
elseif Config.Framework.ESX then
    events = {
        ['esx:playerLoaded'] = true,
        ['esx:setJob'] = true,
    }

    if ESX.PlayerLoaded then LocalPlayer.state:set('isLoggedIn', true, false) end
     
    RegisterNetEvent('esx:playerLoaded', function()
        LocalPlayer.state:set('isLoggedIn', true, false)
    end)
elseif Config.Framework.Ox then
    -- wip
elseif Config.Framework.Qbox then
    -- wip
elseif Config.Framework.Standalone then
    events = Config.Framework.CustomUpdateEvents.Client
end

for k, v in pairs(events) do CreatePlayerDataEvents(k) end -- create the event handlers that will update player data on the client

------------------- general functions

function FetchEv()
    TriggerServerEvent('evidence:server:FetchEv')

    while not loaded do Wait(100) end
end

local function DrawText3D(x, y, z, text)
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextOutline(3, 0, 0, 0, 255)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z + .1, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

local function DnaHash(s)
    if not s then return end
    local h = string.gsub(s, '.', function(c)
        return string.format('%02x', string.byte(c))
    end)
    return h
end

function TriggerAlert(name, vehicle)
    if not Config.Alerts.Active then return end
    if not Config.Alerts[name] then return end
    if alerttimeout[name] then return end
    
    local alert = Config.Alerts[name]
    alerttimeout[name] = true

    alert(vehicle)
    alert = nil -- garbage collection

    SetTimeout(Config.Alerts.Timeout, function() alerttimeout[name] = false end)
end

function OpenContext(menu, title)
    if Config.Context.Ox then   
        local convertedMenu = {
            id = 'evmenu',
            title = ('**%s**'):format(title),
            canClose = true,
            options = menu,
        }
        
        lib.registerContext(convertedMenu)

        lib.showContext('evmenu')
    elseif Config.Context.QB then
        exports['qb-ui']:openMenu(menu)
    end
end

function OpenInput(input, title)
    if Config.Context.Ox then
        local userinput = lib.inputDialog(title, input.inputs)

        userinput[input.inputs[1].name] = userinput[1]
        userinput[1] = nil

        return userinput
    elseif Config.Context.QB then
        return exports['qb-ui']:ShowInput(input)
    end
end

local function FetchClosestVehicle(coords)
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = nil
    local closestVehicle = nil

    for k, v in pairs(vehicles) do
        local vehicleCoords = GetEntityCoords(v)
        local distance = #(vehicleCoords - coords)

        if not closestDistance or closestDistance > distance then
            closestVehicle = v
            closestDistance = distance
        end
    end

    return closestVehicle, closestDistance
end

local unsupportedLang = {
    [8] = true,
    [9] = true,
    [10] = true,
    [12] = true,
}

local function GetStreet()
    if Config.Inventory.QSv1 or Config.Inventory.QSv2 and unsupportedLang[GetCurrentLanguage()] then return '' end -- check for unsupported langs when using qs-inventory

    local street = nil
    local pos = GetEntityCoords(ped)

    local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    
    if s2 then
        street = tostring(GetStreetNameFromHashKey(s1)) .. ' | ' .. tostring(GetStreetNameFromHashKey(s2))
    else
        street = tostring(GetStreetNameFromHashKey(s1))
    end

    return street:gsub("%'", "")
end

local function SendEvidence()
    evpack = table.clone(SendPacket)
    SendPacket = {}
    TriggerServerEvent('evidence:server:CreateEvidence', evpack)
end

local function RequestWalking(set)
    if HasAnimSetLoaded(set) then return end
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Wait(10)
    end
end

local function SetGSR(time)
    if not gsrtimeout then
        TriggerEvent('evidence:client:SetStatus', 'gunpowder', time)
        gsrtimeout = true
        SetTimeout(1000, function()
            gsrtimeout = false
        end)
    end
end

local function CheckGloves(checkPed)
    local hands = GetPedDrawableVariation(checkPed, 3)
    local model = GetEntityModel(checkPed)
    local gloves = false

    if Config.NoGloves[model] and Config.NoGloves[model][hands] or (not Config.NoGloves[model] and not Config.Gloves[model] or (Config.Gloves[model] and not Config.Gloves[model][hands])) then
        gloves = true
    end

    return gloves
end

local function CreateEvidence(event, data)
    data.event = event   
    table.insert(SendPacket, table.clone(data))
end

local function CreateVehicleFragment(type, diff)  
	local vehcolor1, vehcolor2 = GetVehicleColours(curveh)
	local plate = GetVehicleNumberPlateText(curveh)
    local vehhash = GetEntityModel(curveh)
    local vehname = nil
    local data = {}

    if Config.Colours[tostring(vehcolor1)] then
		vehcolor = Config.Colours[tostring(vehcolor1)]
    else
		vehcolor = "Unknown"
    end

    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
    local is, groundz = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)

    data.coords = vector3(coords[1], coords[2], groundz + 0.03)

    if vehlookup[vehhash] then
        vehname = vehlookup[vehhash]
    else
        if DoesTextLabelExist(GetDisplayNameFromVehicleModel(vehhash)) then
            vehname = GetLabelText(GetDisplayNameFromVehicleModel(vehhash))
        else
            vehname = ('%s %s'):format(GetMakeNameFromVehicleModel(vehhash), GetDisplayNameFromVehicleModel(vehhash))
            vehname = string.gsub(" "..vehname, "%W%l", string.upper):sub(2)
        end

        vehlookup[vehhash] = vehname
    end

    if type == 'body' then
        data.vehcolor = vehcolor
        if diff > 50 then data.vehname = vehname end
    elseif type == 'engine' then
        data.vehname = vehname
        if diff > 50 then data.plate = Config.Functions.GetPlate(curveh) end
    end

    CreateEvidence('VehicleFragment', data)
end

local function CreateBlood()
    if not IsPedInAnyVehicle(ped) then
        local randX = math.random() + math.random(-1, 1)
        local randY = math.random() + math.random(-1, 1)
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), randX, randY, 0)
        local is, groundz = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
        local coords =  vector3(coords.x, coords.y, groundz + .02)
        CreateEvidence("Blood", {coords = coords})
    else
        local vehseats = GetVehicleModelNumberOfSeats(GetEntityModel(curveh))
        for i = -1, vehseats do
            local occupant = GetPedInVehicleSeat(curveh, i)
            if occupant == ped and i then
                CreateEvidence('CarBlood', {citizenid = PlayerData.citizenid, bloodtype = PlayerData.bloodtype, plate = Config.Functions.GetPlate(curveh) , seat = i + 2})
            end
        end
    end
end

local function DropBulletCasing(weapon, ped)
    local data = {}
    local model = `prop_sgun_casing`
    local offx, offy, offz = -0.2, -0.2, 0.0

    -- check for left/down eject
    if Config.LeftHandEject[weapon] then offx, offy, offz = 0.0, 0.2, 0.0 end
    if Config.DownEject[weapon] then offx, offy, offz = 0.0, 0.0, -0.2 end

    local wep = GetCurrentPedWeaponEntityIndex(ped)

    local wepcoords = GetOffsetFromEntityInWorldCoords(wep, offx, offy, 0.0)

    while not HasModelLoaded(model) do
        Wait(10)
        RequestModel(model)
    end

    local casing = CreateObject(model, wepcoords.x, wepcoords.y, wepcoords.z, true, false, false)
    SetEntityVisible(casing, false)
    SetEntityNoCollisionEntity(casing, ped, false)
    SetEntityNoCollisionEntity(casing, wep, false)
    SetEntityNoCollisionEntity(casing, closetVeh, false)

    local wepvec = GetEntityForwardVector(wep)

    local randX = math.random() + math.random(50, 70)
    local randY = math.random() + math.random(50, 70)

    local randX, randY = randX * 0.1, randY * 0.1

    if Config.LeftHandEject[weapon] then 
        ApplyForceToEntity(casing, 1, (wepvec.x * randX), (wepvec.y * randY), wepvec.z, 0, 0, 0, 0, false, true, true, false, true)
    elseif Config.DownEject[weapon] then
        SetEntityCoords(casing, GetOffsetFromEntityInWorldCoords(wep, 0.0, 0.0, -0.2), true, false, false)
        ApplyForceToEntity(casing, 1, wepvec.x, wepvec.y, -wepvec.z * 3.0, 0, 0, 0, 0, false, true, true, false, true)
    else
        ApplyForceToEntity(casing, 1, (-wepvec.x * randX), (-wepvec.y * randY), -wepvec.z, 0, 0, 0, 0, false, true, true, false, true)
    end

    if Config.Debug.OutlineCasings.enabled then SetEntityDrawOutline(casing, true) end

    ActivatePhysics(casing)

    Wait(500)

    while GetEntitySpeed(casing) > 0.1 do
        Wait(200)
    end

    local createCoords = GetEntityCoords(casing)

    local is, groundz = GetGroundZFor_3dCoord(createCoords.x, createCoords.y, createCoords.z, false) -- set at groundz so casings don't get stuck on top of vehicles
    createCoords = vector3(createCoords.x, createCoords.y, groundz + 0.05)

    data = {
        coords = createCoords,
        curserial = curserial,
        weapon = weapon,
        curwephash = curwephash,
    }
    DeleteEntity(casing)

    CreateEvidence('Casing', data)
end

local function CreateBulletImpact(weapon, ped, impactcoords)
    local ammotype = GetPedAmmoTypeFromWeapon(ped, weapon)
    local wep = GetCurrentPedWeaponEntityIndex(ped)
    local muz = GetEntityBoneIndexByName(wep, 'Gun_Muzzle')       
    local coords = nil

    if muz ~= -1 then
        coords = GetWorldPositionOfEntityBone(wep, muz)
    else
        coords = GetEntityCoords(ped)
    end

    if IsPedDoingDriveby(ped) and #(impactcoords - coords) < 1 then lastdamaged, lastwep, boneindex = nil, nil, nil return end -- this ends the bullet impact creation if the impact is too close to the gun's muzzle while in a vehicle, this is the lazy of fixing weapon impacts while in first person appearing where they pass through the shooter's windshield

    local nrm = (norm(coords - impactcoords)) + impactcoords

    if lastdamaged and weapon == lastwep then
        if IsEntityAPed(lastdamaged) and boneindex then
            local isplayer = false
            if IsPedAPlayer(lastdamaged) then isplayer = GetPlayerServerId(NetworkGetPlayerIndexFromPed(lastdamaged)) end
                
            CreateEvidence('NetworkedPedBulletImpact', {ammotype = ammotype, netid = NetworkGetNetworkIdFromEntity(lastdamaged), boneindex = boneindex, isplayer = isplayer})
        else                
            local offset, normoffset = GetOffsetFromEntityGivenWorldCoords(lastdamaged, impactcoords.x, impactcoords.y, impactcoords.z), GetOffsetFromEntityGivenWorldCoords(lastdamaged, nrm.x, nrm.y, nrm.z)
            CreateEvidence('NetworkedBulletImpact', {ammotype = ammotype, netid = NetworkGetNetworkIdFromEntity(lastdamaged), offset = offset, normoffset = normoffset})
        end

        lastdamaged, lastwep, boneindex = nil, nil, nil
    else
        local data = {ammotype = ammotype, coords = impactcoords, norm = nrm}
        CreateEvidence('BulletImpact', {ammotype = ammotype, coords = impactcoords, norm = nrm})
        lastdamaged, lastwep, boneindex = nil, nil
    end 
end

local function RND10(num)
    return num - (num % 10)
end

local function ImportNeighbor(key)
    if EvGrid[key] then
        for k, v in pairs(EvGrid[key]) do
            local tag = Evidence[k].tag 
            if not Config.Debug.ViewEvidence.enabled and (viewev or not ActiveLEO) then
                tag = Evidence[k].civtag 
            end

            if not (viewev and not Evidence[k].civtag) then
                AreaEvidence[k] = table.clone(Evidence[k])
                AreaEvidence[k].distance = #(pos - Evidence[k].coords)
                AreaEvidence[k].tag = tag
            end    
        end
    end
end

local function GetNeighbors(keypos)
    if not loaded then FetchEv() end

    AreaEvidence = {}

    for i = keypos[1] - 10, keypos[1] + 10, 10 do 
        for k = keypos[2] - 10, keypos[2] + 10, 10 do
            ImportNeighbor(json.encode({i, k}))
        end
    end
end

local CurEvLoopRunning = false

local function CurEvLoop()
    if not CurEvLoopRunning then
        CurEvLoopRunning = true
        CreateThread(function() -- this thread allows police to pick up the currently selected evidence drop and create the evidence bag item
            while CurrentEvidence do
                Wait(0)      
                local pos = GetEntityCoords(ped)
                local coords = nil
                if CurrentEvidence then coords = CurrentEvidence.coords else CurEvLoopRunning = false break end
                local dist = #(pos - CurrentEvidence.coords)
                if dist < curdist then
                    DrawMarker(23, CurrentEvidence.coords.x, CurrentEvidence.coords.y, CurrentEvidence.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cursize, cursize, cursize, CurrentEvidence.color.r, CurrentEvidence.color.g, CurrentEvidence.color.b, curopac, false, false, 2, nil, nil, false)
                    DrawText3D(CurrentEvidence.coords.x, CurrentEvidence.coords.y, CurrentEvidence.coords.z, '~g~G~w~ - ' .. CurrentEvidence.tag)
                    if IsControlJustReleased(0, 47) then
                        local info = {}
                        if CurrentEvidence.evtype == 'casing' then
                            info = {
                                label = 'Използвана Гилза',
                                tracking = CurrentEvidence.evidenceId,
                                type = 'casing',
                                street = GetStreet(),
                                ammolabel = Evidence[CurrentEvidence.evidenceId].caliber,
                                serie = Evidence[CurrentEvidence.evidenceId].serie,
                            }
                        elseif CurrentEvidence.evtype == 'blood' then
                            info = {
                                label = 'Кръвна Проба',
                                tracking = CurrentEvidence.evidenceId,
                                type = 'blood',
                                street = GetStreet(),
                                dnalabel = Evidence[CurrentEvidence.evidenceId].dna,
                                bloodtype = Evidence[CurrentEvidence.evidenceId].bloodtype,
                            }
                        elseif CurrentEvidence.evtype == 'fingerprint' then
                            info = {
                                label = 'Пръстов Отпечатък',
                                tracking = CurrentEvidence.evidenceId,
                                type = 'fingerprint',
                                street = GetStreet(),
                                fingerprint = Evidence[CurrentEvidence.evidenceId].fingerprint,
                            }
                        elseif CurrentEvidence.evtype == 'fragment' then
                            info = {
                                label = 'Фрагмент',
                                tracking = CurrentEvidence.evidenceId,
                                type = 'fragment',
                                street = GetStreet(),
                                vehcolor = Evidence[CurrentEvidence.evidenceId].vehcolor or 'Неразпознат',
                                vehname = Evidence[CurrentEvidence.evidenceId].vehname or 'Неразпознато',
                                plate = Evidence[CurrentEvidence.evidenceId].plate or 'Няма съвпадение',
                            }
                        end                  

                        if CurrentEvidence.evtype ~= 'fingerprint' or not Config.Fingerprints.RequireKit then -- check for fingeprint kit requirement
                            TriggerServerEvent('evidence:server:AddEvidenceToInventory', CurrentEvidence.evidenceId, info)                    
                            AreaEvidence[CurrentEvidence.evidenceId] = nil
                            CurrentEvidence = nil
                            CurEvLoopRunning = false
                        else
                            CreateThread(function()
                                local hasKit, hasTape, hasMikrosil = Config.Functions.SearchInventoryClient('fingerprintkit'), Config.Functions.SearchInventoryClient('fingerprinttape'), Config.Functions.SearchInventoryClient('mikrosil')
                                local startEvidenceId = CurrentEvidence.evidenceId

                                if not hasKit or not (hasTape or hasMikrosil) then
                                    if not hasKit then Config.Functions.Notify('Не разполагате с нищо, за да извлечете този пръстов отпечатък', 'error') end
                                    if not hasTape and not hasMikrosil then Config.Functions.Notify('Не разполагате с нищо, за да извлечете този пръстов отпечатък', 'error') end
                                    return 
                                end

                                Config.Functions.Progressbar("liftprint", "Извличане на пръстов отпечатък...", 5000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = false,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mp_arresting",
                                    anim = "a_uncuff",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasks(ped)

                                    if CurrentEvidence and CurrentEvidence.evidenceId == startEvidenceId and CurEvLoopRunning then
                                        TriggerServerEvent('evidence:server:AddEvidenceToInventory', CurrentEvidence.evidenceId, info)                    
                                        AreaEvidence[CurrentEvidence.evidenceId] = nil
                                        CurrentEvidence = nil
                                        CurEvLoopRunning = false
                                    else
                                        Config.Functions.Notify("Изглежда сте се преместили твърде далеч!", 'error')
                                    end
                                end, function() -- Cancel
                                    ClearPedTasks(ped)
                                end)                              
                            end)
                        end

                        break
                    end
                else
                    CurrentEvidence = nil
                end
            end
            CurEvLoopRunning = false
        end)
    end
end

local function GSRLogic()
    if IsEntityInWater(ped) then 
        gsrwashoff = gsrwashoff + 1
        if IsPedSwimming(ped) then
            gsrwashoff = gsrwashoff + 1
        end
    end 

    if gsrwashoff > 90 then TriggerEvent('evidence:client:SetGSR', false) gsrwashoff = 0 end
end

------------------- event listeners for other scripts         

function handleWeaponPrints(fromLoop, where)
    if not curslot or (fromLoop and GetSelectedPedWeapon(ped) ~= curwephash) then return end -- check if not armed or there is a weapon mismatch when run from the loop, prevents creating prints when restarting without holding the last weapon
    if cleaningWeapon then return end

    TriggerServerEvent('evidence:server:updatelatentevidence', {slot = curslot, nogloves = nogloves, fingerprint = true})
end

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data, bool) -- this listens for events from qb-weapons
    if data and next(data)then    
        curserial = data?.info?.serie
        curwephash = joaat(data.name)
        curslot = data?.slot

        LocalPlayer.state:set('curserial', curserial, false)
        LocalPlayer.state:set('curwephash', curwephash, false)
        LocalPlayer.state:set('curslot', curslot, false)

        handleWeaponPrints()
    else
        curserial = nil
        curwephash = nil
        curslot = nil

        LocalPlayer.state:set('curserial', nil, false)
        LocalPlayer.state:set('curwephash', nil, false)
        LocalPlayer.state:set('curslot', nil, false)
    end
end)

RegisterNetEvent('ox_inventory:currentWeapon', function(data, bool) -- this listens for events from ox_inventory
    if data?.metadata?.serial == curserial then return end

    if data and next(data)then   
        curserial = data?.metadata?.serial
        curwephash = tonumber(data?.hash)
        curslot = data?.slot
        
        handleWeaponPrints()
    else
        curserial = nil
        curwephash = nil
        curslot = nil
    end
end)

RegisterNetEvent('hospital:client:Revive', function() -- listens to the ambulance job script for when the player is revived, and removes any networked impacts from them
    TriggerServerEvent('evidence:server:RemoveNetPedImpacts')
end)

RegisterNetEvent('esx_ambulancejob:revive', function() -- listens to the ambulance job script for when the player is revived, and removes any networked impacts from them
    TriggerServerEvent('evidence:server:RemoveNetPedImpacts')
end)

------ game event handlers

AddEventHandler('CEventGunShotBulletImpact', function(_, shooter, _) -- this event listens for bullet impacts using a base game event
    if not impacttimeout and shooter == ped then

        local is, impactcoords = GetPedLastWeaponImpactCoord(ped)
        impactweap = GetSelectedPedWeapon(ped)

        impacttimeout = true

        SetTimeout(1, function() 
            impacttimeout = false 
        end)

        if not Config.NoImpactWeapon[impactweap] and GetWeaponDamageType(impactweap) == 3 then
            CreateBulletImpact(impactweap, ped, impactcoords)
        end
    end
end)

AddEventHandler('CEventGunShot', function(_, shooter, args) -- this event listens for gun shots using a base game event
    local dist = #(GetEntityCoords(shooter) - GetEntityCoords(ped))
    local checkwep = GetSelectedPedWeapon(shooter)

    if dist < 6.0 then 
        if not Config.NoGSRWeapon[checkwep] then
            if gsr then
                gsr = gsr + 1
                if gsr > Config.GSR.MinShotsStatus then SetGSR(200) end
            else
                gsr = 1
            end
        end
    end

    if not casingtimeout and shooter == ped then
        casingtimeout = true
        local weapon = GetSelectedPedWeapon(ped)
        if not Config.NoGSRWeapon[weapon] and GetWeaponDamageType(weapon) == 3 then
            shotAmount = shotAmount + 1
            if shotAmount > Config.GSR.MinShotsPositive then
                local chance = math.random(0, 100)
                if not Config.GSR.ShootingChance then
                    TriggerEvent('evidence:client:SetGSR', true)
                elseif chance <= Config.GSR.ShootingChance then
                    TriggerEvent('evidence:client:SetGSR', true)
                end
            end
        end
        if not Config.NoCasingWeapon[weapon] then
            local caseveh = GetVehiclePedIsIn(ped, false)
            local casevehmodel = GetEntityModel(caseveh)

            CreateThread(function()
                if IsPedInAnyVehicle(ped) and (not IsThisModelABicycle(casevehmodel) or not IsThisModelABike(casevehmodel)) then
                    local chance = math.random(1, 100)
                    if chance > Config.VehCasingChance then
                        DropBulletCasing(weapon, ped)                         
                    else
                        CreateEvidence('CarCasing', {weapon = weapon, plate = Config.Functions.GetPlate(caseveh), curwephash = curwephash, curserial = curserial})
                    end
                else
                    DropBulletCasing(weapon, ped)                       
                end
            end)
        end

        SetTimeout(1, function() 
            casingtimeout = false 
        end)
    end
end)

-- AddEventHandler('gameEventTriggered', function (name, args) -- listens for network entity damage events for vehicle fragment generation and to assign bullet impacts to network entities
--     if name == 'CEventNetworkEntityDamage' then
--         local victimIsPed = IsEntityAPed(args[1])

--         if args[1] == curveh or args[2] == curveh then
--             local newbody = GetVehicleBodyHealth(curveh)
--             local neweng = GetVehicleEngineHealth(curveh)

--             local diffbody = curbody - newbody
--             local diffeng = cureng - neweng

--             if diffbody > 20 then
--                 CreateVehicleFragment('body', diffbody)
--             end

--             if diffeng > 20 then
--                 CreateVehicleFragment('engine', diffeng)
--             end

--             curbody = newbody
--         end

--         if args[1] ~= ped and args[2] == ped and (args[7] ~= `WEAPON_RUN_OVER_BY_CAR` and args[7] ~= `WEAPON_RAMMED_BY_CAR`) then -- filter for damage done using a vehicle
--             lastdamaged = args[1]
--             lastwep = args[7]

--             if lastdamaged then
--                 if victimIsPed then
--                     local _, bone = GetPedLastDamageBone(lastdamaged)
--                     boneindex = GetPedBoneIndex(lastdamaged, bone)
--                 end
--             end
                
--             if args[7] == `weapon_unarmed` then
--                 if Config.Alerts.Active then TriggerAlert('Melee') end
--             end

--             local victim = args[1]
--             local victimIsPlayer = IsPedAPlayer(victim)
--             local victimId = victimIsPlayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim))
--             local wepcoords = GetEntityCoords(GetCurrentPedWeaponEntityIndex(args[2]))

--             if victimIsPed and args[7] == curwephash and #(GetEntityCoords(args[1]) - wepcoords) < 2.0 then
--                 if IsPedAPlayer(args[1]) then 
--                     TriggerServerEvent('evidence:server:updatelatentevidence', {slot = curslot, blood = true, victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[1]))})
--                 end
--             end

--             --  -- functionality to be built out in future update!
--             --  
--             --  local peds = GetGamePool('CPed')
--             --  local dist = nil
--             --  
--             --  for k, v in pairs(peds) do
--             --      if IsPedAPlayer(v) then
--             --          local dist = #(GetEntityCoords(victim) - GetEntityCoords(v))
--             --  
--             --          if dist < 2.0 then 
--             --              print('closeby', args[7], victim, v)
--             --  
--             --              Config.Functions.Notify('blood splatter on clothes! '..args[7], 'success')
--             --  
--             --              TriggerServerEvent('evidence:server:bloodonclothing', {target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(v)), clothes = GetPedClothing(v), victim = victimId})                              
--             --          end
--             --      end
--             --  end

--         elseif args[1] ~= ped and args[2] == ped and (args[7] == `WEAPON_RUN_OVER_BY_CAR` or args[7] == `WEAPON_RAMMED_BY_CAR`) then
--             -- functionality to be built out in a future update!
--         elseif args[1] == ped and (args[7] == -842959696 or damagetypes[GetWeaponDamageType(args[7])]) and not bloodtimeout then
--             local chance = math.random(0, 100)

--             if chance > Config.Bleed.DamageChance then CreateBlood() end

--             bloodtimeout = true
            
--             SetTimeout(1000, function() 
--                 bloodtimeout = false 
--             end)
--         end
--     elseif name == 'CEventNetworkPlayerEnteredVehicle' and args[1] == curPlayerId then
--         local curveh, seat = GetVehiclePedIsIn(ped), nil
       
--         for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(curveh)) do
--             local occupant = GetPedInVehicleSeat(curveh, i)
--             if occupant == ped and i then
--                 if nogloves then TriggerServerEvent('evidence:server:CreateCarFingerprint', Config.Functions.GetPlate(curveh), location, i + 2) end 
--             end
--         end
--     end
-- end)

-- general events

RegisterNetEvent('evidence:client:SetLoaded', function()
    loaded = true               
end)

RegisterNetEvent('evidence:client:GetBloodInfo', function()
    CreateBlood()
end)

RegisterNetEvent('evidence:client:FetchCarFingerprintSeat', function(plate, location)
    local curveh, seat = GetVehiclePedIsIn(ped), nil

    if curveh and Config.Functions.GetPlate(curveh) == plate then      
        for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(curveh)) do
            local occupant = GetPedInVehicleSeat(curveh, i)
            if occupant == ped and i then
                seat = i + 2
            end
        end
    else
        seat = 'exterior'
    end

    if nogloves then TriggerServerEvent('evidence:server:CreateCarFingerprint', plate, location, seat) end
end)

RegisterNetEvent('evidence:client:notify', function(string, notifytype, position) -- this listens for events from qb-weapons
    lib.notify({
        id = 'evnotify',
        title = string,
        position = position,
        type = notifytype,    
    })
end)

RegisterNetEvent('evidence:client:CreateFingerprint', function(coords)
    local hands = GetPedDrawableVariation(ped, 3)
    local model = GetEntityModel(ped)

    if (Config.NoGloves[model] and Config.NoGloves[model][hands]) or (Config.Gloves[model] and Config.Gloves[model][hands]) then
        TriggerServerEvent('evidence:server:CreateFingerprint', coords or GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.25, 0.0))
    end
end)

RegisterNetEvent('evidence:client:SetBucket', function(plybucket)
    curbucket = plybucket
end)

RegisterNetEvent('evidence:client:CopyEvidence', function(data)
    Config.Functions.Notify((Config.Notification.Clipboard):format(data.text), 'success')
    SendNUIMessage({
        copy = data.text,
        type = 'copy',
    })
end)

RegisterNetEvent('evidence:client:UpdatePlayerID', function(evtable)
    for k, v in pairs(evtable) do
        if NetworkedPedBulletImpacts[k] then
            NetworkedPedBulletImpacts[k].netid = v
        end
    end
end)

-- RegisterNetEvent('evidence:client:accesstool', function(data)
--     local accessing = true
--     local found = Config.Functions.SearchInventoryClient('accesstool')
--     local veh = nil

--     if IsPedInAnyVehicle(ped, false) then return end
--     if not found then return end -- cancel out if no access tool found in inventory

--     if not data then veh = FetchClosestVehicle(pos) else veh = data.entity end

--     if not veh or not data and #(GetEntityCoords(veh) - pos) > 3 then Config.Functions.Notify('Няма превозно средство в близост!', "error") return end -- break function if no nearby vehicle
--     if GetVehicleDoorLockStatus(veh) < 2 then Config.Functions.Notify('Превозното средство е отключено!', "error") return end

-- 	TaskTurnPedToFaceEntity(ped, veh, 1000) Wait(1000)

--     while (not HasAnimDictLoaded("veh@break_in@0h@p_m_one@")) do
--         RequestAnimDict("veh@break_in@0h@p_m_one@")
--         Wait(0)
--     end

--     CreateThread(function()
--         while accessing do
--             TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0) 
--             Wait(1000)
--         end
--     end)

--     if not ActiveFR then if Config.Alerts.Active then TriggerAlert('VehicleTheft', veh) end end

--     Config.Functions.Progressbar("slimjim", "Разбиване на ключалката..", 2500, false, true, {
--         disableMovement = true,
--         disableCarMovement = true,
--         disableMouse = false,
--         disableCombat = true,
--     }, {
-- 		animDict = "veh@break_in@0h@p_m_one@",
-- 		anim = "low_force_entry_ds",
--         flags = 16,
--     }, {}, {}, function() -- Done
--         accessing = false
--         plate = Config.Functions.GetPlate(veh)

-- 		ClearPedTasks(ped)                        

--         TriggerEvent('qb-vehiclekeys:client:UpdateLastPicked', veh)
--         TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
--         NetworkRequestControlOfEntity(veh)
--         SetVehicleDoorsLocked(veh, 1)

--         TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
-- 	    TriggerServerEvent('evidence:server:SetExteriorTamper', true, plate)

--         Config.Functions.Notify(Config.Notification.Unlock, "success")
--         if Config.Consume.AccessTool then TriggerServerEvent('evidence:server:useaccesstool') end
--     end, function() -- Cancel
--         accessing = false

-- 		ClearPedTasks(ped)
--     end)
--     accessing = false
-- end)

------------------- events related to statuses and blood alcohol -------------------------

local function GetClosestPlayer()
    local peds = GetGamePool('CPed')
    local found = -1
    local dist = nil

    for k, v in pairs(peds) do
        if v ~= ped and IsPedAPlayer(v) then
            local founddist = #(GetEntityCoords(ped) - GetEntityCoords(v))

            if not dist or founddist < dist then 
                dist = founddist 
                found = NetworkGetPlayerIndexFromPed(v) 
            end
        end
    end

    return found, dist
end

RegisterNetEvent('police:client:CheckStatus', function() --- this is so qb-radial menu works the same way as the target function   
    Config.Functions.Progressbar("investigating", "Проверка на гражданина..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@board_room@whiteboard@",
        anim = "examine_close_01_amy_skater_01",
        flags = 16,
    }, {}, {}, function() -- Done
        if ActiveFR then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                ClearPedTasks(ped)

                Config.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    local status = ''
                    if result then
                        for k, v in pairs(result) do
                            if status == '' then status = v else status = ("%s, %s"):format(status, v) end
                        end
                    end
                    if status == "" then
                        Config.Functions.Chat({
                            color = { 255, 0, 0},
                            multiline = false,
                            args = {("Не забелязвате нищо необичайно за Граждански номер "), playerId}
                        })
                    else
                        Config.Functions.Chat({
                            color = { 255, 0, 0},
                            multiline = false,
                            args = {("Забелязвате %s: "):format(playerId), status}
                        })
                    end
                end, playerId)
            else
                Config.Functions.Notify(Config.Notification.NoTarget, "error")
            end
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:investigate', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if Config.Debug.PrintTestC.enabled then print(("Investigate event triggered for %s: %s"):format(target, json.encode(data))) end

    Config.Functions.Progressbar("investigating", "Проверка на гражданина..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@board_room@whiteboard@",
        anim = "examine_close_01_amy_skater_01",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)
        
        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerEvent('evidence:client:investigateresult', data)
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end
        
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:investigateresult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    Config.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
        local status = ''
        if result then
            for k, v in pairs(result) do
                if status == '' then status = v else status = ("%s, %s"):format(status, v) end
            end
        end
        if status == "" then
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {("Не забелязвате нищо необичайно за Граждански номер "), playerId}
            })
        else
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {("Забелязвате %s: "):format(playerId), status}
            })
        end
    end, playerId)
end)

if Config.Breathalyzer.Enabled and Config.Breathalyzer.EventTriggers and next(Config.Breathalyzer.EventTriggers) then
    for k, v in pairs(Config.Breathalyzer.EventTriggers) do
        if v.type == 'client' and v.event ~= 'evidence:client:SetStatus' then
            RegisterNetEvent(v.event, function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10)
                local args = {[1] = arg1, [2] = arg2, [3] = arg3, [4] = arg4, [5] = arg5, [6] = arg6, [7] = arg7, [8] = arg8, [9] = arg9, [10] = arg10}

                if Config.Debug.PrintEventTriggerArgs.enabled then
                    local debugArgs = {}

                    for k, v in ipairs(args) do debugArgs[k] = {key = k, value = v} end 

                    print('Debugging Breathalyzer Event Trigger!')
                    print(('Event Name: ^5%s^0'):format(v.event))
                    print(('Current Argument (alcoholArgPos): ^5%s^0'):format(v.alcoholArgPos))
                    print(('Value Found At Argument %s: ^5%s^0'):format(v.alcoholArgPos, type(v.alcoholArgValue) == 'table' and json.encode(args[v.alcoholArgPos], {indent = true}) or args[v.alcoholArgPos]))
                    print(('Value Being Checked Against: ^5%s^0'):format(type(v.alcoholArgValue) == 'table' and json.encode(v.alcoholArgValue, {indent = true}) or v.alcoholArgValue))
                    print(('Args Being Received By Event: ^5{^0'):format(json.encode(debugArgs, {indent = true})))
                    for k, v in pairs(debugArgs) do print(('^5    Argument %s:  %s^0'):format(v.key, type(args[v.value]) == 'table' and json.encode(v.value, {indent = true}) or v.value)) end
                    print('^5}^0')
                end
                
                checkArg = v.alocholArgPos and v.alcoholArgSubfield and args[v.alcoholArgPos] and args[v.alcoholArgPos][v.alcoholArgSubfield] or v.alcoholArgPos and args[v.alcoholArgPos]
                checkValue = v.alcoholArgPos and v.alcoholArgValue and v.alcoholArgValue

                if (not checkArg and not checkValue) or (checkArg and not checkValue) or (checkArg and checkValue and checkArg == checkValue) or (checkArg and type(checkValue) == 'table' and checkValue and checkValue[checkArg]) then
                    TriggerEvent('evidence:client:SetStatus', 'alcohol', 200, type(checkValue[checkArg]) == 'number' and checkValue[checkArg])
                end                
            end)            
        end
    end
end

if Config.Breathalyzer.UsingESX then
    AddEventHandler('esx_status:add', function(name, value)
        if name == 'drunk' then
            TriggerEvent('evidence:client:SetStatus', 'alcohol', 200, 15)
        end
    end)
end

RegisterNetEvent('evidence:client:SetStatus', function(statusId, time, abv)
    if Config.Breathalyzer and (statusId == 'alcohol' or statusId == 'heavyalcohol') then
        TriggerServerEvent('evidence:server:IncreaseBAC', abv or 15) -- increases BAC by .015 or by abv if a third argument is supplied
    end

    if Config.DrugTesting.Enabled and Config.DrugTesting.UsingQBSR and statusId == 'weedsmell' then
        TriggerServerEvent('evidence:server:SetDrugStatus', {drug = 'weed'})
    end

    if time > 0 and Config.StatusList[statusId] then
        if (CurrentStatusList == nil or CurrentStatusList[statusId] == nil) or (CurrentStatusList[statusId] and CurrentStatusList[statusId].time < 20) then
            CurrentStatusList[statusId] = {
                text = Config.StatusList[statusId],
                time = time
            }
            Config.Functions.Notify(''..CurrentStatusList[statusId].text..'')
        end
    elseif Config.StatusList[statusId] then
        CurrentStatusList[statusId] = nil
    end
    TriggerServerEvent('evidence:server:UpdateStatus', CurrentStatusList)
end)


if Config.DrugTesting.Enabled and Config.DrugTesting.EventTriggers then
    for k, v in pairs(Config.DrugTesting.EventTriggers) do
        if v.type == 'client' then
            RegisterNetEvent(v.event, function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10)
                local args = {[1] = arg1, [2] = arg2, [3] = arg3, [4] = arg4, [5] = arg5, [6] = arg6, [7] = arg7, [8] = arg8, [9] = arg9, [10] = arg10}

                if Config.Debug.PrintEventTriggerArgs.enabled then
                    local debugArgs = {}

                    for k, v in ipairs(args) do debugArgs[k] = {key = k, value = v} end 

                    print('Debugging Drug Event Trigger!')
                    print(('Event Name: ^5%s^0'):format(v.event))
                    print(('Current Argument (drugArgPos): ^5%s^0'):format(v.drugArgPos))
                    print(('Value Found At Argument %s: ^5%s^0'):format(v.drugArgPos, type(v.drugArgValue) == 'table' and json.encode(args[v.drugArgPos], {indent = true}) or args[v.drugArgPos]))
                    print(('Value Being Checked Against: ^5%s^0'):format(type(v.drugArgValue) == 'table' and json.encode(v.drugArgValue, {indent = true}) or v.drugArgValue))
                    print(('Args Being Received By Event: ^5{^0'):format(json.encode(debugArgs, {indent = true})))
                    for k, v in pairs(debugArgs) do print(('^5    Argument %s:  %s^0'):format(v.key, type(args[v.value]) == 'table' and json.encode(v.value, {indent = true}) or v.value)) end
                    print('^5}^0')
                end
              
                checkArg = v.drugArgPos and v.drugArgSubfield and args[v.drugArgPos] and args[v.drugArgPos][v.drugArgSubfield] or v.drugArgPos and args[v.drugArgPos]
                checkValue = v.drugArgPos and v.drugArgValue and v.drugArgValue

                if (not checkArg and not checkValue) or (checkArg and not checkValue) or (checkArg and checkValue and checkArg == checkValue) or (checkArg and type(checkValue) == 'table' and checkValue and checkValue[checkArg]) then
                    TriggerServerEvent('evidence:server:SetDrugStatus', {drug = v.drugType, hours = v.positiveTime})
                end                
            end)            
        end
    end
end

RegisterNetEvent('evidence:client:breathalyze', function(data)
    local target = data.target or GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if data.target and data.netid then data.entity = NetworkGetEntityFromNetworkId(data.netid) end

    TriggerServerEvent('evidence:server:notifytarget', target, 'Духате на дрегера')

    if Config.Debug.PrintTestC.enabled then print(("Breathalyzer event triggered for %s: %s"):format(target, json.encode(data))) end

    Config.Functions.Progressbar("breathalyzing", "Използване на дрегера..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = nil,
        anim = nil,
        flags = nil,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerEvent('evidence:client:BACresult', data)
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end    
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:BACresult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    Config.Functions.TriggerCallback('police:GetPlayerBAC', function(result)
        if result ~= "0.0" then
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {"Резултат от дрегера", ("%s Промила %s"):format(playerId, result)}
            })

            local info = {
                result = result,
                street = GetStreet(),
                type = 'bac',
                label = 'Бележка от Дрегера',
            }

            TriggerServerEvent('evidence:server:AddBACToInventory', info)
        else
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {"Резултат от дрегера", ("Граждански номер: %s Промила: 0.0"):format(playerId)}
            })
        end
        
    end, playerId)
end)

RegisterNetEvent('evidence:client:drugtest', function(data)
    local target = data.target or GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if data.target and data.netid then data.entity = NetworkGetEntityFromNetworkId(data.netid) end

    TriggerServerEvent('evidence:server:notifytarget', target, 'Тестват Ви за наркотици')

    if Config.Debug.PrintTestC.enabled then print(("Drug test event triggered for %s: %s"):format(target, json.encode(data))) end

    Config.Functions.Progressbar("drugtesting", "Използване на теста за наркотици..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = nil,
        anim = nil,
        flags = nil,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerEvent('evidence:client:DrugTestResult', data)
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end    
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:DrugTestResult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    Config.Functions.TriggerCallback('police:GetDrugTestResults', function(result)
        local template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br> '
        local count = 1
        local message = {[0] = ("Тест за наркотици (%s)"):format(playerId)}

        for k, v in pairs(Config.DrugTesting.Drugs) do
            template = ('%s<strong>%s:</strong> {%s} <br>'):format(template, v.label, count)
            message[count] = result[k]
            count = count + 1
        end

        template = template .. '</div></div>'

        Config.Functions.Chat({
				template = template,
				args = message
        })

        local description = nil

        if Config.Inventory.Ox then
            for k, v in pairs(result) do
                if description then 
                    description = ('%s  \n **%s:** %s'):format(description, Config.DrugTesting.Drugs[k].label, result[k])
                else
                    description = ('**%s:** %s  \n'):format(Config.DrugTesting.Drugs[k].label, result[k])
                end
            end        
        else
            for k, v in pairs(result) do
                if description then 
                    description = ('%s <p><strong>%s: </strong><span> %s '):format(description, Config.DrugTesting.Drugs[k].label, result[k])
                else
                    description = ('</span></p><p><strong>%s: </strong><span> %s '):format(Config.DrugTesting.Drugs[k].label, result[k])
                end
            end
            
            description = description .. '</span></p>'
        end

        local drugInfo = {
            description = description,
            street = GetStreet(),
            type = 'drugtest',
            label = 'Тест за наркотици',
            player = playerId,
            drugs = result,
        }
        
        TriggerServerEvent('evidence:server:AddDrugTestToInventory', drugInfo)
    end, playerId)
end)

RegisterNetEvent('evidence:client:fingerprint', function(data)
    local target = data.target or GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if data.target and data.netid then data.entity = NetworkGetEntityFromNetworkId(data.netid) end

    local hands, model = GetPedDrawableVariation(data.entity, 3), GetEntityModel(data.entity)

    if not CheckGloves(data.entity) then -- check for gloves
        Config.Functions.Notify(Config.Notification.Gloves, 'error')
        return 
    end

    TriggerServerEvent('evidence:server:notifytarget', target, 'Взимат Ви пръстов отпечатък')

    if Config.Debug.PrintTestC.enabled then print(("Fingerprint event triggered for %s: %s"):format(target, json.encode(data))) end

    Config.Functions.Progressbar("fingerprinting", "Взимане на пръстов отпечатък..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = nil,
        anim = nil,
        flags = nil,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        local targetcoords = GetEntityCoords(data.entity)

        local hands, model = GetPedDrawableVariation(data.entity, 3), GetEntityModel(data.entity)

        if not CheckGloves(data.entity) then -- check for gloves
            Config.Functions.Notify(Config.Notification.GottenGloves, 'error')
            return 
        end

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerServerEvent('evidence:server:fingerprint', {player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)), street = GetStreet()}) -- Triggers a client event called testing:event and sends the argument 'test' with it
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end   
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)


RegisterNetEvent('evidence:client:inspectvehicle', function(data)
    if Config.Debug.PrintTestC.enabled then print(("Inspect vehicle event triggered for %s: %s"):format(Config.Functions.GetPlate(data.entity), json.encode(data))) end

    Config.Functions.Progressbar("inspecting", "Инспектиране на превозното средство..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@board_room@whiteboard@",
        anim = "examine_close_01_amy_skater_01",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)       

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 10 then
            TriggerEvent('evidence:client:inspectvehicleresult', data)
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:inspectvehicleresult', function(data)
    local target = Config.Functions.GetPlate(data.entity)
    local vehseats = GetVehicleModelNumberOfSeats(GetEntityModel(data.entity))
    local occupants = {}
    local status = {}
    local text = nil
    local tamper = nil
    local complete = nil
    local count = 1

    for i = -1, vehseats do
        local occupant = GetPedInVehicleSeat(data.entity, i)

        if occupant and IsPedAPlayer(occupant) then
            occupants[GetPlayerServerId(NetworkGetPlayerIndexFromPed(occupant))] = true
            count = count + 1
        end
    end

    if next(occupants) then
        for k, v in pairs(occupants) do
            Config.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                if result then
                    for k, v in pairs(result) do
                        if not status[k] then
                            if count == 1 then  
                                 status[k] = Config.StatusList[k]
                            else
                                status[k] = Config.CarStatusList[k]
                            end   
                        end
                    end
                end
                occupants[k] = nil
            end, k) 
        end
    end

    while next(occupants) do
        Wait(10)
    end

    if next(status) then
        for k, v in pairs(status) do
            if text then text = ('%s, %s'):format(text, string.lower(v)) else text = v end
        end

        if text then
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {("Проверка на %s:"):format(target), ('Изглежда че са избягали %s'):format(text)}
            })
        end
    end    

    if ActiveLEO then
        Config.Functions.TriggerCallback('police:GetExteriorTampering', function(result)
            if result then
                Config.Functions.Chat({
                    color = { 255, 0, 0},
                    multiline = false,
                    args = {"Проверка на МПС", ("%s изглежда е разбита ключалката"):format(target)}
                })
                tamper = true
            end
            complete = true
        end, target)

        while not complete do
            Wait(10)
        end
    end

    if not tamper and not text then
        Config.Functions.Notify((Config.Notification.NoTamper):format(target))
    end
end)

------------------- GSR events -----------------------------

RegisterNetEvent('evidence:client:SetGSR', function(bool)
    TriggerServerEvent('evidence:server:SetGSR', bool) 
    gsrpos = bool 
end)

RegisterNetEvent('evidence:client:GSRtest', function(data)
    local target = data.target or GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if data.target and data.netid then data.entity = NetworkGetEntityFromNetworkId(data.netid) end

    TriggerServerEvent('evidence:server:notifytarget', target, 'Правят Ви тест за барут')


    if Config.Debug.PrintTestC.enabled then print(("GSR test event triggered for %s: %s"):format(target, json.encode(data))) end

    Config.Functions.Progressbar("gsrtest", "Тестване за барут..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerEvent('evidence:client:GSRresult', data)
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:GSRresult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    Config.Functions.TriggerCallback('police:GetPlayerGSR', function(result)
        if result then
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {"Полеви тест на Барут", ("%s е с положителен резултат"):format(playerId)}
            })

            local info = {
                label = 'Положителен тест за Барут',
                type = 'gsr',
                street = GetStreet(),
            }
            TriggerServerEvent('evidence:server:AddGSRToInventory', info) 
        else
            Config.Functions.Chat({
                color = { 255, 0, 0},
                multiline = false,
                args = {"Полеви тест на Барут", ("%s е с негативен резултат"):format(playerId)}
            })
        end
    end, playerId)
end)

------------------------- events related to DNA and frisks -----------------------------------

RegisterNetEvent('evidence:client:DNAswab', function(data)
    local target = data.target or GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if data.target and data.netid then data.entity = NetworkGetEntityFromNetworkId(data.netid) end

    TriggerServerEvent('evidence:server:notifytarget', target, 'Някой се опитва да ви направи ДНК проба')

    if Config.Debug.PrintTestC.enabled then print(("DNA Swab event triggered for %s: %s"):format(target, json.encode(data))) end

    Config.Functions.Progressbar("dnaswab", "Тестване за ДНК проба..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        local coords = GetEntityCoords(ped)

        ClearPedTasks(ped)

        TriggerServerEvent('evidence:server:AddDNAToInventory', target, GetStreet())
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:frisk', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if Config.Debug.PrintTestC.enabled then print(("Frisk event triggered on %s: %s"):format(target, json.encode(data))) end

    TriggerServerEvent('evidence:server:notifytarget', target, 'Някой се опитва да ви претърси')

    Config.Functions.Progressbar("frisk", "Претърсване на гражданина..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerServerEvent('evidence:server:frisk', target)
        else
            Config.Functions.Notify(Config.Notification.Evading, 'error')                    
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

-- Events that add evidence to evidence tables

AddEvidence = { -- this table contains the functions that create evidence
    Standard = {
        ['casing'] = function(data) 
            local caliber = Config.Functions.GetCaliber(data.weapon)
            local serie = data.serial
        
            if serie then serie = string.upper(serie) else serie = 'Неизвестно' end

            local civtag = ('%s Гилза'):format(caliber)

            if Config.NonCasingWeapon[data.weapon] then civtag = caliber end

            Evidence[data.evidenceId] = {
                evtype = data.evtype,
                bucket = data.bucket,
                caliber = caliber,
                serie = data.serial,
                coords = data.coords,
                tag = ('Гилза %s | Номер %s'):format(serie, data.evidenceId),
                civtag = civtag,
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
                pickup = true,
            }    
        end,
        ['fingerprint'] = function(data) 
            Evidence[data.evidenceId] = {
                evtype = data.evtype,
                bucket = data.bucket,
                fingerprint = data.fingerprint,
                coords = data.coords,
                tag = ('Отпечатък %s | Номер %s'):format(string.upper(data.fingerprint), data.evidenceId),
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
                pickup = true,
            }    
        end,
        ['blood'] = function(data)    
            Evidence[data.evidenceId] = {
                evtype = data.evtype,
                bucket = data.bucket,
                dna = DnaHash(data.citizenid),
                bloodtype = data.bloodtype,
                coords = data.coords,
                tag = ('Кръв %s | Номер %s'):format(string.upper(DnaHash(data.citizenid)), data.evidenceId),
                civtag = 'Пръски кръв',
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
                pickup = true,
            }    
        end,
        ['impact'] = function(data) 
            Evidence[data.evidenceId] = {
                evtype = data.evtype,
                bucket = data.bucket,
                ammotype = data.ammotype,
                coords = data.coords,
                norm = data.norm,
                tag = ('%s Дупка'):format(Config.ImpactLabels[data.ammotype] or 'Неизвестно'),
                civtag = 'Дупка от куршум',
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
            }       
        end,
        ['tampering'] = function(data) 
            Evidence[data.evidenceId] = {
                evtype = data.evtype,
                bucket = data.bucket,
                coords = data.coords,
                tag = 'Доказателства за манипулиране на ключалките',
                civtag = 'Възможна манипулация на ключалката',
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
            }       
        end,
        ['fragment'] = function(data) 
            local fragment = nil
            local civfragment = nil

            if data.vehcolor and data.vehname then
                fragment = ('%s %s Фрагмент | Номер %s'):format(data.vehcolor, data.vehname, data.evidenceId)
                civfragment = ('%s %s Фрагмент'):format(data.vehcolor, data.vehname)
            else
                fragment = ('%s Фрагмент от МПС | Номер %s'):format(data.vehname or data.vehcolor, data.evidenceId)
                civfragment = ('%s Фрагмент от МПС'):format(data.vehname or data.vehcolor)
            end

            Evidence[data.evidenceId] = {
                evtype = data.evtype,
                bucket = data.bucket,
                vehcolor = data.vehcolor,
                vehname = data.vehname,
                plate = data.plate,
                coords = data.coords,
                tag = fragment,
                civtag = civfragment,
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
                pickup = true,
            }    
        end,
    },
    Net = {
        ['netimpact'] = function(data)
            NetEvidence[data.evidenceId] = {
                evtype = data.evtype,
                ammotype = data.ammotype,
                netid = data.netid,
                tag = ('%s Дупка'):format(Config.ImpactLabels[data.ammotype] or 'Неизвестно'),
                civtag = 'Дупка от куршум',
                offset = data.offset,
                norm = data.normoffset,
                model = data.model,
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
            }       
        end,
        ['netpedimpact'] = function(data)
            NetEvidence[data.evidenceId] = {
                evtype = data.evtype,
                ammotype = data.ammotype,
                netid = data.netid,
                boneindex = data.boneindex,
                model = data.model,
                color = markercolor[data.evtype],
                size = markersize[data.evtype],
            }
        end,    
    },
    Car = {
        ['carcasing'] = function(data) 
            local caliber = Config.Functions.GetCaliber(data.weapon)

            CarEvidence[data.plate][data.evidenceId] = {
                evtype = "carcasing",
                type = caliber,
                serial = data.serial or 'Неизвестен',
            }    
        end,
        ['carfingerprint'] = function(data)
            CarEvidence[data.plate][data.evidenceId] = {
            evtype = "carfingerprint",
            fingerprint = data.fingerprint,
            location = data.location,
            }
        end,
        ['carblood'] = function(data)
            CarEvidence[data.plate][data.evidenceId] = {
                evtype = "carblood",
                dna = DnaHash(data.citizenid),
                bloodtype = data.bloodtype,
                seat = data.seat,
            }
        end,    
    },
}

RegisterNetEvent('evidence:client:AddEvidence', function(data)
    for k, v in pairs(data) do
        if Config.Debug.Evidence.enabled then print(('Created %s %s, data as follows: %s'):format(v.evtype, v.evidenceId, json.encode(v))) end

        v.evidenceId = k-- insert evidenceId

        if AddEvidence.Standard[v.evtype] then
            local add = AddEvidence.Standard[v.evtype]
            local rndcoords = json.encode({RND10(v.coords.x), RND10(v.coords.y)})

            add(v)

            Evidence[v.evidenceId].grid = rndcoords

            if EvGrid[rndcoords] then
                EvGrid[rndcoords][v.evidenceId] = true
            else
                EvGrid[rndcoords] = {}
                EvGrid[rndcoords][v.evidenceId] = true
            end
        elseif AddEvidence.Net[v.evtype] then
            local add = AddEvidence.Net[v.evtype]
            add(v)
        elseif AddEvidence.Car[v.evtype] then
            if not CarEvidence[v.plate] then CarEvidence[v.plate] = {} end
            local add = AddEvidence.Car[v.evtype]
            add(v)
        end
    end
end)

RegisterNetEvent('evidence:client:RemoveEvidence', function(data)
    for k, v in pairs(data) do
        if Config.Debug.Evidence.enabled then print(("Removing %s %s, data as follows: %s"):format(v.type, k, json.encode(v))) end
        if not Evidence[k] and not NetEvidence[k] and not (v.plate and v.type ~= 'fragment' and CarEvidence[v.plate] and CarEvidence[v.plate][k]) then print("Attempted to remove evidence that does not exist:", k, json.encode(v)) return end

        if v.plate and CarEvidence[v.plate] and CarEvidence[v.plate][k] then
            CarEvidence[v.plate][k] = nil
        elseif v.net then
            NetEvidence[k] = nil
            AreaNetEvidenceCache[k] = nil

            if data.type == 'netpedimpact' then
                local key = tostring(NetworkGetEntityFromNetworkId(NetEvidence[k].netid))..tostring(NetEvidence[k].boneindex)
                AreaNetEvidenceCache[key] = nil
                AreaNetEvidence[key] = nil
            else
                AreaNetEvidence[k] = nil
            end
        else
            if CurrentEvidence and CurrentEvidence.evidenceId == k then CurrentEvidence = nil end
            if Evidence[k].grid and EvGrid[Evidence[k].grid] and EvGrid[Evidence[k].grid][k] then EvGrid[Evidence[k].grid][k] = nil end
            Evidence[k] = nil
            AreaEvidence[k] = nil
        end
    end
end)

RegisterNetEvent('evidence:client:RemoveCarEvidence', function(plate)
    CarEvidence[plate] = nil
end)

RegisterNetEvent('evidence:client:ClearEvidenceInArea', function()
    Config.Functions.Progressbar('clear_casings', 'Почистване на местопрестъплението...', 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('evidence:server:ClearEvidence', pos)
    end, function() -- Cancel
        Config.Functions.Notify(Config.Notification.CancelEvidenceClear, 'error')
    end)
end)

-------------------- bag evidence menu

RegisterNetEvent('evidence:client:bagevidence', function(inventory)
    local foundWeapon = false

    SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
    TriggerEvent('ox_inventory:disarm')
    TriggerEvent('weapons:client:SetCurrentWeapon', false, false)

    local bagMenu = {
        {
            header = 'Прибиране на доказателства',
            isMenuHeader = true,
        }
    }

    if Config.Context.Ox then bagMenu = {} end

    if Config.Inventory.Ox then weaponList = exports.ox_inventory:Items() end

    for k, v in pairs(inventory) do           
        if v.type == 'weapon' or (Config.Inventory.Ox and weaponList[v.name] and weaponList[v.name].weapon) then
            local serial = v[inventoryMetadata] and v[inventoryMetadata][itemSerial] and string.upper(v[inventoryMetadata][itemSerial])
            local ammo = v[inventoryMetadata].ammo and (', Патрони: %s'):format(v[inventoryMetadata].ammo) or ''
            local qual = v[inventoryMetadata] and v[inventoryMetadata][itemQuality] and math.ceil(v[inventoryMetadata][itemQuality])
            if qual and qual - v[inventoryMetadata][itemQuality] < 0.5 then qual = tostring(math.floor(v[inventoryMetadata][itemQuality])) end
            local durability = qual and (', Състояние: %s'):format(qual) or ''
            local text = ('Слот: %s'):format(k) .. ammo .. durability
            bagMenu[#bagMenu+1] = {
                header = ('%s (%s)'):format(v.label, serial),
                text = text,
                title = ('%s (%s)'):format(v.label, serial),
                description = text,
                params = {
                    event = 'evidence:client:sendbagitemtoserver',
                    args = {
                        slot = k,
                        street = GetStreet(),
                    },
                },
                event = 'evidence:client:sendbagitemtoserver',
                args = {
                    slot = k,
                    street = GetStreet(),
                },
            }
            if not foundWeapon then foundWeapon = true end
        end
    end
    if not foundWeapon then
        Config.Functions.Notify('Нямате оръжия, които да приберете в плика с доказателства!', 'error')
        return
    end
    OpenContext(bagMenu, 'Прибиране на доказателства')
end)

RegisterNetEvent('evidence:client:sendbagitemtoserver', function(data) 
    TriggerServerEvent('evidence:server:bagitem', data)
end)

RegisterNetEvent('evidence:client:cleanweapon', function(inventory)
    local foundRag, foundCleansers = false, {}

    for k, v in pairs(inventory) do
        if Config.EvidenceCleanup.RemoveFingerprints[v.name] then
            foundRag = true        
        end

        if Config.EvidenceCleanup.RemoveBlood[v.name] then
            foundCleansers[v.name] = v.slot
        end
    end


    if curwephash == GetSelectedPedWeapon(ped) then
        local foundRag, foundCleansers = false, {}
        local weaponMenu = {
            {
                header = 'Weapon Actions',
                isMenuHeader = true,
            }
        }

        if Config.Context.Ox then weaponMenu = {} end

        for k, v in pairs(inventory) do
            if Config.EvidenceCleanup.RemoveFingerprints[v.name] then
                foundRag = true        
            end

            if Config.EvidenceCleanup.RemoveBlood[v.name] then
                foundCleansers[v.name] = v.slot
            end
        end

        if Config.EvidenceCleanup.AlwaysAvailable or foundRag then
            weaponMenu[#weaponMenu+1] = {
                header = 'Избърсване на оръжието',
                text = 'Почистете това оръжие от евентуални пръстови отпечатъци',
                title = 'Избърсване на оръжието',
                description = 'Почистете това оръжие от евентуални пръстови отпечатъци',
                params = {
                    event = 'evidence:client:wipeweapon',
                    args = {
                        slot = curslot,
                    },
                },
                event = 'evidence:client:wipeweapon',
                args = {
                    slot = curslot,
                },
            }
        end

        for k, v in pairs(foundCleansers) do
            weaponMenu[#weaponMenu+1] = {
                header = 'Изчистване на оръжието',
                text = ('Използвайте %s за да изчистите оръжието'):format(string.lower(k)),
                title = 'Изчистване на оръжието',
                description = ('Използвайте %s за да изчистите оръжието'):format(string.lower(k)),
                params = {
                    event = 'evidence:client:wipeweapon',
                    args = {
                        slot = curslot,
                        clean = k,
                    },
                },
                event = 'evidence:client:wipeweapon',
                args = {
                    slot = curslot,
                    clean = k,
                },
            }
        end
        OpenContext(weaponMenu, 'Weapon Actions')
    elseif IsPedInAnyVehicle(ped) then
        local curveh, seat = GetVehiclePedIsIn(ped), nil
       
        for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(curveh)) do
            local occupant = GetPedInVehicleSeat(curveh, i)
            if occupant == ped and i then
                seat = i + 2
            end
        end

        local weaponMenu = {
            {
                header = 'Почистване на превозно средство',
                isMenuHeader = true,
            }
        }

        if Config.Context.Ox then weaponMenu = {} end

        if Config.EvidenceCleanup.AlwaysAvailable or foundRag then
            weaponMenu[#weaponMenu+1] = {
                header = 'Забърсване на седалката',
                text = 'Забършете тази седалка от евентуални пръстови отпечатъци.',
                title = 'Забърсване на седалката',
                description = 'Забършете тази седалка от евентуални пръстови отпечатъци.',
                params = {
                    event = 'evidence:client:wipearea',
                    args = {seat = seat},
                },
                event = 'evidence:client:wipearea',
                args = {seat = seat},
            }
        end

        for k, v in pairs(foundCleansers) do
            weaponMenu[#weaponMenu+1] = {
                header = 'Почистване на седалката',
                text = ('Използвайте %s за да почистите седалката'):format(string.lower(k)),
                title = 'Почистване на седалката',
                description = ('Използвайте %s за да почистите седалката'):format(string.lower(k)),
                params = {
                    event = 'evidence:client:wipearea',
                    args = {
                        clean = k,
                        seat = seat,
                    },
                },
                event = 'evidence:client:wipearea',
                args = {
                    clean = k,
                    seat = seat,
                },
            }
        end
        OpenContext(weaponMenu, 'Почистване на превозно средство')
    else
        local weaponMenu = {
            {
                header = 'Почистване',
                isMenuHeader = true,
            }
        }

        if Config.Context.Ox then weaponMenu = {} end

        if Config.EvidenceCleanup.AlwaysAvailable or foundRag then
            weaponMenu[#weaponMenu+1] = {
                header = 'Избърсване на зоната',
                text = 'Почистете тази област от евентуални пръстови отпечатъци',
                title = 'Избърсване на зоната',
                description = 'Почистете тази област от евентуални пръстови отпечатъци',
                params = {
                    event = 'evidence:client:wipearea',
                },
                event = 'evidence:client:wipearea',
            }
        end

        for k, v in pairs(foundCleansers) do
            weaponMenu[#weaponMenu+1] = {
                header = 'Изчистване на зоната',
                text = ('Използвайте %s за изчистване на зоната'):format(string.lower(k)),
                title = 'Изчистване на зоната',
                description = ('Използвайте %s за изчистване на зоната'):format(string.lower(k)),
                params = {
                    event = 'evidence:client:wipearea',
                    args = {
                        clean = k,
                    },
                },
                event = 'evidence:client:wipearea',
                args = {
                    clean = k,
                },
            }
        end
        OpenContext(weaponMenu, 'Почистване')
    end
end)

RegisterNetEvent('evidence:client:wipearea', function(data)
    local prevwalk = not data?.seat and not data?.slot and GetPedMovementClipset(ped)
    local wipeareaTime = data?.clean and 60000 or 8000

    if prevwalk and prevwalk ~= `move_ped_crouched` then
        RequestWalking("move_ped_crouched")
        SetPedMovementClipset(ped, "move_ped_crouched",1.0)
    end

    Config.Functions.Progressbar("cleanscene", data?.clean and 'Почистване на района..' or 'Избърсване на района..', wipeareaTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "timetable@floyd@clean_kitchen@idle_a",
        anim = 'idle_b',
        flags = 48,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)
        Config.Functions.Notify(Config.Notification.WipedDownArea, 'success')
        TriggerServerEvent('evidence:server:wipearea', {slot = data?.slot, clean = data?.clean, plate = data?.seat and Config.Functions.GetPlate(curveh), seat = data?.seat})

        if prevwalk and prevwalk ~= `move_ped_crouched` then
            RequestWalking(Config.Walks[prevwalk])
            SetPedMovementClipset(ped, Config.Walks[prevwalk], 1.0)
        end
    end, function() -- Cancel
        ClearPedTasks(ped)

        if prevwalk and prevwalk ~= `move_ped_crouched` then
            RequestWalking(Config.Walks[prevwalk])
            SetPedMovementClipset(ped, Config.Walks[prevwalk], 1.0)
        end
    end)               

    Wait(wipeareaTime)
end)


RegisterNetEvent('evidence:client:wipeweapon', function(data)
    Config.Functions.Progressbar("wipeweapon", data.clean and 'Почистване на оръжието..' or 'Избърсване на оръжието..', 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)
        Config.Functions.Notify(data.clean and Config.Notification.CleanWeapon or Config.Notification.WipeWeapon, 'success')
        TriggerServerEvent('evidence:server:wipeweapon', {slot = data.slot, clean = data.clean})
        if nogloves then
            cleaningWeapon = true
            SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
            TriggerEvent('weapons:client:SetCurrentWeapon', false, false)
            TriggerEvent('ox_inventory:disarm')
            Wait(1000)
            cleaningWeapon = false
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)   
end)

-------------------- evidence bag menu

RegisterNetEvent('evidence:client:unbagev', function(slot)
    if Config.Context.Ox and lib then lib.hideContext(lib.getOpenContextMenu()) end

    while (not HasAnimDictLoaded("anim@amb@business@weed@weed_inspecting_high_dry@")) do
        RequestAnimDict("anim@amb@business@weed@weed_inspecting_high_dry@")
        Wait(0)
    end

    local unbagging = true

    CreateThread(function()
        while unbagging do
            TaskPlayAnim(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 3.0, 3.0, -1, 16, 0, 0, 0, 0) 
            Wait(1000)
        end
    end)

    Config.Functions.Progressbar("unbagev", "Разопаковане на плика с доказателства..", ActiveLEO and 10000 or 60000, false, true, { -- finish
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('evidence:server:unbagitem', {slot = slot})
        unbagging = false
		ClearPedTasks(ped)
    end, function() -- Cancel
        unbagging = false
		ClearPedTasks(ped)
    end)   
end)

function ConfirmNoExploit(slot)
    if not ActiveLEO then
        local bagMenu = {
            {
                header = 'Моля, потвърдете, че не експлоатирате',
                isMenuHeader = true,
            },        
        }

        if Config.Context.Ox then bagMenu = {} end

        bagMenu[#bagMenu+1] = {
            header = 'Продължете. Не използвам механиката на чантата за доказателства, за да намаля теглото си при носене или да вкарам оръжие някъде, където не би трябвало да го имам.',
            title = 'Продължете. Не използвам механиката на чантата за доказателства, за да намаля теглото си при носене или да вкарам оръжие някъде, където не би трябвало да го имам.',
            params = {
                event = 'evidence:client:unbagev',
                args = slot,
            },
            event = 'evidence:client:unbagev',
            args = slot,
        }

        bagMenu[#bagMenu+1] = {
            header = 'Отмяна. Преосмислих това действие, не трябваше да мога да нося това оръжие там, където съм.',
            title = 'Отмяна. Преосмислих това действие, не трябваше да мога да нося това оръжие там, където съм.',
            params = {
                event = 'qb-ui:client:closeMenu',
            },
            event = 'qb-ui:client:closeMenu',
        }
        OpenContext(bagMenu, 'Моля, потвърдете, че не експлоатирате')
    else
        TriggerEvent('evidence:client:unbagev', slot)
    end
end

RegisterNetEvent('evidence:client:BagMenu', function(data)
    data.history = {{event = 'evidence:client:BagMenu', data = table.clone(data)}}

    local retrieveItem = false
    local hdr = 'Информация за доказателството'

    if not next(data.info) then hdr = 'Бележки към доказателствата' end

    local bagMenu = {
        {
            header = hdr,
            title = ('**%s**'):format(hdr), 
            isMenuHeader = true,
        }
    }

    for k, v in pairs(data.info) do
        if not v.retrieve then
            bagMenu[#bagMenu+1] = {
                header = tostring(v.copy),
                text = v.label,
                title = tostring(v.copy),
                description = v.label,
                params = {
                    event = 'evidence:client:CopyEvidence',
                    args = {
                        text = v.copy
                    }
                },
                event = 'evidence:client:CopyEvidence',
                args = {
                    text = v.copy
                },
            }
        else
            retrieveItem = v.label
        end
    end

    local latentprints = data.item[inventoryMetadata].item and data.item[inventoryMetadata].item[inventoryMetadata].latentprints and next(data.item[inventoryMetadata].item[inventoryMetadata].latentprints) and true
    local latentblood = data.item[inventoryMetadata].item and data.item[inventoryMetadata].item[inventoryMetadata].latentblood and next(data.item[inventoryMetadata].item[inventoryMetadata].latentblood) and true

    if data.item[inventoryMetadata].item and (latentprints or latentblood) then
        bagMenu[#bagMenu+1] = {
            header = 'Латентни доказателства',
            title = 'Латентни доказателства',
            isMenuHeader = true,
        }

        if data.item[inventoryMetadata].item[inventoryMetadata].latentprints then
            for k, v in pairs(data.item[inventoryMetadata].item[inventoryMetadata].latentprints) do
                bagMenu[#bagMenu+1] = {
                    header = ('Латентен отпечатък %s'):format(v.evidenceId),
                    title = ('Латентен отпечатък %s'):format(v.evidenceId),
                    params = {
                        event = 'evidence:client:collectlatent',
                        args = {
                            slot = data.item.slot,
                            evidenceId = v.evidenceId,
                            fingerprint = k,
                            evtype = 'fingerprint',
                            item = data.item,
                        },
                    },
                    event = 'evidence:client:collectlatent',
                    args = {
                        slot = data.item.slot,
                        evidenceId = v.evidenceId,
                        fingerprint = k,
                        evtype = 'fingerprint',
                        item = data.item,
                    },
                }
            end
        end

        if data.item[inventoryMetadata].item[inventoryMetadata].latentblood then
            for k, v in pairs(data.item[inventoryMetadata].item[inventoryMetadata].latentblood) do
                bagMenu[#bagMenu+1] = {
                    header = ('Латентна кръв %s'):format(v.evidenceId),
                    title = ('Латентна кръв %s'):format(v.evidenceId),
                    params = {
                        event = 'evidence:client:collectlatent',
                        args = {
                            slot = data.item.slot,
                            evidenceId = v.evidenceId,
                            dnalabel = k,
                            bloodtype = v.bloodtype,
                            evtype = 'blood',
                            item = data.item,
                        },
                    },
                    event = 'evidence:client:collectlatent',
                    args = {
                        slot = data.item.slot,
                        evidenceId = v.evidenceId,
                        dnalabel = k,
                        bloodtype = v.bloodtype,
                        evtype = 'blood',
                        item = data.item,
                    },
                }
            end
        end
    end

    bagMenu[#bagMenu+1] = {
        header = 'Действия с плика за доказателства',
        title = '**Действия с плика за доказателства**',
        isMenuHeader = true,
    }

    if retrieveItem then
        bagMenu[#bagMenu+1] = {
            header = ('Разопаковане %s'):format(retrieveItem),
            title = ('Разопаковане %s'):format(retrieveItem),
            onSelect = ConfirmNoExploit,
            args = data.item.slot,
            params = {
                isAction = true,
                event = ConfirmNoExploit,
                args = data.item.slot,
            }
        }
    end

    bagMenu[#bagMenu+1] = {
        header = 'Добавяне на Бележки',
        title = 'Добавяне на бележки към доказателството',
        params = {
            event = 'evidence:client:NoteInput',
            args = table.clone(data),
        },
        event = 'evidence:client:NoteInput',
        args = table.clone(data),
    }

    if next(data.info) then
        bagMenu[#bagMenu+1] = {
            header = 'Бележки към доказателствата',
            title = '**Бележки към доказателствата**',
            isMenuHeader = true,
        }
    end

    if data.item[inventoryMetadata].notes and next(data.item[inventoryMetadata].notes) then
        for k, v in pairs(data.item[inventoryMetadata].notes) do
            data.note = k
            
            local txt = ('Създадена от: %s, Timestamp: %s'):format(v.created.name, v.created.timestamp)

            if v.edited then txt = ('Последна промяна: %s, Timestamp: %s'):format(v.edited.name, v.edited.timestamp) end

            bagMenu[#bagMenu+1] = {
                title = v.text,
                header = v.text,
                text = txt,
                description = txt,
                params = {
                    event = 'evidence:client:EditNotes',
                    args = table.clone(data),
                },
                event = 'evidence:client:EditNotes',
                args = table.clone(data),
            }
        end       
    
        data.note = nil
    else
        bagMenu[#bagMenu+1] = {
            header = 'Няма бележки',
            title = 'Не са оставени бележки',
            disabled = true,
        }
    end  
    OpenContext(bagMenu, 'Доказателства')
end)

RegisterNetEvent('evidence:client:collectlatent', function(data)
    local hasBag, hasKit, hasMikrosil = Config.Functions.SearchInventoryClient('empty_evidence_bag'), Config.Functions.SearchInventoryClient('fingerprintkit'), Config.Functions.SearchInventoryClient('mikrosil')

    if not hasBag then Config.Functions.Notify('Не разполагате с плик за доказателства, с който да го вземете!', 'error') return end

    if Config.Fingerprints.RequireKit and data.evtype == 'fingerprint' and (not hasKit or not hasMikrosil) then
        if not hasKit then Config.Functions.Notify('Не разполагате с нищо, за да вземете този пръстов отпечатък.', 'error') end
        if not hasMikrosil then 
            if Config.Functions.SearchInventoryClient('fingerprinttape') then
                Config.Functions.Notify('Тази повърхност изисква различен метод на прехвърляне, за да се вземе отпечатъкът.', 'error')
            else
                Config.Functions.Notify('Не разполагате с нищо, за да вземете този пръстов отпечатък.', 'error')
            end
        end     
        return 
    end    

    Config.Functions.Progressbar("collectlatent", "Събиране на латентни доказателства..", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "nmt_3_rcm-10",
        anim = "cs_nigel_dual-10",
        flags = 1,
    }, {}, {}, function() -- Done
        local info = {
            tracking = data.evidenceId,
            type = data.evtype,
            street = ('%s %s %s'):format(data.item[inventoryMetadata].item.label, data.item[inventoryMetadata].tracking, data.item[inventoryMetadata].serie or data.item[inventoryMetadata].serial or ''),
        }

        if data.evtype == 'blood' then
            info.label = 'Латентна кръвна проба'
            info.dnalabel = data.dnalabel
            info.bloodtype = data.bloodtype
        elseif data.evtype == 'fingerprint' then
            info.label = 'Латентен пръстов отпечатък'
            info.fingerprint = data.fingerprint
        end

        TriggerServerEvent('evidence:server:AddLatentEvToInventory', {info = info, slot = data.slot, evidenceId = data.evidenceId})

        ClearPedTasks(ped)
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:EditNotes', function(data)
    data.history[2] = {event = 'evidence:client:EditNotes', data = table.clone(data)}

    local bagMenu = {
        {
            header = ('%s Бележки'):format(data.item[inventoryMetadata].tracking),
            isMenuHeader = true,
        }
    }

    if Config.Context.Ox then bagMenu = {} end
    
    bagMenu[#bagMenu+1] = {
        header = ('<big>%s</big>'):format(data.item[inventoryMetadata].notes[data.note].text),
        title = ('%s>'):format(data.item[inventoryMetadata].notes[data.note].text),
        disabled = true,
    }

    bagMenu[#bagMenu+1] = {
        header = ('Създадена: %s'):format(data.item[inventoryMetadata].notes[data.note].created.name),
        txt = data.item[inventoryMetadata].notes[data.note].created.timestamp,
        title = ('Създадена: %s'):format(data.item[inventoryMetadata].notes[data.note].created.name),
        description = data.item[inventoryMetadata].notes[data.note].created.timestamp,
        disabled = true,
    }


    if data.item[inventoryMetadata].notes[data.note].edited then
        bagMenu[#bagMenu+1] = {
            header = ('Последна промяна: %s'):format(data.item[inventoryMetadata].notes[data.note].edited.name),
            txt = data.item[inventoryMetadata].notes[data.note].edited.timestamp,
            title = ('Последна промяна: %s'):format(data.item[inventoryMetadata].notes[data.note].edited.name),
            description = data.item[inventoryMetadata].notes[data.note].edited.timestamp,
            disabled = true,
        }
    end

    bagMenu[#bagMenu+1] = {
        header = 'Редактиране на бележката',
        title = 'Редактиране на бележката',        
        params = {
            event = 'evidence:client:NoteInput',
            args = table.clone(data),
        },
        event = 'evidence:client:NoteInput',
        args = table.clone(data),
    }

    bagMenu[#bagMenu+1] = {
        header = 'Изтриване на бележката',
        title = 'Изтриване на бележката',
        params = {
            event = 'evidence:client:DeleteNote',
            args = table.clone(data),
        },
        event = 'evidence:client:DeleteNote',
        args = table.clone(data),
    }

    local prev = #data.history - 1

    bagMenu[#bagMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            event = data.history[prev].event,
            args = data.history[prev].data,
        },
        event = data.history[prev].event,
        args = data.history[prev].data,
    }

    OpenContext(bagMenu, ('%s Бележка'):format(data.item[inventoryMetadata].tracking))
end)

RegisterNetEvent('evidence:client:DeleteNote', function(data)
    
    data.item[inventoryMetadata].notes[data.note] = 'remove'

    local temp = {}

    for k, v in ipairs(data.item[inventoryMetadata].notes) do
        if type(v) == 'table' then
            temp[#temp+1] = v
        end
    end        

    data.item[inventoryMetadata].notes = temp

    TriggerServerEvent('evidence:server:UpdateBag', data.item.slot, data.item[inventoryMetadata])

    local prev = #data.history - 1

    data.history[prev].data.item[inventoryMetadata] = data.item[inventoryMetadata]

    TriggerEvent(data.history[prev].event, data.history[prev].data)
end)

RegisterNetEvent('evidence:client:NoteInput', function(data)
    data.history[#data.history+1] = {event = 'evidence:client:EditNotes', data = table.clone(data)}

    if not data.item[inventoryMetadata].notes then data.item[inventoryMetadata].notes = {} end

    local preexisting = nil

    if data.note then preexisting = data.item[inventoryMetadata].notes[data.note].text end

    local noteinput = OpenInput({
        header = ('Създаване на бележка за %s'):format(data.item[inventoryMetadata].tracking),
        submitText = "Запазване",
        inputs = {
            {
                text = 'Текст',
                name = "text", 
                type = Config.Context.Ox and 'input' or "text",
                isRequired = true,
                default = preexisting,
            },
        },
    }, ('Създаване на бележка за %s'):format(data.item[inventoryMetadata].tracking))

    local edited = nil

    if noteinput ~= nil then
        if not data.note then 
            data.item[inventoryMetadata].notes[#data.item[inventoryMetadata].notes+1] = {
                text = noteinput.text or noteinput[1],
                created = {name = ('%s %s'):format(PlayerData.firstname, PlayerData.lastname)},
            }
        else
            edited = true
            data.item[inventoryMetadata].notes[data.note].text = noteinput.text
            data.item[inventoryMetadata].notes[data.note].edited = {name = ('%s %s'):format(PlayerData.firstname, PlayerData.lastname)}
        end

        TriggerServerEvent('evidence:server:UpdateBag', data.item.slot, data.item[inventoryMetadata], data.note, edited)

        local prev = #data.history - 1       

        data.history[prev].data.item[inventoryMetadata] = data.item[inventoryMetadata]

        TriggerEvent('evidence:client:BagMenu', data.history[prev].data)
    end
end)

-- car evidence menu

local function CarEvidenceMenu(evtable, plate)
    local tamper1, tamper2 = nil
    inmenu = true

    if not (CarEvidence[plate] or ignition or exterior) then ClearPedTasks(ped) Config.Functions.Notify((Config.Notification.NoEvidence):format(plate)) return end

    CreateThread(function()
        while inmenu do
            Wait(200)
            if not newmenu and not IsNuiFocused() then
                ClearPedTasks(ped)
                inmenu = false
            end
        end   
    end)

    local evMenu = {
        {
            header = ('Доказателства от %s'):format(plate),
            isMenuHeader = true,
        }
    }

    if Config.Context.Ox then evMenu = {} end

    Config.Functions.TriggerCallback('police:GetIgnitionTampering', function(result)
        if result then
            evMenu[#evMenu+1] = {
                header = 'Възможно е запалването на автомобила да е било манипулирано.',
                title = 'Възможно е запалването на автомобила да е било манипулирано.',
                disabled = true,
            }
        end
        tamper1 = true
    end, plate)

    Config.Functions.TriggerCallback('police:GetExteriorTampering', function(result)
        if result then
            evMenu[#evMenu+1] = {
                header = 'Възможно е в автомобила да е било проникнато със сила.',
                title = 'Възможно е в автомобила да е било проникнато със сила.',
                disabled = true,
            }
        end
        tamper2 = true
    end, plate)

    while not (tamper1 and tamper2) do
        Wait(10)
    end

    for k, v in pairs(evtable) do
        if not v.ignore then
            noevbag = not Config.Functions.SearchInventoryClient('empty_evidence_bag')
            nokit = Config.Fingerprints.RequireKit and not Config.Functions.SearchInventoryClient('empty_evidence_bag') and not Config.Functions.SearchInventoryClient('empty_evidence_bag') and true

            if v.evtype == 'carcasing' then
                evMenu[#evMenu+1] = {
                    header = ('Гилза %s, Номер: %s'):format(string.upper(v.serial), k),
                    title = ('Гилза %s, Номер: %s'):format(string.upper(v.serial), k),
                    disabled = noevbag,
                    text = noevbag and '[ЛИПСВА ВИ ПЛИК]' or '',
                    description = noevbag and '[ЛИПСВА ВИ ПЛИК]' or '',
                    params = {
                        event = 'evidence:client:collectcarevidence',
                        args = {
                            evidenceId = k,
                            plate = plate,
                        },
                    },
                    event = 'evidence:client:collectcarevidence',
                    args = {
                        evidenceId = k,
                        plate = plate,
                    },
                }
            elseif v.evtype == "carfingerprint" then
                evMenu[#evMenu+1] = {
                    header = ('Отпечатък %s, Номер: %s'):format(string.upper(v.fingerprint), k),
                    text = ('Намерен на %s %s'):format(v.location, nokit and '[ЛИПСВА ВИ МАШИНКА]' or ''),
                    title = ('Отпечатък %s, Номер: %s'):format(string.upper(v.fingerprint), k),
                    description = ('Намерен на %s %s'):format(v.location, nokit and '[ЛИПСВА ВИ МАШИНКА]' or ''),
                    disabled = noevbag or nokit,
                    params = {
                        event = 'evidence:client:collectcarevidence',
                        args = {
                            evidenceId = k,
                            plate = plate,
                            location = v.location,
                        },
                    },
                    event = 'evidence:client:collectcarevidence',
                    args = {
                        evidenceId = k,
                        plate = plate,
                        location = v.location,
                    },
                }
            elseif v.evtype == 'carblood' then
                evMenu[#evMenu+1] = {
                    header = ('Кръв %s, Номер: %s'):format(string.upper(v.dna), k),
                    text = ('Намерен в близост до седалка %s %s'):format(v.seat, noevbag and '[ЛИПСВА ВИ ПЛИК]' or ''),
                    title = ('Кръв %s, Номер: %s'):format(string.upper(v.dna), k),
                    description = ('Намерен в близост до седалка %s %s'):format(v.seat, noevbag and '[ЛИПСВА ВИ ПЛИК]' or ''),
                    disabled = noevbag,
                    params = {
                        event = 'evidence:client:collectcarevidence',
                        args = {
                            evidenceId = k,
                            plate = plate,
                            seat = v.seat,
                        },
                    },
                    event = 'evidence:client:collectcarevidence',
                    args = {
                        evidenceId = k,
                        plate = plate,
                        seat = v.seat,
                    },
                }
            end
        end
    end
    OpenContext(evMenu, ('Доказателства от %s'):format(plate))
end

RegisterNetEvent('evidence:client:checkcarevidence', function(data)  
    local plate = data?.entity and Config.Functions.GetPlate(data?.entity) or Config.Functions.GetPlate(GetVehiclePedIsIn(ped))
    local inVeh = IsPedInAnyVehicle(ped) and GetVehiclePedIsIn(ped)

    if not CarEvidence[plate] then TriggerServerEvent('evidence:server:LoadCarEvidence', plate) end
    
    if not inVeh then
        TaskTurnPedToFaceEntity(ped, data.entity, 1000)
        Wait(1000)
    end
    
    local doors = GetNumberOfVehicleDoors(data?.entity or inVeh)
    for i = -1, doors, 1 do SetVehicleDoorOpen(data?.entity or inVeh, i, false, false) end

    Config.Functions.Progressbar("checkingcar", "Проверка на превозното средство..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = not inVeh and "anim@amb@clubhouse@tutorial@bkr_tut_ig3@" or 'veh@truck@ds@base',
        anim = not inVeh and "machinic_loop_mechandplayer" or 'hotwire',
        flags = 1,
    }, {}, {}, function() -- Done
        CarEvidenceMenu(CarEvidence[plate], plate)
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:collectcarevidence', function(data)
    newmenu = true
    if not CarEvidence[data.plate] then print('Опит за събиране на доказателства, които не съществуват в:', data.plate) return end

    if CarEvidence[data.plate][data.evidenceId].evtype == 'carcasing' then
        local info = {
            label = 'Използвана Гилза',
            tracking = data.evidenceId,
            type = 'casing',
            street = ("Превозно средство %s"):format(data.plate),
            ammolabel = CarEvidence[data.plate][data.evidenceId].type,
            serie = CarEvidence[data.plate][data.evidenceId].serial,
        }
        TriggerServerEvent('evidence:server:AddCarEvToInventory', data.evidenceId, info, data.plate)                        
    elseif CarEvidence[data.plate][data.evidenceId].evtype == 'carblood' then
        local info = {
            label = 'Кръвна Проба',
            tracking = data.evidenceId,
            type = 'blood',
            street = ("%s, Седалка %s"):format(data.plate, data.seat),
            dnalabel = CarEvidence[data.plate][data.evidenceId].dna,
            bloodtype = CarEvidence[data.plate][data.evidenceId].bloodtype,
        }
        TriggerServerEvent('evidence:server:AddCarEvToInventory', data.evidenceId, info, data.plate)
    elseif CarEvidence[data.plate][data.evidenceId].evtype == 'carfingerprint' then
        local info = {
            label = 'Пръстов Отпечатък',
            tracking = data.evidenceId,
            type = 'fingerprint',
            street = ("%s, %s"):format(data.plate, data.location),
            fingerprint = CarEvidence[data.plate][data.evidenceId].fingerprint,
        }
        TriggerServerEvent('evidence:server:AddCarEvToInventory', data.evidenceId, info, data.plate)                        
    end

    CarEvidence[data.plate][data.evidenceId].ignore = true

    if next(CarEvidence[data.plate]) then
        Wait(500)
        CarEvidenceMenu(CarEvidence[data.plate], data.plate) 
        newmenu = false
    else
        inmenu = false
        newmenu = false
    end    
end)

RegisterNetEvent('evidence:client:unsetcarev', function(data)
    CarEvidence[data.plate][data.evidenceId].ignore = false
end)

----------------- Debug Menu and other Debug Events --------------------------

RegisterNetEvent('evidence:client:debugmenu', function() -- this event is triggered by the debug command
    local debugMenu = {
        {
            header = 'r14-evidence Debug Menu',
            isMenuHeader = true,
        }
    }

    if Config.Context.Ox then debugMenu = {} end

    local debugOptions = {}
    local count = 0

    for k, v in pairs(Config.Debug) do
        if k ~= 'DebugCommand' then
            count = count + 1

            debugOptions[v.order] = {var = k, label = v.label, enabled = v.enabled}
        end
    end

    debugOptions.DebugCommand = nil

    for k, v in pairs(debugOptions) do
        if not v.server then
            debugMenu[#debugMenu+1] = {
                header = ('%s'):format(v.label),
                text = ('Current State: %s'):format(string.upper(tostring(v.enabled))),
                title = ('%s'):format(v.label),
                description = ('Current State: %s'):format(string.upper(tostring(v.enabled))),
                params = {
                    event = 'evidence:client:setdebugvariable',
                    args = {
                        var = v.var,
                        bool = v.enabled,
                    }
                },
                event = 'evidence:client:setdebugvariable',
                args = {
                    var = v.var,
                    bool = v.enabled,
                }
            }
        else
            debugMenu[#debugMenu+1] = {
                header = ('%s'):format(v.label),
                text = ('Current State: %s'):format(string.upper(tostring(v.enabled))),
                title = ('%s'):format(v.label),
                description = ('Current State: %s'):format(string.upper(tostring(v.enabled))),
                params = {
                    event = 'evidence:client:SetServerDebugVariable',
                    args = {
                        var = v.var,
                        bool = v.enabled,
                    },
                },
                event = 'evidence:client:SetServerDebugVariable',
                args = {
                    var = v.var,
                    bool = v.enabled,
                },
            }
        end
    end
    OpenContext(debugMenu, 'r14-evidence Debug Menu')
end)

RegisterNetEvent('evidence:client:SetServerDebugVariable', function(data) 
    TriggerServerEvent('evidence:server:SetServerDebugVariable', data)
end)

RegisterNetEvent('evidence:client:setdebugvariable', function(data)
    Config.Debug[data.var].enabled = not data.bool
end)

if Config.Debug.DebugCommand then -- debug commands for testing target options when no one is around
    RegisterCommand('selfinvestigate', function()
        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:investigate', data)
    end)

    RegisterCommand('selfgsrtest', function()
        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:GSRtest', data)
    end)

    RegisterCommand('selfdnaswab', function()
        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:DNAswab', data)
    end) 

    RegisterCommand('selffrisk', function()
        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:frisk', data)
    end)

    RegisterCommand('selfbreathalyze', function()
        if not Config.Breathalyzer then Config.Functions.Notify('The breathalyzer is not enabled in your config!', 'error') end

        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:breathalyze', data)
    end) 

    RegisterCommand('selfdrugtest', function()
        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:drugtest', data)
    end)

    RegisterCommand('selfinspectveh', function()
        local data = {entity = GetVehiclePedIsIn(PlayerPedId())}
        TriggerEvent('evidence:client:inspectvehicle', data)
    end)

    RegisterCommand('selffingerprint', function()
        local data = {entity = PlayerPedId()}
        TriggerEvent('evidence:client:fingerprint', data)
    end)

    RegisterCommand('createfingerprint', function()
        local hands = GetPedDrawableVariation(ped, 3)
        local model = GetEntityModel(ped)

        if IsPedInAnyVehicle(ped) then
            TriggerEvent('evidence:client:FetchCarFingerprintSeat', Config.Functions.GetPlate(GetVehiclePedIsIn(ped)))
        else
            TriggerServerEvent('evidence:server:CreateFingerprint', coords or GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.25, 0.0))
        end

        if not nogloves then
            Config.Functions.Notify('This ped is wearing gloves, overriding to create debug fingerprint', 'error')            
        else
            Config.Functions.Notify('Creating debug fingerprint', 'success')            
        end
    end)

    RegisterCommand('createlatentfingerprint', function()
        if curslot then
            TriggerServerEvent('evidence:server:updatelatentevidence', {slot = curslot, nogloves = nogloves, fingerprint = true})
            Config.Functions.Notify('Create latent fingerprint on weapon.', 'success')
        else
            Config.Functions.Notify('Could not create latent fingerprint, you are not holding a weapon', 'error')
        end
    end)

    RegisterCommand('createlatentblood', function()
        if curslot then
            TriggerServerEvent('evidence:server:updatelatentevidence', {slot = curslot, blood = true, victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))})
            Config.Functions.Notify('Create latent blood on weapon.', 'success')
        else
            Config.Functions.Notify('Could not create latent fingerprint, you are not holding a weapon', 'error')
        end
    end)

    RegisterCommand('syncev', function() -- manually fetches evidence from the server
        TriggerServerEvent('evidence:server:FetchEv')
    end)
end

--------------------------- bleed command 

if Config.Bleed.EnableCommand then
    RegisterCommand("bleed", function(source, args) -- this command allows players to create blood evidence during rp situations that may not generate actual blood evidence
        if JustBled then Config.Functions.Notify(Config.Notification.CantBleed, 'error') return end -- prevents use while in downed state

        JustBled = true

        if not Config.Functions.CheckDead() then -- deal damage if not downed
            local currentHealth = GetEntityHealth(ped) - math.random(5, 10)

            if Config.Bleed.PreventDeath then if currentHealth < 101 then currentHealth = 101 end end -- prevent being downed if enabled in config

            SetEntityHealth(ped, currentHealth)
        end

        AnimpostfxPlay("MP_corona_switch", 1000, false)

        Config.Functions.Notify(Config.Notification.Bleed, 'error')

        CreateBlood()

        Wait(Config.Bleed.Cooldown * 1000)

        JustBled = false
    end, false)
end

---------------------------- qb-target exports to define target interactions for this script

local function AddGlobalPlayerTargets(data)
    if Config.Target.QB then
        exports['qb-target']:AddGlobalPlayer(data)
    elseif Config.Target.Ox then
        exports['ox_target']:addGlobalPlayer(data.options)
    elseif Config.Target.Custom then
        exports[Config.Target.Custom ]:AddGlobalPlayer(data)
    end
end

local function AddGlobalVehicleTargets(data)
    if Config.Target.QB then
        exports['qb-target']:AddGlobalVehicle(data)
    elseif Config.Target.Ox then
        exports['ox_target']:addGlobalVehicle(data.options)
    elseif Config.Target.Custom then
        exports[Config.Target.Custom ]:AddGlobalPlayer(data)
    end
end

CreateThread(function()
    while not LocalPlayer.state.isLoggedIn do Wait(1000) end

    AddGlobalPlayerTargets({
        options = {
            { 
                type = "client", 
                event = 'evidence:client:GSRtest',
                icon = 'fas fa-gun',
                label = 'Тест за барут',
                entity = entity,
                canInteract = function(entity, distance)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead
                    local search = Config.Functions.SearchInventoryClient         

                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if not search('gsrtestkit') then return false end  
                    if not auth.LEO.Check() then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 
                    return true
                end,
            },
            -- { 
            --     type = "client", 
            --     event = 'evidence:client:frisk',
            --     icon = 'fas fa-gun',
            --     label = 'Претърсване',
            --     entity = entity,
            --     canInteract = function(entity, distance)
            --         local auth = table.clone(Config.AuthorizedJobs)
            --         local checkdead = Config.Functions.CheckDead

            --         if Config.Target.Ox and distance and distance > 3.0 then return false end
            --         if not auth.Frisk.Check() then return false end
            --         if checkdead() then return false end
            --         if GetEntitySpeed(entity) > 0.5 then return false end 
            --         return true
            --      end,
            -- },
            { 
                type = "client", 
                event = 'evidence:client:DNAswab',
                icon = 'fas fa-dna',
                label = 'Взимане на ДНК',
                entity = entity,
                canInteract = function(entity, distance)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead
                    local search = Config.Functions.SearchInventoryClient         
               
                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if not search('dnatestkit') then return false end               
                    if not auth.FirstResponder.Check() then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 
                    return true
                end,
            },
            { 
                type = "client", 
                event = 'evidence:client:investigate',
                icon = 'fas fa-magnifying-glass',
                label = 'Разследване на лицето',
                entity = entity,
                canInteract = function(entity, distance)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead

                    if not auth.FirstResponder.Check() then return false end

                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 

                    return true
                end,
            },
            { 
                type = "client", 
                event = 'evidence:client:breathalyze',
                icon = 'fas fa-dna',
                label = 'Дрегер',
                entity = entity,
                canInteract = function(entity, distance)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead
                    local search = Config.Functions.SearchInventoryClient         
                
                    if Config.Target.Ox and distance and distance > 3.0 then return false end                    
                    if not search('breathalyzer') then return false end                  
                    if not auth.FirstResponder.Check() then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 
                    return true
                end,
            },
            { 
                type = "client", 
                event = 'evidence:client:drugtest',
                icon = 'fas fa-cannabis',
                label = 'Тест за наркотици',
                entity = entity,
                canInteract = function(entity, distance)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead
                    local search = Config.Functions.SearchInventoryClient         
                
                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if not search('drugtestkit') then return false end              
                    if not auth.FirstResponder.Check() then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 
                    return true
                end,
            },
            { 
                type = "client", 
                event = 'evidence:client:fingerprint',
                icon = 'fas fa-fingerprint',
                label = 'Пръстов Отпечатък',
                entity = entity,
                canInteract = function(entity, distance)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead
                    local search = Config.Functions.SearchInventoryClient         
                
                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if not search('fingerprintreader') then return false end           
                    if not auth.FirstResponder.Check() then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 
                    return true
                end,
            },
        },
        distance = 2.5, 
    })

    AddGlobalVehicleTargets({
        options = {
            { 
                type = "client",
                event = 'evidence:client:checkcarevidence',
                icon = "fas fa-gun",
                label = "Разследване",
			    entity = entity,
                canInteract = function(entity, distance, data)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead
                    local vehlocks = GetVehicleDoorLockStatus(entity)  

                    if Config.Target.Ox and distance and distance > 3.0 then return false end

                    if not auth.LEO.Check() then return false end
                    if checkdead() then return false end
                    if vehlocks > 1 then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 
                
                    return true
                end,
            },
            { 
                type = "client",
                event = 'evidence:client:inspectvehicle',
                icon = "fas fa-car-side",
                label = "Инспектиране",
			    entity = entity,
                canInteract = function(entity, distance, data)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead

                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if not auth.FirstResponder.Check() then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 

                    return true
                end,
            },
            { 
                type = "client",
                event = 'evidence:client:accesstool',
                icon = "fas fa-key",
                label = "Разбиване",
			    entity = entity,
                canInteract = function(entity, distance)
                    local vehlocks = GetVehicleDoorLockStatus(entity)
                    local checkdead = Config.Functions.CheckDead
                    local search = Config.Functions.SearchInventoryClient         
                
                    if not search('accesstool') then return false end
                    if checkdead() then return false end

                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if vehlocks == 1 or vehlocks == 0 then return false end
                    if IsThisModelABicycle(GetEntityModel(entity)) then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 

                    return true
                end,
            },
            --[[{ 

                icon = 'fas fa-fingerprint',
                label = "Leave Fingerprint",
			    entity = entity,
                action = function(entity)
                    TriggerServerEvent('evidence:server:CreateCarFingerprint', Config.Functions.GetPlate(entity), "Vehicle Exterior", 'exterior')

                    Config.Functions.Notify(Config.Notification.LeftFingerprint)
                end,
                canInteract = function(entity, distance)
                    local vehlocks = GetVehicleDoorLockStatus(entity)
                    local auth = table.clone(Config.AuthorizedJobs)
                    local checkdead = Config.Functions.CheckDead

                    if Config.Target.Ox and distance and distance > 3.0 then return false end
                    if not auth.LEO.Check() then return false end
                    if IsPedInAnyVehicle(ped, true) then return false end
                    if checkdead() then return false end
                    if GetEntitySpeed(entity) > 0.5 then return false end 

                    return true
                end,
            },]]
        },
        distance = 3.0, 
    })
end)

---------------------- threads --------------------------------

CreateThread(function() --- this thread occasionally reminds occupants with too much car evidence in their vehicle to clean it
    while true do
        Wait(1800000)
        if LocalPlayer.state.isLoggedIn then
            if IsPedInAnyVehicle(ped) then
                local count = 0
                local plate = Config.Functions.GetPlate(GetVehiclePedIsIn(ped))
                
                if CarEvidence[plate] then
                    for _ in pairs(CarEvidence[plate]) do count = count + 1 end
                end

                if count > 5 then
                    Config.Functions.Notify(Config.Notification.ClutterReminder, 'error')
                end
            end
        end
    end
end)
 
CreateThread(function() -- thread applies statuses to player and removes them after a certain amount of time
    while true do
        Wait(10000)
        if LocalPlayer.state.isLoggedIn then
            gsr = 0
            if CurrentStatusList and next(CurrentStatusList) then
                for k, v in pairs(CurrentStatusList) do
                    if CurrentStatusList[k].time > 10 then
                        CurrentStatusList[k].time = CurrentStatusList[k].time - 10
                    else
                        CurrentStatusList[k] = nil
                    end
                end
                TriggerServerEvent('evidence:server:UpdateStatus', CurrentStatusList)
            end
            if shotAmount > 0 then
                shotAmount = 0
            end
        end
    end
end)

CreateThread(function() --- this thread gets our current ped's entity handle, position, and routing bucket
	while true do
        if LocalPlayer.state.isLoggedIn then
            if ped and ped ~= PlayerPedId() then TriggerServerEvent('evidence:server:UpdatePlayerNetId', NetworkGetNetworkIdFromEntity(PlayerPedId())) end

	        ped = PlayerPedId()

            curveh = GetVehiclePedIsIn(ped)
            curbody = GetVehicleBodyHealth(curveh)
            cureng = GetVehicleEngineHealth(curveh)
            pos = GetEntityCoords(ped)
            curPlayerId = PlayerId()
            isfreeaiming = GetPedConfigFlag(ped, 78)
            selectedwep = GetSelectedPedWeapon(ped)

            glovecheck = CheckGloves(ped)

            if glovecheck ~= nogloves and curslot then nogloves = glovecheck handleWeaponPrints(true) end

            nogloves = glovecheck

            if isfreeaiming and selectedwep == `WEAPON_FLASHLIGHT` then usingflashlight = true else usingflashlight = false end

            if viewev or usingflashlight or nikon or Config.Debug.ViewEvidence.enabled then AreaEvidence = {} GetNeighbors({RND10(pos.x), RND10(pos.y)}) end

            if Config.GSR.WashOff and gsrpos then GSRLogic() end 
            if Config.Debug.Bucket.enabled then print('Current routing bucket:', curbucket) end

            if next(SendPacket) then SendEvidence() end

            checkCivView()
        end
        Wait(1000)
	end
end)


function checkCivView()
    local curEmote = false

    if not nikon then
        for k, v in pairs(Config.ViewEmotes) do
            if v.scenario then
                if IsPedUsingScenario(ped, v.scenario) then curEmote = k end
            else 
                if IsEntityPlayingAnim(ped, v.animDict, v.animName, 3) then curEmote = k end
            end
        end

        if curEmote and not viewev then 

            CamEvidence = {} -- clear cam evidence to bring in new civtags
            AreaEvidence = {} -- clear area evidence to bring in new civtags
            AreaNetEvidence = {} -- clear area net evidence to bring in new civtags

            viewev = true -- set viewev true for civlian viewing
        end 

        CreateThread(function()        
            while viewev and Config.ViewEmotes[curEmote] do
                if Config.ViewEmotes[curEmote].scenario then
                    if not IsPedUsingScenario(ped, Config.ViewEmotes[curEmote].scenario) then
                        viewev = false
                        CamEvidence = {}
                        AreaEvidence = {}
                        AreaNetEvidence = {}                
                        return
                    end
                else
                    if not IsEntityPlayingAnim(ped, Config.ViewEmotes[curEmote].animDict, Config.ViewEmotes[curEmote].animName, 3) then
                        viewev = false
                        CamEvidence = {}
                        AreaEvidence = {}
                        AreaNetEvidence = {}
                        return
                    end
                end
                Wait(200)
            end 
        end)
    end
end

CreateThread(function() --- this thread, if enabled, will set GSR if a player is aiming a firearm
    while Config.GSR.WhileAiming do
        if freeaiming then
            local chance = math.random(0, 100)
            if not Config.GSR.AimingChance then
                TriggerEvent('evidence:client:SetGSR', true)
            elseif chance <= Config.GSR.AimingChance then
                TriggerEvent('evidence:client:SetGSR', true)
            end
        end
        if IsPlayerFreeAiming(curPlayerId) and GetWeaponDamageType(GetSelectedPedWeapon(ped)) == 3 then freeaiming = true end
        Wait(1000 * Config.GSR.AimingTime)
    end
end)

CreateThread(function()  -- networked evidence caching, checks if the networked entity exists and supplies its evidence to the cache
    while true do
        Wait(2000)
        if LocalPlayer.state.isLoggedIn then
            if Config.Debug.ViewEvidence.enabled or nikon or usingflashlight or viewev then
                AreaNetEvidenceCache = {}
                pos = GetEntityCoords(ped, true)
                for k, v in pairs(NetEvidence) do
                    if NetworkDoesEntityExistWithNetworkId(v.netid) and GetEntityModel(NetworkGetEntityFromNetworkId(v.netid)) == v.model then
                        local netentity = NetworkGetEntityFromNetworkId(v.netid)
                        local distance = #(pos - vector3(GetEntityCoords(netentity)))
                        local tag = v.tag if viewev then tag = v.civtag end
                        if distance < areanetdist then
                            if v.boneindex then
                                local impactsize = Config.ImpactLabels[v.ammotype] or 'Неразпознат'
                                local key = tostring(netentity)..tostring(v.boneindex)
                                if AreaNetEvidenceCache[key] and not AreaNetEvidenceCache[key].ammotypes[v.ammotype] then                             
                                    AreaNetEvidenceCache[key] = {
                                        tag = ('%s, %s'):format(impactsize, AreaNetEvidenceCache[key].tag),
                                        color = v.color,
                                        size = v.size,
                                        entity = netentity,
                                        boneindex = v.boneindex,
                                        bucket = v.bucket,
                                    }
                                elseif not AreaNetEvidenceCache[key] then
                                    AreaNetEvidenceCache[key] = {
                                        ammotypes = {[v.ammotype] = true},
                                        tag = impactsize .. ' Дупка',
                                        color = v.color,
                                        size = v.size,
                                        entity = netentity,
                                        boneindex = v.boneindex,
                                        bucket = v.bucket,
                                    }
                                end
                            else
                                AreaNetEvidenceCache[k] = {
                                    bucket = v.bucket,
                                    tag = tag,
                                    color = v.color,
                                    size = v.size,
                                    entity = netentity,
                                    coords = v.offset,
                                    norm = v.norm,
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end)

 CreateThread(function() -- this loop brings networked entity evidence out of cache to feed into the flashlight/camera
    while true do
        Wait(500)
        if (usingflashlight or nikon or viewev or Config.Debug.ViewEvidence.enabled) and next(AreaNetEvidenceCache) then
            pos = GetEntityCoords(ped)
            for k, v in pairs(AreaNetEvidenceCache) do
                local coords = GetEntityCoords(v.entity)
                local dist = #(pos - coords)
                if dist < areadist then
                    AreaNetEvidence[k] = {
                        bucket = v.bucket,
                        tag = v.tag,
                        distance = dist,
                        netev = true,
                        entity = v.entity,
                        color = v.color,
                        size = isize,
                        boneindex = v.boneindex,
                        coords = v.coords,
                        norm = v.norm,
                    }
                else
                    AreaNetEvidence[k] = nil
                end
            end
        end
    end
end)

CreateThread(function() -- optmized camera thread, pulls evidence from the cached area evidence and performs distance checking to reduce load on the camera
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn then
            if Config.Debug.ViewEvidence.enabled or ActiveFR or viewev then
                if (Config.Debug.ViewEvidence.enabled or nikon or viewev) and (Config.Debug.ViewEvidence.enabled or not IsPedInAnyVehicle(ped)) then
                    CamEvidence = {}
                    local camId = 1
                    for k, v in pairs(AreaEvidence) do
                        if v.distance < camdist then
                            CamEvidence[camId] = {
                                evidenceId = k,
                                distance = v.distance,
                                tag = v.tag,
                                color = v.color,
                                size = v.size,
                                coords = v.coords,
                                norm = v.norm,
                                bucket = v.bucket,
                            }
                            camId = camId + 1
                        end
                    end
                    for k, v in pairs(AreaNetEvidence) do
                        if v.distance < camdist then
                            CamEvidence[camId] = {
                                evidenceId = k,
                                distance = v.distance,
                                tag = v.tag,
                                color = v.color,
                                netev = v.netev,
                                entity = v.entity,
                                size = v.size,
                                boneindex = v.boneindex,
                                coords = v.coords,
                                norm = v.norm,
                            }
                            camId = camId + 1
                        end
                    end
                    table.sort(CamEvidence, function(a, b)
                        return a.distance < b.distance
                    end)
                end
            else
                Wait(2000)
            end
        else
            Wait(5000)
        end
    end
end)

CreateThread(function() -- optimized camera script, draws the evidence markers and labels
    while true do
        Wait(0)
        if nikon or viewev or Config.Debug.ViewEvidence.enabled then
            local i = 1
            for k, v in pairs(CamEvidence) do
                local drawcoords = v.coords
                if v.boneindex then drawcoords = GetWorldPositionOfEntityBone(v.entity, v.boneindex) elseif v.netev then drawcoords = GetOffsetFromEntityInWorldCoords(v.entity, drawcoords.x, drawcoords.y, drawcoords.z) end
                local isOnScreen = IsSphereVisible(drawcoords.x, drawcoords.y, drawcoords.z, 0.50)
                if (not v.bucket or (v.bucket and curbucket == v.bucket)) and isOnScreen and (not CurrentEvidence or v.evidenceId ~= CurrentEvidence.evidenceId) then
                    if not v.boneindex and v.tag then 
                        DrawMarker(28, drawcoords.x, drawcoords.y, drawcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size, v.size, v.size, v.color.r, v.color.g, v.color.b, camopac, false, false, 2, nil, nil, false) 
                    end
                    if v.norm then
                        if not v.netev then
                            DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, v.norm.x, v.norm.y, v.norm.z, v.color.r, v.color.g, v.color.b, camopac)
                        else
                            local normoffset = GetOffsetFromEntityInWorldCoords(v.entity, v.norm.x, v.norm.y, v.norm.z)
                            DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, normoffset.x, normoffset.y, normoffset.z, v.color.r, v.color.g, v.color.b, camopac)
                        end
                    end
                    if  i ~= camlim + 1 and v.distance > cammin then
                        DrawText3D(drawcoords.x, drawcoords.y, drawcoords.z, v.tag)
                        i = i + 1
                    end
                end
            end
        else    
            Wait(700)
        end
    end
end)

CreateThread(function() -- optimized flashlight thread, enables police to use flashlight to reveal and pickup evidence
    while true do
        Wait(0)
        if LocalPlayer.state.isLoggedIn then
            if ActiveFR then
                if usingflashlight then
                    pos = GetEntityCoords(ped)
                    if next(AreaEvidence) then
                        local CurEv = nil
                        local CurEvId = nil
                        for k, v in pairs(AreaEvidence) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if ActiveLEO and (dist < pudist and v.pickup) then
                                if not CurEv or (CurEv and dist < CurEv) then
                                    CurEv = dist
                                    CurEvId = k
                                end
                            end
                        end
                        if CurEv then
                            if not CurEvLoopRunning then CurEvLoop() end
                            CurrentEvidence = table.clone(AreaEvidence[CurEvId])
                            CurrentEvidence.evidenceId = CurEvId
                        else
                            CurrentEvidence = nil
                        end
                        for k, v in pairs(AreaEvidence) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if (not v.bucket or (v.bucket and curbucket == v.bucket)) and dist < flashdist and (not CurrentEvidence or k ~= CurrentEvidence.evidenceId) then
                                DrawMarker(28, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size, v.size, v.size, v.color.r, v.color.g, v.color.b, camopac, false, false, 2, nil, nil, false)
                                if v.norm then
                                    DrawLine(v.coords.x, v.coords.y, v.coords.z, v.norm.x, v.norm.y, v.norm.z, v.color.r, v.color.g, v.color.b, camopac)
                                end
                            end
                        end 
                        for k, v in pairs(AreaNetEvidence) do
                            local drawcoords = v.coords
                            if v.boneindex then drawcoords = GetWorldPositionOfEntityBone(v.entity, v.boneindex) elseif v.netev then drawcoords = GetOffsetFromEntityInWorldCoords(v.entity, drawcoords.x, drawcoords.y, drawcoords.z) end
                            local dist = #(pos - vector3(drawcoords.x, drawcoords.y, drawcoords.z))
                            if (not v.bucket or (v.bucket and curbucket == v.bucket)) and dist < flashdist and (not CurrentEvidence or k ~= CurrentEvidence.evidenceId) then
                                if not v.boneindex then DrawMarker(28, drawcoords.x, drawcoords.y, drawcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size, v.size, v.size, v.color.r, v.color.g, v.color.b, camopac, false, false, 2, nil, nil, false) end
                                if v.norm then
                                    if not v.netev then
                                        DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, v.norm.x, v.norm.y, v.norm.z, v.color.r, v.color.g, v.color.b, camopac)
                                    else
                                        local normoffset = GetOffsetFromEntityInWorldCoords(v.entity, v.norm.x, v.norm.y, v.norm.z)
                                        DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, normoffset.x, normoffset.y, normoffset.z, v.color.r, v.color.g, v.color.b, camopac)
                                    end
                                end
                            end
                        end  
                    end
                else
                    Wait(1000) -- checks once per second if ped is aiming flashlight 
                end
            else
                Wait(5000) -- checks every five seconds if ped has police job
            end
        end
    end
end)