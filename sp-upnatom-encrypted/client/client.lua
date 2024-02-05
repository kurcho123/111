local SPCore = exports['qb-core']:GetCoreObject()

local IsOnDuty = false
local IsWearingWorkClothes = false
local ZoneIds = {}
local CurrentOrder = {}

-- Threads
CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = Config.Tray.Coords,
        size = vec3(0.7, 0.7, 4),
        -- debug = true,
        options = {
            { targetIcon = "fa-solid fa-burger" },
            {
                icon = "fa-solid fa-plate-wheat",
                label = "Вземи Храна",
                onSelect = function()
                    TriggerServerEvent("sp-upnatom:server:register-tray")
                    exports.ox_inventory:openInventory("stash", "up-n-atom-tray")
                end,
                distance = 2.0,
            },
        },
    })

    for k, v in pairs(Config.Locations.Counters) do
        exports.ox_target:addBoxZone({
            coords = v.Coords,
            size = vec3(0.7, 0.7, 4),
            -- debug = true,
            options = {
                { targetIcon = "fa-solid fa-burger" },
                {
                    icon = "fa-solid fa-wallet",
                    label = "Плати Храна",
                    onSelect = function()
                        TriggerEvent("sp-upnatom:client:open-payment-menu")
                    end,
                    distance = 2.0,
                },
            },
        })
    end
end)

exports.ox_inventory:displayMetadata({
    upnatom_lettuce = 'Зеле: ',
    ["upnatom-tomato"] = 'Домати: ',
    ["upnatom-onion"] = 'Лук: ',
    ["upnatom-bacon"] = 'Бекон: ',
    ["upnatom-pickles"] = 'Краставички: ',
    ["upnatom-ketchup"] = 'Кетчуп: ',
    ["upnatom-mayonaise"] = 'Майонеза: ',
    ["upnatom-mustard"] = 'Горчица: ',
    ["upnatom-meat"] = 'Месо: ',
    ["upnatom-ice"] = 'Лед: ',
})

exports.ox_inventory:displayMetadata({
    payment = 'Сума: $',
})

-- Functions
function StopWorking()
    if IsOnDuty == true then
        TriggerServerEvent("sp-upnatom:server:toggle-duty-off")
        SPCore.Functions.Notify("Спряхте да работите.", "primary", 3000)
        IsOnDuty = false
    end
end

local box = lib.zones.box({
	name = "upnatom",
	coords = vec3(84.23, 284.0, 110.0 - 2),
	size = vec3(34.5, 36.0, 14.0),
	rotation = 340.0,
    onExit = StopWorking,
})

function CanInteract(zone, zoneId)
    return not Config.Locations[zone][zoneId].IsBusy
end

