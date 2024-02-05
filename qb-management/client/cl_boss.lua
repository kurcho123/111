local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local shownBossMenu = false

-- UTIL
local function CloseMenuFull()
    shownBossMenu = false
end

local function DrawText3D(v, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(v, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 0)
    ClearDrawOrigin()
end

local function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('qb-bossmenu:client:OpenMenu', function()
    shownBossMenu = true
    local varOptions

    if PlayerJob.grade.name == "Co-Chief" then
        varOptions = {
            {
                title = "Служители",
                description = "Списък със служители",
                arrow = true,
                event = 'qb-bossmenu:client:employeelist',
                args = {}
            },
            {
                title = "Назначи служители",
                description = "Трябва да са в близост",
                arrow = true,
                event = 'qb-bossmenu:client:HireMenu',
                args = {}
            },
            {
                title = "Склад",
                description = "Отвори склада",
                arrow = true,
                event = 'qb-bossmenu:client:Stash',
                args = {}
            },
            {
                title = "Облекла",
                description = "Запазени облекла",
                arrow = true,
                event = 'qb-bossmenu:client:Wardrobe',
                args = {}
            },
        }
    elseif PlayerJob.isboss then
        varOptions = {
            {
                title = "Служители",
                description = "Списък със служители",
                arrow = true,
                event = 'qb-bossmenu:client:employeelist',
                args = {}
            },
            {
                title = "Назначи служители",
                description = "Трябва да са в близост",
                arrow = true,
                event = 'qb-bossmenu:client:HireMenu',
                args = {}
            },
            {
                title = "Склад",
                description = "Отвори склада",
                arrow = true,
                event = 'qb-bossmenu:client:Stash',
                args = {}
            },
            {
                title = "Облекла",
                description = "Запазени облекла",
                arrow = true,
                event = 'qb-bossmenu:client:Wardrobe',
                args = {}
            },
            {
                title = "Финансов отдел",
                description = "Фирмен баланс",
                arrow = true,
                event = 'qb-bossmenu:client:SocietyMenu',
                args = {}
            },
        }
    end

    local bossMenu = {
        -- {
        --     header = "Управление - " .. string.upper(PlayerJob.label),
        --     isMenuHeader = true,
        -- },
        id = 'boss-menu:OpenMenu',
        title =  "Управление - " .. string.upper(PlayerJob.label),
        onExit = function()
            --print('Hello there')
        end,
        options = varOptions
    }

    lib.registerContext(bossMenu)
    lib.showContext('boss-menu:OpenMenu')
    -- exports['qb-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('qb-bossmenu:client:employeelist', function()
    local EmployeesMenu = {
        -- {
        --     header = "Управление - " .. string.upper(PlayerJob.label),
        --     isMenuHeader = true,
        -- },

        id = 'boss-menu:employeelist',
        title =  "Управление - " .. string.upper(PlayerJob.label),
        menu = "boss-menu:OpenMenu",
        onExit = function()
            --print('Hello there')
        end,
        options = {

        }
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            EmployeesMenu.options[#EmployeesMenu.options + 1] = {
                -- header = v.name,
                -- txt = v.grade.name,
                -- params = {
                --     event = "qb-bossmenu:client:ManageEmployee",
                --     args = {
                --         player = v,
                --         work = PlayerJob
                --     }
                -- }
                title = v.name,
                description = v.grade.name,
                arrow = true,
                event = 'qb-bossmenu:client:ManageEmployee',
                args = {
                    player = v,
                    work = PlayerJob
                }
            }
        end
        -- EmployeesMenu[#EmployeesMenu + 1] = {
        --     header = "< Върни се",
        --     params = {
        --         event = "qb-bossmenu:client:OpenMenu",
        --     }
        -- }
        lib.registerContext(EmployeesMenu)
        lib.showContext('boss-menu:employeelist')
        -- exports['qb-menu']:openMenu(EmployeesMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:ManageEmployee', function(data)
    local EmployeeMenu = {
        -- {
        --     header = "Управление" .. data.player.name .. " - " .. string.upper(PlayerJob.label),
        --     isMenuHeader = true,
        -- },
        id = 'boss-menu:ManageEmployee',
        title =  "Управление" .. data.player.name .. " - " .. string.upper(PlayerJob.label),
        menu = "boss-menu:employeelist",
        onExit = function()
            --print('Hello there')
        end,
        options = {

        }
    }
    for k, v in pairs(QBCore.Shared.Jobs[data.work.name].grades) do
        EmployeeMenu.options[#EmployeeMenu.options + 1] = {
            -- header = v.name,
            -- txt = "Позиция: " .. k,
            -- params = {
            --     isServer = true,
            --     event = "qb-bossmenu:server:GradeUpdate",
            --     args = {
            --         cid = data.player.empSource,
            --         grado = tonumber(k),
            --         nomegrado = v.name
            --     }
            -- }
            title = v.name,
            description = "Позиция: " .. k,
            serverEvent = 'qb-bossmenu:server:GradeUpdate',
            args = {
                cid = data.player.empSource,
                grado = tonumber(k),
                nomegrado = v.name
            }
        }
    end
    EmployeeMenu.options[#EmployeeMenu.options + 1] = {
        -- header = "Уволни",
        -- params = {
        --     isServer = true,
        --     event = "qb-bossmenu:server:FireEmployee",
        --     args = data.player.empSource
        -- }
        title = "Уволни",
        description = "",
        serverEvent = 'qb-bossmenu:server:FireEmployee',
        args = data.player.empSource
    }
    -- EmployeeMenu[#EmployeeMenu + 1] = {
    --     header = "< Обратно",
    --     params = {
    --         event = "qb-bossmenu:client:OpenMenu",
    --     }
    -- }
    lib.registerContext(EmployeeMenu)
    lib.showContext('boss-menu:ManageEmployee')
    -- exports['qb-menu']:openMenu(EmployeeMenu)
end)

RegisterNetEvent('qb-bossmenu:client:Stash', function()
    -- TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
    --     maxweight = 8000000,
    --     slots = 105,
    -- })
    -- TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerJob.name)

    TriggerServerEvent("qb-bossmenu:server:Stash", "boss_" .. PlayerJob.name)

    exports.ox_inventory:openInventory("stash", "boss_" .. PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:Wardrobe', function()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-bossmenu:client:HireMenu', function()
    local HireMenu = {
        -- {
        --     header = "Назначи служители - " .. string.upper(PlayerJob.label),
        --     isMenuHeader = true,
        -- },
        id = 'boss-menu:HireMenu',
        title =  "Назначи служители - " .. string.upper(PlayerJob.label),
        menu = "boss-menu:OpenMenu",
        onExit = function()
            --print('Hello there')
        end,
        options = {

        }
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu.options[#HireMenu.options + 1] = {
                    -- header = v.name,
                    -- txt = "Щатско ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    -- params = {
                    --     isServer = true,
                    --     event = "qb-bossmenu:server:HireEmployee",
                    --     args = v.sourceplayer
                    -- }
                    title = v.name,
                    description = "Щатско ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    arrow = true,
                    serverEvent = 'qb-bossmenu:server:HireEmployee',
                    args = v.sourceplayer
                }
            end
        end
        -- HireMenu[#HireMenu + 1] = {
        --     header = "< Върни се",
        --     params = {
        --         event = "qb-bossmenu:client:OpenMenu",
        --     }
        -- }
        lib.registerContext(HireMenu)
        lib.showContext('boss-menu:HireMenu')
        -- exports['qb-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('qb-bossmenu:client:SocietyMenu', function()
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            -- {
            --     header = "Баланс: $" .. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
            --     isMenuHeader = true,
            -- },
            id = 'boss-menu:SocietyMenu',
            title =  "Баланс: $" .. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
            menu = "boss-menu:OpenMenu",
            onExit = function()
                --print('Hello there')
            end,
            options = {
                {
                    title = "Депозит",
                    description = "Депозирай пари в акаунта",
                    arrow = true,
                    event = 'qb-bossmenu:client:SocetyDeposit',
                    args = comma_value(cb)
                },
                {
                    title = "Изтегли",
                    description = "Изтегли пари",
                    arrow = true,
                    event = 'qb-bossmenu:client:SocetyWithDraw',
                    args = comma_value(cb)
                },
            },
            -- {
            --     header = "Депозит",
            --     txt = "Депозирай пари в акаунта.",
            --     params = {
            --         event = "qb-bossmenu:client:SocetyDeposit",
            --         args = comma_value(cb)
            --     }
            -- },
            -- {
            --     header = "Изтегли",
            --     txt = "Изтегли пари.",
            --     params = {
            --         event = "qb-bossmenu:client:SocetyWithDraw",
            --         args = comma_value(cb)
            --     }
            -- },
            -- {
            --     header = "<п Върни се",
            --     params = {
            --         event = "qb-bossmenu:client:OpenMenu",
            --     }
            -- },
        }
        lib.registerContext(SocietyMenu)
        lib.showContext('boss-menu:SocietyMenu')
        -- exports['qb-menu']:openMenu(SocietyMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:SocetyDeposit', function(money)
    local deposit = lib.inputDialog("Депозиране на пари", {'Сума | Баланс: $' .. money})
    if deposit then
        if not deposit[1] then return end
        TriggerServerEvent("qb-bossmenu:server:depositMoney", tonumber(deposit[1]))
    end
end)

RegisterNetEvent('qb-bossmenu:client:SocetyWithDraw', function(money)
    local withdraw = lib.inputDialog("Теглене на пари", {'Сума | Баланс: $' .. money})
    if withdraw then
        if not withdraw[1] then return end
        TriggerServerEvent("qb-bossmenu:server:withdrawMoney", tonumber(withdraw[1]))
    end
end)

-- MAIN THREAD
CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRangeBoss = false
        local nearBossmenu = false
        for k, v in pairs(Config.Jobs) do
            if k == PlayerJob.name and PlayerJob.isboss then
                if #(pos - v) < 5.0 then
                    inRangeBoss = true
                    if #(pos - v) <= 1.5 then
                        if not shownBossMenu then DrawText3D(v, "~b~E~w~ - Отвори мениджърски опции") end
                        nearBossmenu = true
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("qb-bossmenu:client:OpenMenu")
                        end
                    end
                    
                    if not nearBossmenu and shownBossMenu then
                        CloseMenuFull()
                        shownBossMenu = false
                    end
                end
            end
        end
        if not inRangeBoss then
            Wait(1500)
            if shownBossMenu then
                CloseMenuFull()
                shownBossMenu = false
            end
        end
        Wait(3)
    end
end)
