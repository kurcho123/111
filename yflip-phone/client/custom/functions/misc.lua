RegisterNetEvent('yflip-phone:client:toggle-phone', function(state)
    debugPrint('RegisterNetEvent: yflip-phone:client:toggle-phone', state)
    -- * A callback function that you can use as you want when the phone is toggled.
end)

--- Uses the phone item if it exists and initializes the phone device if it doesn't exist.
--- If the phone device is already initialized, it loads the phone data and toggles the phone open/closed.
function UsePhoneItem()
    if Config.Item.Require then
        if not HasPhoneItem() then
            return
        end
    end

    local phoneImei = lib.callback.await('yflip-phone:server:get-primary-phone', false, PlayerData.identifier)
    if not phoneImei and not Config.Item.Unique then
        local initialized = lib.callback.await('yflip-phone:server:initialize-phone-device', false, PlayerData
            .identifier)
        debugPrint('Phone data initialized status: ', initialized)

        if initialized then
            debugPrint("Phone data initialized. Setting primary phone.")

            SetPrimaryPhone(PlayerData.identifier, PlayerData.identifier)

            DataLoaded = false
            LoadPhoneData(PlayerData.identifier)

            while not DataLoaded do
                Wait(100)
            end

            ToggleOpen(not PhoneOpen)
        end
    elseif phoneImei then
        if not DataLoaded then
            LoadPhoneData(phoneImei)

            while not DataLoaded do
                Wait(100)
            end
        end

        ToggleOpen(not PhoneOpen)
    elseif Config.Item.Unique then
        lib.notify({
            title = 'YFlip Phone',
            description = 'Use the phone item from your inventory to setup the phone.',
            type = 'warning'
        })
    end
end

RegisterKeyMapping('phone', Config.KeyBinds.Open.Description, 'keyboard', Config.KeyBinds.Open.Bind)
RegisterCommand('phone', function()
    UsePhoneItem()
end, false)

RegisterNetEvent('yflip-phone:client:setup-complete', function(phoneImei)
    -- * A callback function that you can use as you want when the phone is setup.
    debugPrint('Callback after setup complete: client/misc.lua ', phoneImei)

    if Config.UpdateUserPhoneNumber and (Config.Framework == 'qb' or Config.Framework == 'esx') then
        local phoneNumber = lib.callback.await('yflip-phone:server:get-phone-number-by-imei', false, phoneImei)

        TriggerServerEvent('yflip-phone:server:update-users-phone-number', phoneNumber)
    end
end)

RegisterNetEvent('yflip-phone:client:cell-broadcast', function(title, content, iconUrl)
    local data = {
        title = title,
        content = content,
        iconUrl = iconUrl
    }

    SendUIAction('cell-broadcast:send', data)
end)


-- Function to handle when the phone is dropped.
function PhoneDropped()
    if OnRadio then
        LeaveRadioChannel()
    end
end

-- Calculates the current time and returns an object containing the hour and minute in a formatted string.
-- @return {table} obj - An object containing the formatted hour and minute.
local function CalculateTimeToDisplay()
    local hour = GetClockHours()
    local minute = GetClockMinutes()

    local obj = {}

    if minute <= 9 then
        minute = "0" .. minute
    end

    if hour <= 9 then
        hour = "0" .. hour
    end

    obj.hour = hour
    obj.minute = minute

    return obj
end

RegisterNUICallback('misc:get-game-time', function(_, cb)
    cb(CalculateTimeToDisplay())
end)

if not Config.RealTime then
    CreateThread(function()
        while true do
            if PhoneOpen then
                local gameTime = CalculateTimeToDisplay()

                SendUIAction('clock:update-time', gameTime)
            end
            Wait(2000)
        end
    end)
end
