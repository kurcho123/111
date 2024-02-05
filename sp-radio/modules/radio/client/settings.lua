serverIdentifier = nil
settings = {
    volume = Config.DefaultVolume,
    frame = Config.DefaultColor,
    size = "medium",
    signs = {
        sign = '',
        name = '',
    },
    position = {
        bottom = 0,
        right = 0
    }
}

function settingsName()
    while serverIdentifier == nil do
        Wait(0)
    end

    local identifier = bridge.getIdentifier()

    return ("FD_RADIO_%s_%s"):format(serverIdentifier, identifier)
end

function saveSettings()
    local name = settingsName()

    SetResourceKvp(name, json.encode(settings))
end

function loadSettings()
    for key, setting in pairs(settings) do
        local update = {}
        update[key] = setting

        if key == 'volume' then
            exports["pma-voice"]:setRadioVolume(settings.volume)
        end

        ui.updateValues(update)
    end
end

local function volumeDown(data, cb)
    if cb ~= nil then
        cb(1)
    end

    if settings.volume <= 0 then
        return bridge.notify(Locale.increase_radio_volume, "error")
    end

    settings.volume = settings.volume - 5

    ui.updateValues({
        volume = settings.volume,
    })

    exports["pma-voice"]:setRadioVolume(settings.volume)

    bridge.notify((Locale.volume_radio):format(settings.volume), "success")

    saveSettings()
end

RegisterNUICallback('volumeDownRadio', volumeDown)

local function volumeUp(data, cb)
    if cb ~= nil then
        cb(1)
    end

    if settings.volume >= 100 then
        return bridge.notify(Locale.decrease_radio_volume, "error")
    end

    settings.volume = settings.volume + 5

    ui.updateValues({
        volume = settings.volume,
    })

    exports["pma-voice"]:setRadioVolume(settings.volume)

    bridge.notify((Locale.volume_radio):format(settings.volume), "success")

    saveSettings()
end

RegisterNUICallback('volumeUpRadio', volumeUp)

local function changeSize(data, cb)
    if cb ~= nil then
        cb(1)
    end

    settings.size = data.size

    bridge.notify(Locale.size_updated, "success")

    saveSettings()
end

RegisterNUICallback('changeSizeRadio', changeSize)

local function colorChange(data, cb)
    if cb ~= nil then
        cb(1)
    end

    settings.frame = data.frame

    changeObject()

    bridge.notify(Locale.frame_updated, "success")

    saveSettings()
end

RegisterNUICallback('colorChangeRadio', colorChange)

local function updatePosition(data, cb)
    if cb ~= nil then
        cb(1)
    end

    settings.position = data.position

    bridge.notify(Locale.position_updated, "success")

    saveSettings()
end

RegisterNUICallback('updatePositionRadio', updatePosition)

local function updateSigns(data, cb)
    if cb ~= nil then
        cb(1)
    end

    settings.signs = data.signs

    TriggerServerEvent('fd_radio:updateName', data.signs.sign or '', data.signs.name or '',
        getCurrentChannel())

    bridge.notify(Locale.signs_updated, "success")

    saveSettings()
end

RegisterNUICallback("updateSignsRadio", updateSigns)

callback.register("fd_radio:getName", function()
    return settings.signs
end)

Citizen.CreateThread(function()
    Wait(1000)

    serverIdentifier = callback.await("fd_radio:getHostname", false)
    if Config.Framework == 'none' then
        bridge.loadSettings()
    end
end)