function AddZones()
    for _, zonesData in pairs(Config.Locations) do
        for __, zoneData in pairs(zonesData) do
            local zoneId = exports.ox_target:addBoxZone({
                coords = zoneData.Coords,
                size = vec3(0.7, 0.7, 4),
                -- debug = true,
                options = {
                    { targetIcon = "fa-solid fa-burger" },
                    {
                        icon = zoneData.Icon,
                        label = zoneData.Label .. ((#Config.Locations[_] > 1) == true and (" - " .. __) or ""),
                        canInteract = function()
                            return CanInteract(_, __)
                        end,
                        onSelect = function()
                            TriggerEvent(zoneData.Event, zoneData.Params)
                        end,
                        distance = 2.0,
                    },
                },
            })

            table.insert(ZoneIds, zoneId)
        end
    end

    local zoneId = exports.ox_target:addBoxZone({
        coords = Config.Packaging.Coords,
        size = vec3(0.7, 0.7, 4),
        -- debug = true,
        options = {
            { targetIcon = "fa-solid fa-burger" },
            {
                icon = "fa-solid fa-box-open",
                label = "Оставете артикули в поръчка",
                onSelect = function()
                    TriggerEvent("sp-upnatom:client:package-current-order")
                end,
                distance = 2.0,
            },
        },
    })

    table.insert(ZoneIds, zoneId)
end

function RemoveZones()
    for _, zoneId in pairs(ZoneIds) do
        exports.ox_target:removeZone(zoneId)
    end

    ZoneIds = {}
end

local function deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end
  
    local no
    if type(o) == 'table' then
      no = {}
      seen[o] = no
  
      for k, v in next, o, nil do
        no[deepcopy(k, seen)] = deepcopy(v, seen)
      end
      setmetatable(no, deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
      no = o
    end
    return no
end  

function CalculateOrderPrice(OrderData)
    local Price = 0

    for orderId, orderData in pairs(OrderData) do
        if orderId ~= "Time" and orderId ~= "IsDone" and orderId ~= "Sender" and orderId ~= "Paid" then
            Price = Price + orderData.Price 
        end
    end

    return Price
end

-- Events
RegisterNetEvent("sp-upnatom:client:toggle-duty-off", function()
    IsOnDuty = false
    RemoveZones()
    SPCore.Functions.Notify("Излязохте от смяна!", "primary", 3000)
end)

RegisterNetEvent("sp-upnatom:client:toggle-duty-on", function()
    IsOnDuty = true
    AddZones()
    SPCore.Functions.Notify("Влязохте на смяна!", "primary", 3000)
end)

RegisterNetEvent("sp-upnatom:client:open-cash-register", function(RegisterId)
    TriggerServerEvent("sp-upnatom:server:toggle-something", "Counters", RegisterId, true)

    local MenuData = {
        id = 'order-' .. RegisterId,
        title = 'Създаване На Поръчка',
        onExit = function()
            TriggerServerEvent("sp-upnatom:server:toggle-something", "Counters", RegisterId, false)
            CurrentOrder = {}
        end,
        options = {
            {
                title = 'Завърши Поръчка',
                disabled = CurrentOrder[1] == nil,
                icon = 'fa-solid fa-square-check',
                iconColor = CurrentOrder[1] ~= nil and "yellowgreen" or "gray",
                arrow = true,
                onSelect = function()
                    TriggerServerEvent("sp-upnatom:server:finish-order", { Order = CurrentOrder })
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "Counters", RegisterId, false)
                    CurrentOrder = {}
                end,
            },
        }
    }

    for k, v in pairs(CurrentOrder) do
        local RemovedItems = ""

        if v.Aditionals ~= nil then
            for k, v in pairs(v.Aditionals) do
                if v.IsRemoved then
                    RemovedItems = RemovedItems ~= "" and (RemovedItems .. ", " .. v.Item) or v.Item
                end
            end
        end

        table.insert(MenuData.options, {
            title = v.Item,
            description = "$" .. v.Price .. (RemovedItems ~= "" and (" | Без: " .. RemovedItems) or ""),
            arrow = true,
            onSelect = function()
                table.remove(CurrentOrder, k)
                TriggerEvent("sp-upnatom:client:open-cash-register", RegisterId)
            end
        })
    end

    table.insert(MenuData.options, {
        title = "Добави Артикул",
        event = 'sp-upnatom:client:add-order-item',
        icon = 'fa-solid fa-square-plus',
        iconColor = "yellowgreen",
        arrow = true,
        args = RegisterId
    })

    lib.registerContext(MenuData)
    lib.showContext('order-' .. RegisterId)
end)

RegisterNetEvent("sp-upnatom:client:add-order-item", function(RegisterId)
    local MenuData = {
        id = 'item-menu-' .. RegisterId,
        title = 'Добави Артикул',
        canClose = false,
        options = {
            {
                title = 'Върни Се Назад',
                icon = 'fa-solid fa-chevron-left',
                iconColor = "#38a2e5",
                event = 'sp-upnatom:client:open-cash-register',
                args = RegisterId
            },
        }
    }

    for k, v in pairs(Config.Menu) do
        table.insert(MenuData.options, {
            title = v.Item,
            event = v.Aditionals ~= nil and 'sp-upnatom:client:add-to-order-aditional' or 'sp-upnatom:client:add-to-order',
            arrow = v.Aditionals ~= nil,
            args = {
                ItemData = v,
                RegisterId = RegisterId
            }
        })
    end

    lib.registerContext(MenuData)
    lib.showContext('item-menu-' .. RegisterId)
end)

RegisterNetEvent("sp-upnatom:client:add-to-order", function(data)
    local ItemData = deepcopy(data.ItemData)
    local RegisterId = data.RegisterId

    table.insert(CurrentOrder, ItemData)
    TriggerEvent("sp-upnatom:client:open-cash-register", RegisterId)
end)

RegisterNetEvent("sp-upnatom:client:add-to-order-aditional", function(data)
    local ItemData = deepcopy(data.ItemData)
    local RegisterId = data.RegisterId

    local MenuData = {
        id = 'item-menu-' .. RegisterId,
        title = 'Добави Артикул',
        canClose = false,
        options = {
            {
                title = 'Добави',
                icon = 'fa-solid fa-square-check',
                iconColor = "yellowgreen",
                onSelect = function()
                    table.insert(CurrentOrder, ItemData)
                    TriggerEvent("sp-upnatom:client:open-cash-register", RegisterId)
                end
            },
        }
    }

    for k, v in pairs(ItemData.Aditionals) do
        table.insert(MenuData.options, {
            title = v.Item,
            icon = v.IsRemoved == true and 'fa-solid fa-square-xmark' or 'fa-solid fa-square-check',
            onSelect = function()
                if v.IsRemoved == true then
                    v.IsRemoved = false
                else
                    v.IsRemoved = true
                end
                TriggerEvent("sp-upnatom:client:add-to-order-aditional", { ItemData = ItemData, RegisterId = RegisterId })
            end
        })
    end

    lib.registerContext(MenuData)
    lib.showContext('item-menu-' .. RegisterId)
end)

RegisterNetEvent("sp-upnatom:client:update-config", function(config)
    Config = config
end)

RegisterNetEvent("sp-upnatom:client:open-cutting-board", function(BoardId)
    TriggerServerEvent("sp-upnatom:server:toggle-something", "CuttingBoards", BoardId, true)

    local MenuData = {
        id = 'cutting-board-' .. BoardId,
        title = 'Рязане На Продукти',
        onExit = function()
            TriggerServerEvent("sp-upnatom:server:toggle-something", "CuttingBoards", BoardId, false)
        end,
        options = {}
    }

    for k, v in pairs(Config.Cuttables) do
        table.insert(MenuData.options, {
            title = v.Item,
            disabled = exports.ox_inventory:Search('count', v.ItemName) <= 0,
            onSelect = function()
                local input = lib.inputDialog('Въведи количество', {'Количество'})
                if not input then 
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "CuttingBoards", BoardId, false)
                    return 
                end

                local quantity = tonumber(input[1])
                local quantityHas = exports.ox_inventory:Search('count', v.ItemName)

                if quantity > quantityHas then
                    SPCore.Functions.Notify("Нямате такова количество в себе си.", "error", 3000)
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "CuttingBoards", BoardId, false)
                    return
                end

                SPCore.Functions.Progressbar("cut-products", 'Режете ' .. v.Item, 5000 * quantity, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 49,
                }, {}, {}, function()
                    TriggerServerEvent("sp-upnatom:server:cut-item", v.ItemName, v.ItemGives, quantity, 5)
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "CuttingBoards", BoardId, false)
                end)
            end
        })
    end

    lib.registerContext(MenuData)
    lib.showContext('cutting-board-' .. BoardId)
