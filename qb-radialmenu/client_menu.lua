local QBCore = exports['qb-core']:GetCoreObject()

local showMenu = false
local DynamicMenuItems = {}

-- Keybind Lookup table
local keybindControls = {
	["`"] = 243, ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local MAX_MENU_ITEMS = 12

--[[

 MenuItemId2 = exports['qb-radialmenu']:AddOption({
        id = 'open_garage_menu',
        title = 'Open Garage',
        icon = 'warehouse',
        type = 'client',
        event = 'qb-garages:client:OpenMenu',
        shouldClose = true
    }, MenuItemId2)
]]

local function AddOption(data, id)
    local menuID = #DynamicMenuItems + 1
    local newItem = {
        id = data.id,
        title = data.title,
        icon = '#' ..data.icon,
        functionName = data.event,
        eventType = data.type,
        enableMenu = data.enableMenu,
        functionParameters = data.params
    }
    DynamicMenuItems[#DynamicMenuItems+1] = newItem
    -- print(menuID)
    return menuID
end

local function RemoveOption(id)
    DynamicMenuItems[id] = nil
end

exports('AddOption', AddOption)
exports('RemoveOption', RemoveOption)

function OpenRadial()
    showMenu = true
    local enabledMenus = {}
    for _, menuConfig in ipairs(rootMenuConfig) do
        if menuConfig:enableMenu() then
            local dataElements = {}
            local hasSubMenus = false
            if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                hasSubMenus = true
                local previousMenu = dataElements
                local currentElement = {}
                for i = 1, #menuConfig.subMenus do
                    -- if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
                    --     goto continue
                    -- end
                    currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                    currentElement[#currentElement].id = menuConfig.subMenus[i]
                    currentElement[#currentElement].enableMenu = nil

                    if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                        previousMenu[MAX_MENU_ITEMS + 1] = {
                            id = "_more",
                            title = "More",
                            icon = "#more",
                            items = currentElement
                        }
                        previousMenu = currentElement
                        currentElement = {}
                    end
                    --::continue::
                end
                if #currentElement > 0 then
                    previousMenu[MAX_MENU_ITEMS + 1] = {
                        id = "_more",
                        title = "More",
                        icon = "#more",
                        items = currentElement
                    }
                end
                dataElements = dataElements[MAX_MENU_ITEMS + 1].items

            end
            enabledMenus[#enabledMenus+1] = {
                id = menuConfig.id,
                title = menuConfig.displayName,
                functionName = menuConfig.functionName,
                parameters = menuConfig.functionParameters,
                icon = menuConfig.icon,
            }
            if hasSubMenus then
                enabledMenus[#enabledMenus].items = dataElements
            end
        end
    end

    TriggerEvent('qb-radialmenu:client:onRadialmenuOpen')

    if #DynamicMenuItems >= 1 then
        for k,v in pairs(DynamicMenuItems) do
            enabledMenus[#enabledMenus+1] = {
                id = v.id,
                title = v.title,
                functionName = v.functionName,
                eventType = v.eventType,
                parameters = v.functionParameters,
                icon = v.icon,
            }
        end
    end

    SendNUIMessage({
        state = "show",
        resourceName = GetCurrentResourceName(),
        data = enabledMenus,
        menuKeyBind = keyBind,
        menuType = (IsPedInAnyVehicle(PlayerPedId(), false) and 'small' or 'default')
    })
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(true, true)

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end

RegisterCommand("+radialMenu", function(source,args) 
    OpenRadial()
end)

RegisterKeyMapping('+radialMenu', 'Отваряне на Радиал Меню', 'keyboard', 'F1')

-- -- Main thread
-- Citizen.CreateThread(function()
--     local keyBind = "F1"
--     local keyBind2 = "-"
--     while true do
--         Citizen.Wait(0)
--         SetBigmapActive(false, false)
--         if IsControlPressed(1, keybindControls[keyBind]) or IsControlPressed(1, keybindControls[keyBind2]) and GetLastInputMethod(2) and showMenu then
--             showMenu = false
--             SetNuiFocus(false, false)
--         end
--         if IsControlPressed(1, keybindControls[keyBind]) or IsControlPressed(1, keybindControls[keyBind2]) and GetLastInputMethod(2) then
--             showMenu = true
--             local enabledMenus = {}
--             for _, menuConfig in ipairs(rootMenuConfig) do
--                 if menuConfig:enableMenu() then
--                     local dataElements = {}
--                     local hasSubMenus = false
--                     if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
--                         hasSubMenus = true
--                         local previousMenu = dataElements
--                         local currentElement = {}
--                         for i = 1, #menuConfig.subMenus do
--                             -- if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
--                             --     goto continue
--                             -- end
--                             currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
--                             currentElement[#currentElement].id = menuConfig.subMenus[i]
--                             currentElement[#currentElement].enableMenu = nil

--                             if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
--                                 previousMenu[MAX_MENU_ITEMS + 1] = {
--                                     id = "_more",
--                                     title = "More",
--                                     icon = "#more",
--                                     items = currentElement
--                                 }
--                                 previousMenu = currentElement
--                                 currentElement = {}
--                             end
--                             --::continue::
--                         end
--                         if #currentElement > 0 then
--                             previousMenu[MAX_MENU_ITEMS + 1] = {
--                                 id = "_more",
--                                 title = "More",
--                                 icon = "#more",
--                                 items = currentElement
--                             }
--                         end
--                         dataElements = dataElements[MAX_MENU_ITEMS + 1].items

--                     end
--                     enabledMenus[#enabledMenus+1] = {
--                         id = menuConfig.id,
--                         title = menuConfig.displayName,
--                         functionName = menuConfig.functionName,
--                         parameters = menuConfig.functionParameters,
--                         icon = menuConfig.icon,
--                     }
--                     if hasSubMenus then
--                         enabledMenus[#enabledMenus].items = dataElements
--                     end
--                 end
--             end

--             TriggerEvent('qb-radialmenu:client:onRadialmenuOpen')

--             if #DynamicMenuItems >= 1 then
--                 for k,v in pairs(DynamicMenuItems) do
--                     enabledMenus[#enabledMenus+1] = {
--                         id = v.id,
--                         title = v.title,
--                         functionName = v.functionName,
--                         eventType = v.eventType,
--                         parameters = v.functionParameters,
--                         icon = v.icon,
--                     }
--                 end
--             end

--             SendNUIMessage({
--                 state = "show",
--                 resourceName = GetCurrentResourceName(),
--                 data = enabledMenus,
--                 menuKeyBind = keyBind,
--                 menuType = (IsPedInAnyVehicle(PlayerPedId(), false) and 'small' or 'default')
--             })
--             SetCursorLocation(0.5, 0.5)
--             SetNuiFocus(true, true)

--             -- Play sound
--             PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)


--             while showMenu == true do Citizen.Wait(100) end
--             Citizen.Wait(100)
--             while IsControlPressed(1, keybindControls[keyBind]) or IsControlPressed(1, keybindControls[keyBind2]) and GetLastInputMethod(2) do Citizen.Wait(100) end
--         end
--     end
-- end)

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    TriggerEvent('qb-radialmenu:client:onRadialmenuClose')

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('triggerAction', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })
    if not data.eventType then data.eventType = "client" end

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Run command
    --ExecuteCommand(data.action)
    if data.eventType == "client" then
        print(data.action, data.parameters)
        TriggerEvent(data.action, data.parameters)
    elseif data.eventType == "server" then
        TriggerServerEvent(data.action, data.parameters)
    elseif data.eventType == "command" then
        ExecuteCommand(data.action)
    end

    -- Send ACK to callback function
    cb('ok')
end)

RegisterNetEvent('carmenuOpen', function ()
    ExecuteCommand('carmenu')
end)

RegisterNetEvent("menu:menuexit")
AddEventHandler("menu:menuexit", function()
    showMenu = false
    SetNuiFocus(false, false)
end)

RegisterCommand("nui_false", function(source, args)
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })
end)

RegisterNetEvent("sp-radial:togglegas")
AddEventHandler("sp-radial:togglegas", function()
   -- DeleteWaypoint()

    local currentGasBlip = 0

	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords

	for k,v in pairs(GasStations) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
            closestCoords = v
        end
    end

    SetNewWaypoint(closestCoords)

end)

RegisterNetEvent("sp-radial:togglebarber")
AddEventHandler("sp-radial:togglebarber", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords1

	for k,v in pairs(BarberShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
end)

RegisterNetEvent("sp-radial:toggletattos")
AddEventHandler("sp-radial:toggletattos", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(TattoShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)

RegisterNetEvent("fk:karakol")
AddEventHandler("fk:karakol", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Karakol) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)


RegisterNetEvent("fk:hastane")
AddEventHandler("fk:hastane", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Hastane) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)

RegisterNetEvent('sp-radial:coPDead', function(data)
    exports["sp-dispatch"]:OfficerDown()
end)

RegisterNetEvent('sp-radial:PanikButton', function(data)
    exports["sp-dispatch"]:OfficerInDistress()
end)

RegisterNetEvent("fk:galeri")
AddEventHandler("fk:galeri", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Galeri) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)



RegisterNetEvent("fk:motel")
AddEventHandler("fk:motel", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Motel) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)



RegisterNetEvent("sp-radial:togglegarage")
AddEventHandler("sp-radial:togglegarage", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Garage) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)

