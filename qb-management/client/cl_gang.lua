local QBCore = exports['qb-core']:GetCoreObject()
local PlayerGang = {}
local shownGangMenu = false

-- UTIL
local function CloseMenuFullGang()
    shownGangMenu = false
end

local function DrawText3DGang(v, text)
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

local function comma_valueGang(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

--//Events
AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerGang = QBCore.Functions.GetPlayerData().gang
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(InfoGang)
    PlayerGang = InfoGang
end)

RegisterNetEvent('qb-gangmenu:client:Stash', function()
    local grade = PlayerGang.grade.level
    if grade >= 2 then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerGang.name, {
            maxweight = 4000000,
            slots = 100,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerGang.name)
    else
        QBCore.Functions.Notify("Нямате ключ за шкафчето..", "error")
    end
end)

RegisterNetEvent('qb-gangmenu:client:Warbobe', function()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-gangmenu:client:OpenMenu', function()
    shownGangMenu = true
    local gangMenu = {
        id = 'gang-menu:OpenMenu',
        title =  "Генг - " .. string.upper(PlayerGang.label),
        options = {
            {
                title = "Управление на групировка",
                description = "Назначи или уволни членове.",
                event = "qb-gangmenu:client:ManageGang",
            },
            {
                title = "Назначи членове",
                description = "Назначи членове на групировката.",
                event = "qb-gangmenu:client:HireMembers",
            },
            {
                title = "Склад",
                description = "Отвори склада на групировката.",
                event = "qb-gangmenu:client:Stash",
            },
            {
                title = "Облекла",
                description = "Промени облеклото.",
                event = "qb-gangmenu:client:Warbobe",
            },
            {
                title = "Финанси",
                description = "Провери финансите на групировката.",
                event = "qb-gangmenu:client:SocietyMenu",
            },
        }
    }
    lib.registerContext(gangMenu)
    lib.showContext('gang-menu:OpenMenu')
end)

RegisterNetEvent('qb-gangmenu:client:ManageGang', function()
    local isBoss = PlayerGang.isboss
    if isBoss then
        local GangMembersMenu = {
            id = 'gang-menu:ManageGang',
            title =  "Управление - " .. string.upper(PlayerGang.label),
            options = {}
        }
        QBCore.Functions.TriggerCallback('qb-gangmenu:server:GetEmployees', function(cb)
            for _, v in pairs(cb) do
                GangMembersMenu.options[#GangMembersMenu.options + 1] = {
                    title = v.name,
                    description = v.grade.name,
                    event = "qb-gangmenu:lient:ManageMember",
                    args = {
                        player = v,
                        work = PlayerGang
                    }
                }
            end
            GangMembersMenu.options[#GangMembersMenu.options + 1] = {
                title = "< Върни се",
                event = "qb-gangmenu:client:OpenMenu",
            }
            lib.registerContext(GangMembersMenu)
            lib.showContext('gang-menu:ManageGang')
        end, PlayerGang.name)
    end
end)

RegisterNetEvent('qb-gangmenu:lient:ManageMember', function(data)
    local MemberMenu = {
        id = "gang-menu:MemberMenu",
        title = "Управление " .. data.player.name .. " - " .. string.upper(PlayerGang.label),
        menu = "gang-menu:employeelist",
        options = {

        }
    }
    for k, v in pairs(QBCore.Shared.Gangs[data.work.name].grades) do
        MemberMenu.options[#MemberMenu.options + 1] = {
        title = v.name,
        description = "Степен: " .. k,
            -- isServer = true,
            serverEvent = "qb-gangmenu:server:GradeUpdate",
            args = {
                cid = data.player.empSource,
                degree = tonumber(k),
                named = v.name
            }
        }
    end
    MemberMenu.options[#MemberMenu.options + 1] = {
        title = "Уволни",
        -- isServer = true,
        serverEvent = "qb-gangmenu:server:FireMember",
        args = data.player.empSource
    }
    MemberMenu.options[#MemberMenu.options + 1] = {
        title = "< Върни се",
        event = "qb-gangmenu:client:ManageGang",
    }
    lib.registerContext(MemberMenu)
    lib.showContext('gang-menu:MemberMenu')
end)

