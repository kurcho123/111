CreateThread(function()
    if (Config.Item.Inventory ~= "codem-inventory") or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    local function GetItemsByName(name)
        local items = {}
        local inventory = exports["codem-inventory"]:GetClientPlayerInventory()
        for _, item in pairs(inventory) do
            if item.name == name then
                items[#items + 1] = item
            end
        end
        return items
    end

    function HasImeiIdentifier(imei)
        local phones = GetItemsByName(Config.Item.Name)
        for _, v in pairs(phones) do
            if v and v.info and v.info[1].imei == imei then
                return true
            end
        end

        return false
    end

    function GetImeiFromItem(item)
        return item.info[1]?.imei
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
