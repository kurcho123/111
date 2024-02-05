-- {
--     id: 1,
--     date: '2023-09-11T15:45:00',
--     title: 'Important Announcement',
--     content: 'Please be advised of the upcoming changes...',
--     phoneImei: '1234567890',
--     isRead: true,
--     sender: 'cardepartment@rp.gg',
--     senderDisplayName: 'Car Department',
-- },

local function getDummyEmail()
    local email = {
        title = "Test",
        sender = 'test@yflyp.com',
        senderDisplayName = 'YFlip Phone',
        content = 'Email content...',
    }

    local clientAction = {
        label = "Accept",
        data = {
            event = "yflip-phone:client:mail:test-callback",
            isServer = false,
            data = "test data",
            shouldClose = true
        }
    }

    local serverEvent = {
        label = "Decline",
        data = {
            event = "yflip-phone:client:mail:test-callback",
            isServer = true,
            data = "test data",
            shouldClose = false
        }
    }

    local attachments = {
        {
            photo = "https://i.imgur.com/2QZQ5kL.png"
        },
        {
            location = { x = 12, y = 12 },
        }
    }

    email.attachments = attachments

    local actions = {
        clientAction,
        serverEvent
    }

    email.actions = actions

    return email
end

-- This is dummy event with no real use. It's only purpose is to show how to use the email app.
RegisterNuiCallback('send:mail', function(_, cb)
    local email = getDummyEmail()

    lib.callback.await('yflip-phone:server:email:send', false, email, 'all')

    cb({})
end)

RegisterNuiCallback('email:get', function(page, cb)
    local mails = lib.callback.await('yflip-phone:server:email:get', false, page, CurrentPhoneImei)

    cb(mails)
end)

RegisterNuiCallback('email:read', function(id, cb)
    local mails = lib.callback.await('yflip-phone:server:email:read', false, id)

    cb(mails)
end)

RegisterNuiCallback('email:delete', function(id, cb)
    local deleteResult = lib.callback.await('yflip-phone:server:email:delete', false, id)

    if deleteResult then
        cb({ success = true })
    else
        cb({ success = true })
    end
end)

RegisterNuiCallback('email:action', function(action, cb)
    if action?.data?.isServer and action?.data?.event then
        TriggerServerEvent(action.data.event, action.data.data)
    elseif action?.data?.event then
        TriggerEvent(action.data.event, action.data.data)
    end

    cb({})
end)

RegisterNetEvent('yflip-phone:client:mail:update-mails', function(data)
    SendUIAction('mails:update', data)
end)

--==--
-- RegisterNetEvent('yflip-phone:client:mail:send-dummy-all', function()
--     local email = getDummyEmail()

--     lib.callback.await('yflip-phone:server:email:send', false, email, 'source', 5)
-- end)
--==--

exports('SendMail', function(email, toType, to)
    return lib.callback.await('yflip-phone:server:email:send', false, email, toType, to)
end)

exports('DeleteMail', function(id)
    return lib.callback.await('yflip-phone:server:email:delete', false, id)
end)