RegisterNetEvent('qb-gangmenu:client:HireMembers', function()
    local isBoss = PlayerGang.isboss
    if isBoss then
        local HireMembersMenu = {
            id = "gang-menu:HireMembersMenu",
            title = "Назначи членове - " .. string.upper(PlayerGang.label),
            options = {

            }
        }
        QBCore.Functions.TriggerCallback('qb-gangmenu:getplayers', function(players)
            for _, v in pairs(players) do
                if v and v ~= PlayerId() then
                    HireMembersMenu.options[#HireMembersMenu.options + 1] = {
                        title = v.name,
                        description = "Щатско ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                        -- isServer = true,
                        serverEvent = "qb-gangmenu:server:HireMember",
                        args = v.sourceplayer
                    }
                end
            end
            HireMembersMenu.options[#HireMembersMenu.options + 1] = {
                title = "< Върни се",
                event = "qb-gangmenu:client:OpenMenu",
            }
            lib.registerContext(HireMembersMenu)
            lib.showContext('gang-menu:HireMembersMenu')
        end)
    end
end)

RegisterNetEvent('qb-gangmenu:client:SocietyMenu', function()
    QBCore.Functions.TriggerCallback('qb-gangmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            id = "gang-menu:SocietyMenu",
            title = "Баланс: $" .. comma_valueGang(cb) .. " - " .. string.upper(PlayerGang.label),
            options = {
                {
                    title = "Депозирай",
                    description = "Депозирай пари.",
                    event = "qb-gangmenu:client:SocietyDeposit",
                    args = comma_valueGang(cb)
                },
                {
                    title = "Изтегли",
                    description = "Изтегли пари.",
                    event = "qb-gangmenu:client:SocietyWithdraw",
                    args = comma_valueGang(cb)
                },
                {
                    title = "< Върни се",
                    event = "qb-gangmenu:client:OpenMenu",
                },
            }
        }
        lib.registerContext(SocietyMenu)
        lib.showContext('gang-menu:SocietyMenu')
    end, PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:client:SocietyDeposit', function(saldoattuale)
    local deposit = lib.inputDialog('Депозирай пари, баланс: $'..saldoattuale, {'Стойност'})
    local amount
    if deposit then
        if not deposit[1] then return end
        amount = tonumber(deposit[1])
        TriggerServerEvent("qb-gangmenu:server:depositMoney", amount)
    end
end)

RegisterNetEvent('qb-gangmenu:client:SocietyWithdraw', function(saldoattuale)
    local isBoss = PlayerGang.isboss
    if isBoss then
        local withdraw = lib.inputDialog('Изтегли пари, баланс: $'..saldoattuale, {'Стойност'})
        local amount
        if withdraw then
            if not withdraw[1] then return end
            amount = tonumber(withdraw[1])
            TriggerServerEvent("qb-gangmenu:server:withdrawMoney", amount)
        end
    end
end)

-- MAIN THREAD
CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRangeGang = false
        local nearGangmenu = false
        for k, v in pairs(Config.Gangs) do
            if k == PlayerGang.name then --and PlayerGang.isboss
                if #(pos - v) < 5.0 then
                    inRangeGang = true
                    if #(pos - v) <= 1.5 then
                        if not shownGangMenu then DrawText3DGang(v, "~b~E~w~ - Управление на групировка") end
                        nearGangmenu = true
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("qb-gangmenu:client:OpenMenu")
                        end
                    end
                    
                    if not nearGangmenu and shownGangMenu then
                        CloseMenuFullGang()
                        shownGangMenu = false
                    end
                end
            end
        end
        if not inRangeGang then
            Wait(1500)
            if shownGangMenu then
                CloseMenuFullGang()
                shownGangMenu = false
            end
        end
        Wait(5)
    end
end)
