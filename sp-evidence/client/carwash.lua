QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()
ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()

-------------------------------------
----------- Configuration -----------
-------------------------------------

local use2Dtext = Config.CarWash.Settings.useQBdrawtext or Config.CarWash.Settings.useOXdrawtext and true

local use3Dtext = Config.CarWash.Settings.use3Dtext -- set to TRUE to use the built in 3D text function
local usePoly = Config.CarWash.Settings.usePoly and BoxZone and true or false -- this detects polyzones or coords in the config and if polyzone is imported in the manifest, DO NOT TOUCH if you do not know what you are doing 

if usePoly and not BoxZone then 
    print('You are trying too use polyzones for the car wash but do not have polyzones included in your fxmanifest.')
    print('Please use your F8 console and run "stop r14-evidence", then "refresh", update your fxmanifest to include polyzones, and then in F8 run "start r14-evidence"')
    print('I WILL NOT offer support on this, please upload the correct fxmanifest or check the polyzone documentation on how to include it in your manifest')
end

if Config.CarWash.Settings.useQBdrawtext and (not QBCore or not exports['qb-core'].DrawText) then
    print('You are attempting to use the qb-core DrawText function but it does not seem to exist')
    print('Please make sure you are running a build of qb-core with the DrawText() function.')
    print('Script will default to 3D text instead, I will not offer support on upgrading!')
end

if Config.CarWash.Settings.useOXdrawtext and not lib then
    print('You have selected ox_lib textUI but it does not seem like ox_lib is installed or being loaded correctly')
    print('Please use your F8 console and run "stop r14-evidence", then "refresh", update your fxmanifest to include ox_lib, and then in F8 run "start r14-evidence"')
    print('I WILL NOT offer support on this, please upload the correct fxmanifest or check the ox_lib documentation on how to include it in your manifest')
end

---------------------------------
----------- Variables -----------
---------------------------------

local curselection = false
local washingVehicle = false
local ped, pos, veh = nil
local listen = false
local washPoly = {}
local textDrawn = false

---------------------------------
----------- Functions -----------
---------------------------------

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(Config.CarWash.Settings.Label3D)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(Config.CarWash.Settings.Label3D)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawTextNUI(text)
    if Config.CarWash.Settings.useQBdrawtext then
        exports['qb-core']:DrawText(text, 'right')
    elseif Config.CarWash.Settings.useOXdrawtext then
        lib.showTextUI(text)
    end
    textDrawn = true
end

function HideText()
    if Config.CarWash.Settings.useQBdrawtext then
        exports['qb-core']:HideText()
    elseif Config.CarWash.Settings.useOXdrawtext then
       lib.hideTextUI()
    end
    textDrawn = false
end

function WashLoop(curcoords)
    CreateThread(function()
        while listen do
            local PlayerPed = PlayerPedId()
            local PedVehicle = GetVehiclePedIsIn(PlayerPed, false)
            local Driver = GetPedInVehicleSeat(PedVehicle, -1)

            if not washingVehicle then
                if not use2Dtext and use3Dtext then DrawText3Ds(curcoords.x, curcoords.y, curcoords.z) end

                if IsControlJustReleased(0, 38) then
                    if Driver == PlayerPed then
                        TriggerEvent('evidence:client:CarWashMenu')
                    else
                        Config.Functions.Notify("This is a car wash not a shower, friend...", "error")
                    end
                end
            end
            Wait(0)
        end
    end)
end

----------------------------------------------
----------- Network Event Handlers -----------
----------------------------------------------

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

RegisterNetEvent('evidence:client:CarWashMenu', function()
    carwashMenu = {}
    
    carwashMenu[#carwashMenu + 1] = {
        header = "Автомивка",
        isMenuHeader = true
    }

    if Config.Context.Ox then carwashMenu = {} end

    carwashMenu[#carwashMenu + 1] = {
        header = Config.CarWash.Exterior.Label,
        title = Config.CarWash.Exterior.Label,
        txt = Config.CarWash.Exterior.Description,
        description = Config.CarWash.Exterior.Description,
        params = {
            event = 'evidence:client:setcarwashselection',
            args = {
                selection = 'exterior',
            }
        },
        event = 'evidence:client:setcarwashselection',
        args = {
            selection = 'exterior',
        },
    }

    carwashMenu[#carwashMenu + 1] = {
        header = Config.CarWash.Interior.Label,
        title = Config.CarWash.Interior.Label,
        txt = Config.CarWash.Interior.Description,
        description = Config.CarWash.Interior.Description,
        params = {
            event = 'evidence:client:setcarwashselection',
            args = {
                selection = 'interior',
            }
        },
        event = 'evidence:client:setcarwashselection',
        args = {
            selection = 'interior',
        },
    }
    OpenContext(carwashMenu, "Автомивка")
end)

