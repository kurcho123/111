-- Set default radio volume
exports['pma-voice']:setRadioVolume(Config.DefaultVolume)

-- Get Infinity state
infinityEnabled = false

Citizen.CreateThread(function()
    infinityEnabled = callback.await('fd_radio:isInfinityEnabled', false)

    if infinityEnabled then
        AddStateBagChangeHandler("radioChannel", nil, function(bagName, key, value)
            local player = GetPlayerFromStateBagName(bagName)

            if player ~= PlayerId() then return end

            handleChannelChange(value)
        end)
        -- radioChannel
    end
end)

controlsLoop = nil

function utils.disableControls(controls)
    if not controls then
        controlsLoop = false
        return
    end

    if type(controls) == 'table' then
        Citizen.CreateThread(function()
            controlsLoop = true

            while controlsLoop do
                Citizen.Wait(0)
                if not controls.enablePause then
                    DisableControlAction(0, 199, true)
                    DisableControlAction(0, 200, true)
                    DisableControlAction(0, 322, true)
                end

                if not controls.enableMouse then
                    DisableControlAction(0, 1, true);
                    DisableControlAction(0, 2, true);
                    DisableControlAction(0, 106, true);
                end

                if not controls.enableMovement then
                    DisableControlAction(0, 30, true)
                    DisableControlAction(0, 31, true)
                    DisableControlAction(0, 36, true)
                    DisableControlAction(0, 21, true)
                end

                if not controls.enableCarMovement then
                    DisableControlAction(0, 63, true)
                    DisableControlAction(0, 64, true)
                    DisableControlAction(0, 71, true)
                    DisableControlAction(0, 72, true)
                    DisableControlAction(0, 75, true)
                end

                if not controls.enableCombat then
                    DisablePlayerFiring(cache.player, true)
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 25, true)
                    DisableControlAction(1, 37, true)
                    DisableControlAction(0, 47, true)
                    DisableControlAction(0, 58, true)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    DisableControlAction(0, 142, true)
                    DisableControlAction(0, 143, true)
                    DisableControlAction(0, 263, true)
                    DisableControlAction(0, 264, true)
                    DisableControlAction(0, 257, true)
                end
            end
        end)
    end
end

function utils.drawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
