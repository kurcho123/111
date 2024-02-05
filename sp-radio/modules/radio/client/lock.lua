function toggleChannelState(data, cb)
    if cb ~= nil then
        cb(1)
    end

    local isLocked = callback.await("fd_radio:isRadioLocked", false, data.channel)

    if isLocked then
        local unlocked = callback.await("fd_radio:attemptToUnlock", false, data.channel, bridge.getIdentifier())

        if not unlocked then
            return bridge.notify(Locale.radio_cannot_be_unlocked, 'success')
        end

        ui.updateValues({
            isChannelLocked = false
        })

        return bridge.notify(Locale.radio_unlocked, 'success')
    end

    local locked = callback.await("fd_radio:attemptToLock", false, data.channel, bridge.getIdentifier())

    if not locked then
        return bridge.notify(Locale.radio_cannot_be_locked, 'success')
    end

    ui.updateValues({
        isChannelLocked = true
    })
    return bridge.notify(Locale.radio_locked, 'success')
end

RegisterNUICallback("toggleChannelState", toggleChannelState)

function inviteToChannel(data, cb)
    if cb ~= nil then
        cb(1)
    end

    local invited = callback.await("fd_radio:inviteToChannel", false, getCurrentChannel(), data.id)

    if not invited then
        return bridge.notify(Locale.radio_cannot_invite, 'success')
    end

    return bridge.notify(Locale.radio_invited, 'success')
end

RegisterNUICallback("inviteToChannel", inviteToChannel)
