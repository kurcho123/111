local radioChannel = 0

local function IsRadioOn()
    return getCurrentChannel() > 0
end

exports("IsRadioOn", IsRadioOn)

function getCurrentChannel()
    if not infinityEnabled then
        return radioChannel
    end

    return LocalPlayer.state.radioChannel
end

exports("getCurrentChannel", getCurrentChannel)

function handleChannelChange(channel)
    radioChannel = channel

    if channel <= 0 then
        return ui.updateValues({
            current = false,
            isExternalListShown = false,
            isChannelWithList = false,
            canChannelBeLocked = false,
            customName = false,
            isChannelLocked = false,
            externalListUsers = {}
        })
    end

    ui.updateValues({
        current = channel,
        isChannelWithList = false,
        isExternalListShown = false,
        canChannelBeLocked = false,
        customName = false,
        isChannelLocked = false,
        externalListUsers = {}
    })

    if Config.AllChanelsHaveUserList then
        ui.updateValues({
            isChannelWithList = true,
            isExternalListShown = Config.IsExternalUsersListEnabledByDefault,
        })
    end

    if Config.WhitelistedAccess[channel] ~= nil and Config.AllWhitelistedChannelsHaveUserList then
        ui.updateValues({
            isChannelWithList = true,
            isExternalListShown = Config.IsExternalUsersListEnabledByDefault,
        })
    end

    if Config.ChannelsWhichHasList[channel] then
        ui.updateValues({
            isChannelWithList = true,
            isExternalListShown = Config.IsExternalUsersListEnabledByDefault,
        })
    end

    if Config.AllChannelsCanBeLocked and Config.WhitelistedAccess[channel] == nil then
        ui.updateValues({
            canChannelBeLocked = true,
            isExternalListShown = Config.IsExternalUsersListEnabledByDefault,
        })
    end

    if not Config.AllChannelsCanBeLocked and Config.ChannelsWhichCanBeLocked[channel] ~= nil and
        Config.WhitelistedAccess[channel] == nil then
        ui.updateValues({
            canChannelBeLocked = true
        })
    end

    if Config.UseCustomChannelNames[channel] ~= nil then
        ui.updateValues({
            customName = Config.UseCustomChannelNames[channel]
        })
    end

    local isLocked = callback.await("fd_radio:isRadioLocked", false, channel)
    if isLocked then
        ui.updateValues({
            isChannelLocked = true
        })
    end

    return bridge.notify((Locale.joined_to_radio):format(channel), 'success')
end

function connectRadio(channel)
    if getCurrentChannel() == channel then
        return leaveRadio()
    end

    exports["pma-voice"]:setRadioChannel(channel)
    clickSound()

    if not infinityEnabled then
        return handleChannelChange(channel)
    end
end

function joinRadio(data, cb)
    if cb ~= nil then
        cb(1)
    end

    if data.radio == nil or data.radio >= Config.MaxFrequency or data.radio == 0 then
        return bridge.notify(Locale.invalid_radio, 'error')
    end

    if data.radio == getCurrentChannel() then
        return bridge.notify(Locale.you_on_radio, 'error')
    end

    if Config.Framework ~= 'none' and Config.WhitelistedAccess[data.radio] ~= nil and
        not bridge.checkRestrictedChannel(data.radio) then
        return bridge.notify(Locale.restricted_channel_error, 'error')
    end

    if Config.Framework == 'none' and Config.WhitelistedAccess[data.radio] ~= nil and
        not bridge.standaloneCheckRestrictedChannel(data.radio) then
        return bridge.notify(Locale.restricted_channel_error, 'error')
    end

    local canJoinLocked = callback.await("fd_radio:isRadioLockedCanJoin", false, data.radio)

    if not canJoinLocked then
        return bridge.notify(Locale.radio_locked, 'error')
    end

    return connectRadio(data.radio)
end

exports('joinRadio', function(channel)
    joinRadio({
        radio = channel
    })
end)
RegisterNUICallback('joinRadio', joinRadio)

function leaveRadio(data, cb)
    if cb ~= nil then
        cb(1)
    end

    if getCurrentChannel() == 0 then
        return
    end

    exports["pma-voice"]:setRadioChannel(0)
    radioChannel = 0

    ui.updateValues({
        current = false,
        isChannelWithList = false,
        canChannelBeLocked = false,
        isChannelLocked = false
    })

    clickSound()

    return bridge.notify(Locale.you_leave, 'error')
end

exports('leaveRadio', leaveRadio)
RegisterNUICallback('leaveRadio', leaveRadio)


function toggleRadioList()
    if isListOpen then
        ui.toggleList(false)
    end

    local PlayerJob = bridge.getJob()

    if PlayerJob == nil then
        return
    end

    local list = Config.QuickListForJobs[bridge.getJob()]

    if list == nil then
        return
    end

    local formattedList = {}
    for channel, name in pairs(list) do
        table.insert(formattedList, {
            channel = channel,
            name = name
        })
    end

    ui.toggleList(true, formattedList)
end

CreateThread(function()
    while true do
        Wait(1000)

        if isOpen and bridge.isDead() then
            close()
            ui.radioToggle(false)
        end

        if getCurrentChannel() ~= 0 then
            if bridge.isDead() then
                leaveRadio()
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)

        if isOpen and Config.Framework ~= 'none' and not bridge.hasItem(Config.UseItemName, 1) then
            close()
            ui.radioToggle(false)
        end

        if Config.Framework ~= 'none' and getCurrentChannel() ~= 0 then
            if not bridge.hasItem(Config.UseItemName, 1) then
                leaveRadio()
            end
        end
    end
end)