end)

RegisterNetEvent("sp-upnatom:client:open-potato-frier", function(FrierId)
    TriggerServerEvent("sp-upnatom:server:toggle-something", "PotatoFriers", FrierId, true)

    local input = lib.inputDialog('Въведи количество', {'Количество'})
    if not input then 
        TriggerServerEvent("sp-upnatom:server:toggle-something", "PotatoFriers", FrierId, false)
        return 
    end

    local quantity = tonumber(input[1])
    local quantityHas = exports.ox_inventory:Search('count', "upnatom-fries-unfried")

    if quantity > quantityHas then
        SPCore.Functions.Notify("Нямате такова количество в себе си.", "error", 3000)
        TriggerServerEvent("sp-upnatom:server:toggle-something", "PotatoFriers", FrierId, false)
        return
    end

    SPCore.Functions.Progressbar("cut-products", 'Пържите Картофки', 8000 * quantity, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },
    {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 49,
    }, {}, {}, function()
        TriggerServerEvent("sp-upnatom:server:cut-item", "upnatom-fries-unfried", "upnatom-fries-unpacked", quantity, 20)
        TriggerServerEvent("sp-upnatom:server:toggle-something", "PotatoFriers", FrierId, false)
    end)
end)

RegisterNetEvent("sp-upnatom:client:open-potato-packer", function(PackerId)
    TriggerServerEvent("sp-upnatom:server:toggle-something", "FriesPacking", PackerId, true)

    local input = lib.inputDialog('Въведи количество (10 картофки = 1 пакетирани картофки)', {'Количество'})
    if not input then 
        TriggerServerEvent("sp-upnatom:server:toggle-something", "FriesPacking", PackerId, false)
        return 
    end

    local quantity = tonumber(input[1])
    local quantityHas = exports.ox_inventory:Search('count', "upnatom-fries-unpacked")

    if quantity > quantityHas or quantity % 10 ~= 0 then
        SPCore.Functions.Notify("Нямате такова количество в себе си или количеството не се дели на 10.", "error", 3000)
        TriggerServerEvent("sp-upnatom:server:toggle-something", "FriesPacking", PackerId, false)
        return
    end

    SPCore.Functions.Progressbar("cut-products", 'Пакетирате Картофки', 5000 * (quantity / 10), false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },
    {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 49,
    }, {}, {}, function()
        TriggerServerEvent("sp-upnatom:server:cut-item-dividable", "upnatom-fries-unpacked", "upnatom-fries", quantity, 10)
        TriggerServerEvent("sp-upnatom:server:toggle-something", "FriesPacking", PackerId, false)
    end)
