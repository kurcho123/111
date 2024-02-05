local prop = nil
local colors = {
    ['default'] = 'walkietalkie_grey',
    ['red'] = 'walkietalkie_red',
    ['blue'] = 'walkietalkie_blue',
    ['green'] = 'walkietalkie_green',
    ['yellow'] = 'walkietalkie_yellow',
    ['white'] = 'walkietalkie_white',
}
isOpen = false

function close()
    StopAnimTask(cache.ped, "cellphone@", "cellphone_text_read_base", 1.0)
    ClearPedTasks(cache.ped)
    if prop ~= 0 then
        DeleteObject(prop)
        prop = 0
    end

    isOpen = false
end

function toggleRadio()
    if isOpen then
        if not bridge.beforeClose() then
            return
        end

        close()

        return ui.radioToggle(false)
    end

    if not bridge.beforeOpen() then
        return
    end


    utils.requestAnimDict("cellphone@")
    TaskPlayAnim(cache.ped, "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)

    local color = colors[settings.frame]
    prop = CreateObject(GetHashKey(color), 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.14, 0.01, -0.02, 110.0, 120.0
        , -15.0, 1, 0, 0, 0, 2, 1)

    isOpen = true
    ui.radioToggle(true, Config.CanMoveWhileRadioIsOpen or false)
    bridge.opened()
end

function changeObject()
    if prop ~= 0 then
        DeleteObject(prop)
        prop = 0
    end

    local color = colors[settings.frame]
    prop = CreateObject(GetHashKey(color), 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.14, 0.01, -0.02, 110.0, 120.0
        , -15.0, 1, 0, 0, 0, 2, 1)
end

function clickSound()
    SendNUIMessage({
        action = "radio:join",
        data = nil
    })
end

RegisterNUICallback("closeRadio", function(data, cb)
    ui.radioToggle(false)
    close()

    cb(1)
end)

RegisterNUICallback("closeList", function(data, cb)
    if isListOpen then
        ui.toggleList(false)
    end

    cb(1)
end)