RegisterNetEvent("sp-radial:togglepd")
AddEventHandler("sp-radial:togglepd", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Garage) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
end)

TattoShops = {
	vector3(1322.6, -1651.9, 51.2),
	vector3(-1153.6, -1425.6, 4.9),
	vector3(322.1, 180.4, 103.5),
	vector3(-3170.0, 1075.0, 20.8),
	vector3(1864.6, 3747.7, 33.0),
	vector3(-293.7, 6200.0, 31.4)
}

Karakol = {
	vector3(431.91, -981.62, 30.71),
}

Galeri = {
	vector3(-44.83, -1112.31, 26.44)
}

Hastane = {
	vector3(342.55, -1397.93, 32.51),
}


BarberShops = {
	vector3(-814.308, -183.823, 36.568),
	vector3(136.826, -1708.373, 28.291),
	vector3(-1282.604, -1116.757, 5.990),
	vector3(1931.513, 3729.671, 31.844),
	vector3(1212.840, -472.921, 65.208),
	vector3(-32.885, -152.319, 56.076),
	vector3(-278.077, 6228.463, 30.695),
}

GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

RegisterNetEvent("police:radio1", function()
    exports['sp-radio']:joinRadio(1)
end)

RegisterNetEvent("police:radio2", function()
    exports['sp-radio']:joinRadio(2)
end)

RegisterNetEvent("police:radio3", function()
    exports['sp-radio']:joinRadio(3)
end)

RegisterNetEvent("police:radio4", function()
    exports['sp-radio']:joinRadio(4)
end)

RegisterNetEvent("police:radio5", function()
    exports['sp-radio']:joinRadio(5)
end)

RegisterNetEvent("police:radio6", function()
    exports['sp-radio']:joinRadio(6)
end)

RegisterNetEvent("police:radio7", function()
    exports['sp-radio']:joinRadio(7)
end)

RegisterNetEvent("police:radio8", function()
    exports['sp-radio']:joinRadio(8)
end)

RegisterNetEvent("police:radio9", function()
    exports['sp-radio']:joinRadio(9)
end)

RegisterNetEvent("police:radio10", function()
    exports['sp-radio']:joinRadio(10)
end)

RegisterNetEvent("sp-radialmenu:client:save-vehicle", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())

    if vehicle == nil then return end
    
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleIsStolen(vehicle, false)
    SetVehicleIsWanted(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')

    QBCore.Functions.Notify("Автомобилът беше запазен.", "primary", 3000)
end)