end)

RegisterNetEvent("sp-upnatom:client:open-frier", function(FrierId)
    TriggerServerEvent("sp-upnatom:server:toggle-something", "EverythingElseFriers", FrierId, true)

    local MenuData = {
        id = 'everything-frier-' .. FrierId,
        title = 'Пържене На Продукти',
        onExit = function()
            TriggerServerEvent("sp-upnatom:server:toggle-something", "EverythingElseFriers", FrierId, false)
        end,
        options = {}
    }

    for k, v in pairs(Config.Friables) do
        table.insert(MenuData.options, {
            title = v.Item,
            disabled = exports.ox_inventory:Search('count', v.ItemName) <= 0,
            onSelect = function()
                local input = lib.inputDialog('Въведи количество', {'Количество'})
                if not input then 
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "EverythingElseFriers", FrierId, false)
                    return 
                end

                local quantity = tonumber(input[1])
                local quantityHas = exports.ox_inventory:Search('count', v.ItemName)

                if quantity > quantityHas then
                    SPCore.Functions.Notify("Нямате такова количество в себе си.", "error", 3000)
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "EverythingElseFriers", FrierId, false)
                    return
                end

                SPCore.Functions.Progressbar("cut-products", 'Пържите ' .. v.Item, 15000 * quantity, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 49,
                }, {}, {}, function()
                    TriggerServerEvent("sp-upnatom:server:cut-item", v.ItemName, v.ItemGives, quantity, 1)
                    TriggerServerEvent("sp-upnatom:server:toggle-something", "EverythingElseFriers", FrierId, false)
                end)
            end
        })
    end

    lib.registerContext(MenuData)
    lib.showContext('everything-frier-' .. FrierId)
end)

RegisterNetEvent("sp-upnatom:client:open-burger-assembly", function(AssemblyId)
    TriggerServerEvent("sp-upnatom:server:toggle-something", "EatingItemAssembler", AssemblyId, true)

    local MenuData = {
        id = 'burger-assembly-' .. AssemblyId,
        title = 'Направи Бургер/Чили Дог',
        onExit = function()
            TriggerServerEvent("sp-upnatom:server:toggle-something", "EatingItemAssembler", AssemblyId, false)
        end,
        options = {}
    }

    for k, v in pairs(Config.Menu) do
        if v.Aditionals ~= nil then
            if v.Aditionals[1].ItemName ~= "upnatom-ice" then
                table.insert(MenuData.options, {
                    title = v.Item,
                    onSelect = function()
                        TriggerEvent("sp-upnatom:client:open-burger-assembly-menu", v, AssemblyId)
                    end
                })
            end
        end
    end

    lib.registerContext(MenuData)
    lib.showContext('burger-assembly-' .. AssemblyId)
end)

