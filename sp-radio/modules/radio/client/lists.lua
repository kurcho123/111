lists = {}

RegisterNetEvent('fd_radio:updateNames', function(channel, list)
    lists[channel] = list

    if formatChannel(getCurrentChannel()) == channel then
        ui.updateValues({
            externalListUsers = list
        })
    end
end)

RegisterNUICallback('fetchList', function(data, cb)
    cb(lists[formatChannel(data.channel)] or {})
end)
