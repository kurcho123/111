CreateThread(function()
    if Config.Item.Inventory ~= "qs-inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    local ESX, QBCore
    if Config.Framework == "esx" then
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == "qb" then
        QBCore = exports["qb-core"]:GetCoreObject()
    end

    local function GetItemsByName(name)
        if Config.Framework == "esx" then
            local items = {}
            local inventory = ESX.GetPlayerData().inventory
            for _, item in pairs(inventory) do
                if item?.name == name then
                    items[#items + 1] = item
                end
            end
            return items
        elseif Config.Framework == "qb" then
            local items = {}
            local inventory = QBCore.Functions.GetPlayerData().items
            for _, item in pairs(inventory) do
                if item?.name == name then
                    items[#items + 1] = item
                end
            end
            return items
        end
    end

    function HasImeiIdentifier(imei)
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.info?.imei == imei then
                return true
            end
        end

        return false
    end

    function GetImeiFromItem(item)
        return item?.info?.imei
    end

    RegisterNetEvent("yflip-phone:use-phone-item", function(phoneItem)
        local active = SetupPhone(phoneItem)
        if active then
            ToggleOpen(true)
        end
    end)

    RegisterNetEvent('yflip-phone:phone-item-added', function()
        debugPrint('Phone item added')
    end)

    RegisterNetEvent('yflip-phone:phone-item-removed', function()
        Wait(500)

        if Config.Item.Unique and CurrentPhoneImei and not HasImeiIdentifier(CurrentPhoneImei) then
            PhoneDropped()

            RemovePrimaryPhone(PlayerData.identifier, CurrentPhoneImei)

            if not HasPrimaryPhone then
                debugPrint('Removed primary phone item with imei: ' .. CurrentPhoneImei)
            else
                debugPrint('Could not remove primary phone item with imei: ' .. CurrentPhoneImei)
            end
        end
    end)
end)