RegisterNetEvent("sp-upnatom:client:open-burger-assembly-menu", function(BurgerData, AssemblyId)
    local BurgerData = deepcopy(BurgerData)
    local MenuData = {
        id = 'burger-assembly-menu',
        title = 'Правите ' .. BurgerData.Item,
        onExit = function()
            TriggerServerEvent("sp-upnatom:server:toggle-something", "EatingItemAssembler", AssemblyId, false)
        end,
        options = {
            {
                title = 'Направи ' .. BurgerData.Item,
                icon = 'fa-solid fa-square-check',
                iconColor = "yellowgreen",
                arrow = true,
                onSelect = function()
                    local hasAllItems = true

                    for k, v in pairs(BurgerData.Aditionals) do
                        if v.IsRemoved ~= true then
                            local itemCount = exports.ox_inventory:Search('count', v.ItemName)
    
                            if itemCount <= 0 then
                                hasAllItems = false
                            end
                        end
                    end

                    if hasAllItems then
                        SPCore.Functions.Progressbar("assemble-burger", 'Правите ' .. BurgerData.Item, 20000, false, false, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        {
                            animDict = "mini@repair",
                            anim = "fixing_a_player",
                            flags = 49,
                        }, {}, {}, function()
                            TriggerServerEvent("sp-upnatom:server:make-burger", BurgerData)
                            TriggerServerEvent("sp-upnatom:server:toggle-something", "EatingItemAssembler", AssemblyId, false)
                        end)
                    else
                        SPCore.Functions.Notify("Нямате необходимите продукти в себе си.", "error", 3000)
                        TriggerServerEvent("sp-upnatom:server:toggle-something", "EatingItemAssembler", AssemblyId, false)
                    end

                end,
            },
        }
    }

    for k, v in pairs(BurgerData.Aditionals) do
        table.insert(MenuData.options, {
            title = v.Item,
            icon = v.IsRemoved == true and 'fa-solid fa-square-xmark' or 'fa-solid fa-square-check',
            onSelect = function()
                if v.IsRemoved == true then
                    v.IsRemoved = false
                else
                    v.IsRemoved = true
                end
                TriggerEvent("sp-upnatom:client:open-burger-assembly-menu", BurgerData, AssemblyId)
            end
        })
    end

    lib.registerContext(MenuData)
    lib.showContext('burger-assembly-menu')
end)

RegisterNetEvent("sp-upnatom:client:package-current-order", function()
    lib.callback('sp-upnatom:server:get-current-order', false, function(orderData)
        if orderData == nil then return SPCore.Functions.Notify("В момента няма активна поръчка.", "error", 3000) end

        local order = orderData.Order
        local orderId = orderData.OrderId

        TriggerServerEvent("sp-upnatom:server:toggle-packaging", true)

        local MenuData = {
            id = 'package-order-' .. orderId,
            title = 'Пакетиране На Поръчка №' .. orderId,
            onExit = function()
                TriggerServerEvent("sp-upnatom:server:toggle-packaging", false)
            end,
            options = {
                {
                    title = 'Завърши Поръчка',
                    disabled = not order.IsDone,
                    icon = 'fa-solid fa-square-check',
                    iconColor = order.IsDone and "yellowgreen" or "gray",
                    arrow = true,
                    onSelect = function()
                        TriggerServerEvent("sp-upnatom:server:finish-final-order")
                        TriggerServerEvent("sp-upnatom:server:toggle-packaging", false)
                    end,
                }
            }
        }
    
        for k, v in pairs(order) do
            if k ~= "Time" and k ~= "IsDone" and k ~= "Sender" and k ~= "Paid" then
                local RemovedItems = ""
    
                if v.Aditionals ~= nil then
                    for k, v in pairs(v.Aditionals) do
                        if v.IsRemoved then
                            RemovedItems = RemovedItems ~= "" and (RemovedItems .. ", " .. v.Item) or v.Item
                        end
                    end
                end
        
                table.insert(MenuData.options, {
                    title = v.Item,
                    description = RemovedItems ~= "" and ("Без: " .. RemovedItems) or "",
                    disabled = v.IsAdded or false,
                    arrow = true,
                    onSelect = function()
                        TriggerServerEvent("sp-upnatom:server:try-finish-product", k)
                    end
                })
            end
        end
    
        lib.registerContext(MenuData)
        lib.showContext('package-order-' .. orderId)
    end)
end)

