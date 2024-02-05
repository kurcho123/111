if Config.AllowJammers then
    if Config.JammerPickUpUse == '3d' then
        Citizen.CreateThread(function()
            while true do
                if utils.tableLength(insideJammerZones) > 0 then
                    local jammer, dist = getInsideClosestJammer(20, cache.coords)

                    if jammer ~= nil and dist ~= nil and dist < 1 then
                        if Config.Framework == 'none' then
                            utils.drawText3D(jammer.coords.x, jammer.coords.y, jammer.coords.z, Locale.press_to_destroy)
                        else
                            utils.drawText3D(jammer.coords.x, jammer.coords.y, jammer.coords.z, Locale.press_to_pickup)
                        end

                        if IsControlJustReleased(0, 38) then
                            playJammerAnim()
                            callback.await("fd_radio:removeJammerCB", false, jammer.id)
                        end
                    end

                    Wait(0)
                else
                    Wait(1000)
                end
            end
        end)
    end

    if Config.JammerPickUpUse == 'ox_target' then
        if GetResourceState('ox_target') ~= 'started' then
            return print('^3fd_radio: ^1ox_target is not started, make sure it\'s started.^0')
        end

        exports.ox_target:addModel({
            `ch_prop_ch_mobile_jammer_01x`
        }, {
            {
                name = 'pickup_jammer',
                label = Config.Framework == 'none' and Locale.destroy_jammer or Locale.pick_up_jammer,
                icon = 'fa-solid fa-hand',
                distance = 1.5,
                onSelect = function(data)
                    oxTargetRemove(data)
                end
            }
        })
    end

    if Config.JammerPickUpUse == 'qb-target' then
        if string.lower(Config.Framework) ~= 'qb' then
            return print('^3fd_radio: ^1to use qb-target you need QBCore framework enabled.^0')
        end

        if GetResourceState('qb-target') ~= 'started' then
            return print('^3fd_radio: ^1qb-target is not started, make sure it\'s started.^0')
        end

        exports['qb-target']:AddTargetModel({ `ch_prop_ch_mobile_jammer_01x` }, {
            options = {
                {
                    event = 'fd_radio:removeJammerUsed',
                    label = Locale.pick_up_jammer,
                    icon = 'fa-solid fa-hand',
                }
            },
            distance = 1.5,
        })
    end

    if Config.JammerPickUpUse == 'qtarget' then
        if GetResourceState('qtarget') ~= 'started' then
            return print('^3fd_radio: ^1qtarget is not started, make sure it\'s started.^0')
        end

        exports.qtarget:AddTargetModel({ `ch_prop_ch_mobile_jammer_01x` }, {
            options = {
                {
                    event = 'fd_radio:removeJammerUsed',
                    label = Locale.pick_up_jammer,
                    icon = 'fa-solid fa-hand',
                    num = 1
                },
            },
            distance = 1.5
        })
    end
end
