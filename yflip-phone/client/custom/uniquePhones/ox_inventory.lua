CreateThread(function()
    if Config.Item.Inventory ~= "ox_inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    exports.ox_inventory:displayMetadata({
        imei = "IMEI",
    })

    function HasImeiIdentifier(imei)
        local phones = exports.ox_inventory:Search("slots", Config.Item.Name)

        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?.imei == imei then
                return true
            end
        end

        return false
    end

    function GetImeiFromItem(item)
        local phones = exports.ox_inventory:Search("slots", Config.Item.Name)

        for i = 1, #phones do
            local phone = phones[i]

            if phone?.slot == item?.slot then
                return phone.metadata.imei
            end
        end

        return nil
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