function deepcompare(t1,t2,ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not deepcompare(v1,v2) then return false end
    end
    for k2,v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not deepcompare(v1,v2) then return false end
    end
    return true
end

lib.callback.register('sp-upnatom:client:get-burger-by-metadata', function(item, metadata)
    local burgers = exports.ox_inventory:Search("slots", item)

    for i = 1, #burgers do
        local burger = burgers[i]

        if deepcompare(burger.metadata, metadata) then
            return burgers[i].slot
        end
    end

    return false
end)

lib.callback.register('sp-upnatom:client:is-wearing-work-clothes', function()
    return IsWearingWorkClothes
end)

RegisterNetEvent("sp-upnatom:client:open-payment-menu", function()
    lib.callback('sp-upnatom:server:get-current-order', false, function(orderData)
        if orderData == nil or orderData.Order.Paid == true then return SPCore.Functions.Notify("В момента няма фактури за плащане.", "error", 3000) end

        local order = orderData.Order
        local orderId = orderData.OrderId

        local MenuData = {
            id = 'payment-order-' .. orderId,
            title = 'Плащане На Поръчка №' .. orderId,
            options = {
                {
                    title = 'Цена: $' .. CalculateOrderPrice(order) .. ' + включени такси',
                    icon = 'fa-solid fa-money-check-dollar',
                    iconColor = "gray",
                    readOnly = true,
                },
                {
                    title = 'Плати В Брой',
                    icon = 'fa-solid fa-money-bill-wave',
                    iconColor = "gray",
                    arrow = true,
                    onSelect = function()
                        TriggerServerEvent("sp-upnatom:server:pay-for-order", false)
                    end,
                },
                {
                    title = 'Плати С Карта',
                    icon = 'fa-solid fa-credit-card',
                    iconColor = "gray",
                    arrow = true,
                    onSelect = function()
                        TriggerServerEvent("sp-upnatom:server:pay-for-order", true)
                    end,
                },
            }
        }
    
        lib.registerContext(MenuData)
        lib.showContext('payment-order-' .. orderId)
    end)
end)

RegisterNetEvent("sp-upnatom:client:open-drink-maker", function(DrinkId)
    local MenuData = {
        id = 'drink-assembly-' .. DrinkId,
        title = 'Сипи Напитка',
        options = {}
    }

    for k, v in pairs(Config.Drinkables) do
        table.insert(MenuData.options, {
            title = v.Item,
            onSelect = function()
                TriggerEvent("sp-upnatom:client:open-drink-assembly-menu", v, DrinkId)
            end
        })
    end

    lib.registerContext(MenuData)
    lib.showContext('drink-assembly-' .. DrinkId)
end)

RegisterNetEvent("sp-upnatom:client:open-drink-assembly-menu", function(DrinkData, DrinkId)
    local DrinkData = deepcopy(DrinkData)
    local MenuData = {
        id = 'drink-assembly-menu',
        title = 'Сипвате ' .. DrinkData.Item,
        options = {
            {
                title = 'Направи ' .. DrinkData.Item,
                icon = 'fa-solid fa-square-check',
                iconColor = "yellowgreen",
                arrow = true,
                onSelect = function()
                    local hasAllItems = true

                    if DrinkData.Aditionals ~= nil then
                        for k, v in pairs(DrinkData.Aditionals) do
                            if v.IsRemoved ~= true then
                                local itemCount = exports.ox_inventory:Search('count', v.ItemName)
            
                                if itemCount <= 0 then
                                    hasAllItems = false
                                end
                            end
                        end
                    end

                    local itemCount = exports.ox_inventory:Search('count', DrinkData.ItemName)

                    if itemCount <= 0 then
                        hasAllItems = false
                    end

                    if hasAllItems then
                        SPCore.Functions.Progressbar("assemble-burger", 'Правите ' .. DrinkData.Item, 7000, false, false, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        {
                            animDict = "mini@repair",
                            anim = "fixing_a_player",
                            flags = 49,
                        }, {}, {}, function()
                            TriggerServerEvent("sp-upnatom:server:make-drink", DrinkData)
                        end)
                    else
                        SPCore.Functions.Notify("Нямате необходимите продукти в себе си.", "error", 3000)
                    end
                end,
            },
        }
    }

    if DrinkData.Aditionals ~= nil then
        for k, v in pairs(DrinkData.Aditionals) do
            table.insert(MenuData.options, {
                title = v.Item,
                icon = v.IsRemoved == true and 'fa-solid fa-square-xmark' or 'fa-solid fa-square-check',
                onSelect = function()
                    if v.IsRemoved == true then
                        v.IsRemoved = false
                    else
                        v.IsRemoved = true
                    end
                    TriggerEvent("sp-upnatom:client:open-drink-assembly-menu", DrinkData, AssemblyId)
                end
            })
        end
    end

    lib.registerContext(MenuData)
    lib.showContext('drink-assembly-menu')
end)

RegisterNetEvent("sp-upnatom:client:get-payslip-money", function()
    local checks = exports.ox_inventory:Search("slots", "payslip")

    for i = 1, #checks do
        local check = checks[i]
        local payment = check?.metadata?.payment or 1

        TriggerServerEvent("sp-upnatom:server:get-payslip-money", checks[i].slot, payment)

        return
    end

    SPCore.Functions.Notify("Нямаш чек в себе си.", "error", 3000)
end)

RegisterNetEvent("sp-upnatom:client:work-clothes", function()
    local Player = SPCore.Functions.GetPlayerData()
    if Player.charinfo.gender == 0 then -- Male
        TriggerEvent("illenium-appearance:client:loadJobOutfit", {
            outfitData = {
                ["pants"] = {item = 221, texture = 3}, -- Pants
                ["arms"] = {item = 85, texture = 1}, -- Arms
                ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt
                ["vest"] = {item = 0, texture = 0}, -- Body Vest
                ["torso2"] = {item = 475, texture = 10}, -- Jacket
                ["shoes"] = {item = 178, texture = 1}, -- Shoes
                ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                ["bag"] = {item = 0, texture = 0}, -- Bag
                ["hat"] = {item = -1, texture = -1}, -- Hat
                ["glass"] = {item = 0, texture = 0}, -- Glasses
                ["mask"] = {item = 0, texture = 0} -- Mask
            }
        })
    else -- Female
        TriggerEvent("illenium-appearance:client:loadJobOutfit", {
            outfitData = {
                ["pants"] = {item = 247, texture = 18}, -- Pants
                ["arms"] = {item = 109, texture = 1}, -- Arms
                ["t-shirt"] = {item = 14, texture = 0}, -- T Shirt
                ["vest"] = {item = 0, texture = 0}, -- Body Vest
                ["torso2"] = {item = 584, texture = 10}, -- Jacket
                ["shoes"] = {item = 140, texture = 6}, -- Shoes
                ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                ["bag"] = {item = 0, texture = 0}, -- Bag
                ["hat"] = {item = -1, texture = -1}, -- Hat
                ["glass"] = {item = 0, texture = 0}, -- Glasses
                ["mask"] = {item = 0, texture = 0} -- Mask
            }
        })
    end

    IsWearingWorkClothes = true
end)

RegisterNetEvent("sp-upnatom:client:civil-clothes", function()
    IsWearingWorkClothes = false
    TriggerEvent("illenium-appearance:client:reloadSkin")
end)

RegisterNetEvent("sp-upnatom:client:open-freezer", function()
    TriggerServerEvent("sp-upnatom:server:open-freezer")

    exports.ox_inventory:openInventory("stash", "upnatom-freezer")
end)