isListOpen = false

function ui.radioToggle(state, canMove)
    SendNUIMessage({
        action = "radio:toggleRadio",
        data = {
            state = state,
        }
    })

    SetNuiFocus(state, state)

    if state and canMove then
        SetNuiFocusKeepInput(true)

        -- Disable inventory and hotbar for quasar
        TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        -- Disable inventory and hotbar for qb-inventory
        LocalPlayer.state:set("inv_busy", true, true)
        -- Disable inventory and hotbar for ox_inventory
        LocalPlayer.state:set("invBusy", true, true)

        utils.disableControls({
            enableMouse = false,
            enableMovement = true,
            enableCarMovement = true,
            enableCombat = false,
            enablePause = false
        })
    end

    if not state and controlsLoop then
        SetNuiFocusKeepInput(false)
        utils.disableControls(false)

        -- Disable inventory and hotbar for quasar
        TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        -- Disable inventory and hotbar for qb-inventory
        LocalPlayer.state:set("inv_busy", false, true)
        -- Disable inventory and hotbar for ox_inventory
        LocalPlayer.state:set("invBusy", false, true)
    end
end

function ui.toggleList(state, data)
    data = data or {}
    SendNUIMessage({
        action = "radio:toggleRadioList",
        data = {
            state = state,
            data = data
        }
    })

    isListOpen = state

    SetNuiFocus(state, state)

    if state and Config.CanMoveWhileQuickRadioListIsOpen then
        SetNuiFocusKeepInput(true)

        -- Disable inventory and hotbar for quasar
        TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        -- Disable inventory and hotbar for qb-inventory
        LocalPlayer.state:set("inv_busy", true, true)
        -- Disable inventory and hotbar for ox_inventory
        LocalPlayer.state:set("invBusy", true, true)

        utils.disableControls({
            enableMouse = false,
            enableMovement = true,
            enableCarMovement = true,
            enableCombat = false,
            enablePause = false
        })
    end

    if not state and Config.CanMoveWhileQuickRadioListIsOpen then
        SetNuiFocusKeepInput(false)
        utils.disableControls(false)

        -- Disable inventory and hotbar for quasar
        TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        -- Disable inventory and hotbar for qb-inventory
        LocalPlayer.state:set("inv_busy", false, true)
        -- Disable inventory and hotbar for ox_inventory
        LocalPlayer.state:set("invBusy", false, true)
    end
end

function ui.updateValues(data)
    SendNUIMessage({
        action = "radio:updateValues",
        data = data or {}
    })
end

RegisterNUICallback("fetchLocale", function(data, cb)
    cb(Locale.ui)
end)

-- Initialize default settings
Citizen.CreateThread(function()
    Wait(2000)
    local isLocked = callback.await("fd_radio:isRadioLocked", false, getCurrentChannel() or 0)
    local isOff = (LocalPlayer.state?.radioChannel == 0 or LocalPlayer.state?.radioChannel == nil) and true or false

    ui.updateValues({
        current = (LocalPlayer.state?.radioChannel or 0) > 0 and getCurrentChannel() or false,
        isOff = isOff,
        input = (LocalPlayer.state?.radioChannel or 0) > 0 and getCurrentChannel() or 1,
        isChannelWithList = hasList(getCurrentChannel()),
        isChannelLocked = ((LocalPlayer.state?.radioChannel or 0) > 0 and canBeLocked(getCurrentChannel())) and isLocked or false,
        canChannelBeLocked = (LocalPlayer.state?.radioChannel or 0) > 0 and canBeLocked(getCurrentChannel()) or false,
        isColorChangeAllowed = Config.AllowColorChange,
        ranges = {
            min = 1,
            max = Config.MaxFrequency
        },
        customName = (LocalPlayer.state?.radioChannel or 0) > 0 and Config.UseCustomChannelNames[getCurrentChannel()] or false,
        isExternalListShown = hasList(getCurrentChannel()) and Config.IsExternalUsersListEnabledByDefault or false,
        canExternalUsersListBeToggled = Config.CanExternalUsersListBeToggled,
    })
end)