RegisterNetEvent('evidence:client:setcarwashselection', function(data)
    curselection = data.selection
    TriggerServerEvent('evidence:server:washCar')
end)


RegisterNetEvent('evidence:client:washCar', function()
    washingVehicle = true
    
    local progtext = 'Поддържане на машините в работен режим..'
    local progtime = math.random(4000, 8000)

    if curselection == 'interior' then
        progtext = 'Прахосмукиране на опаковките от BurgerShot.'
        progtime = math.random(12000, 20000)
    end

    Config.Functions.Progressbar("search_cabin", progtext, progtime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if curselection == 'exterior' then
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleUndriveable(veh, false)
            WashDecalsFromVehicle(veh, 1.0)
        elseif curselection == 'interior' then 
            local plate = Config.Functions.GetPlate(veh) 
            TriggerServerEvent('evidence:server:RemoveCarEvidence', plate) 
        end
        Config.Functions.Notify("Почистени сте! Вече можете да тръгвате", "success")
        washingVehicle = false
    end, function() -- Cancel
        Config.Functions.Notify("Почистването е прекъснато", "error")
        washingVehicle = false
    end)

    washingVehicle = true
end)

CreateThread(function()
	while true do
        if LocalPlayer.state.isLoggedIn then
	        ped = PlayerPedId()   
            veh = GetVehiclePedIsIn(ped)
        end
        Wait(1000)
	end
end)

-------------------------------
----------- Threads -----------
-------------------------------
if usePoly then -- uses new refactored qb-smallresources carwash code to support polyzones
    CreateThread(function()
        for k, v in pairs(Config.CarWash.Locations) do
            washPoly[#washPoly+1] = BoxZone:Create(vector3(v.Coords.x, v.Coords.y, v.Coords.z), v.Length or 8, v.Width or 4, {
                heading = v.Heading,
                name = 'carwash',
                debugPoly = Config.CarWash.Settings.debugPoly,
                minZ = v.Coords.z - 5,
                maxZ = v.Coords.z + 5,
            })
            local washCombo = ComboZone:Create(washPoly, {name = "washPoly"})
            washCombo:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    if not use3Dtext and (Config.CarWash.usePoly or use2Dtext) then DrawTextNUI(Config.CarWash.Settings.Label2D) end
                    if not listen then
                        listen = true
                        WashLoop(v.Coords)
                    end
                else
                    listen = false
                    if textDrawn then HideText() end
                end
            end)
        end
    end)
else -- creates thread running older distance check/coords
    CreateThread(function()
        while true do
            local inRange = false

            if IsPedInAnyVehicle(ped) then
                pos = GetEntityCoords(ped)
                for k, v in pairs(Config.CarWash.Locations) do
                    local coords = v.Coords
                    local dist = #(pos - vector3(coords.x, coords.y, coords.z))
                    if dist <= 10 then
                        inRange = true
                        if dist <= 7.5 then
                            if GetPedInVehicleSeat(veh, -1) == ped then
                                if not washingVehicle then
                                    if use2Dtext and not textDrawn then DrawTextNUI(Config.CarWash.Settings.Label2D, 'left') elseif use3Dtext then DrawText3Ds(coords.x, coords.y, coords.z) end                                   
                                    if IsControlJustReleased(0, 38) then
                                        TriggerEvent('evidence:client:CarWashMenu')
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not inRange then
                if textDrawn then HideText() end
                Wait(5000)
            end
            Wait(0)
        end
    end)
end

-- CreateThread(function()
--     for k, v in pairs(Config.CarWash.Locations) do
--         local coords = Config.CarWash.Locations[k].Coords
--         local carWash = AddBlipForCoord(coords.x, coords.y, coords.z)
--         SetBlipSprite (carWash, 100)
--         SetBlipDisplay(carWash, 4)
--         SetBlipScale  (carWash, 0.75)
--         SetBlipAsShortRange(carWash, true)
--         SetBlipColour(carWash, 37)
--         BeginTextCommandSetBlipName("STRING")
--         AddTextComponentSubstringPlayerName(Config.CarWash.Locations[k]["label"] or Config.CarWash.Blip.Name)
--         EndTextCommandSetBlipName(carWash)
--     end
-- end)