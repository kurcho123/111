local jammers, soundEffectPlaying = {}, false
insideJammerZones = {}

function getClosestJammer(range, coords)
    local closestJammer, closestJammerDist = nil, 9999
    if coords == nil then
        coords = GetEntityCoords(PlayerPedId())
    end
    for id, jammer in pairs(jammers) do
        local dist = #(coords - jammer.coords)
        if dist < closestJammerDist then
            closestJammerDist = dist
            closestJammer = jammer
        end
    end
    if closestJammerDist > range then
        return nil
    end
    return closestJammer, closestJammerDist
end

function getInsideClosestJammer(range, coords)
    local closestJammer, closestJammerDist = nil, 9999
    if coords == nil then
        coords = GetEntityCoords(cache.ped)
    end
    for id, _ in pairs(insideJammerZones) do
        local jammer = jammers[id]
        local dist = #(coords - jammer.coords)
        if dist < closestJammerDist then
            closestJammerDist = dist
            closestJammer = jammer
        end
    end
    if closestJammerDist > range then
        return nil
    end
    return closestJammer, closestJammerDist
end

function playJammerAnim()
    utils.requestAnimDict("random@domestic")
    TaskPlayAnim(cache.ped, "random@domestic", "pickup_low", 8.0, -8.0, 1000, 51, 1.0,
        false, false, false)
end

function populateJammer(coords, heading)
    local object = CreateObject(`ch_prop_ch_mobile_jammer_01x`, coords.x, coords.y, coords.z, 0, 0, 0)

    SetEntityHeading(object, heading + 0.0)
    FreezeEntityPosition(object, true)
    PlaceObjectOnGroundProperly(object)

    return object
end

function newJammer(uuid, data)
    jammers[uuid] = data

    if lib ~= nil then
        jammers[uuid].zone = lib.zones.sphere({
            coords = data.coords,
            radius = data.radius,
            debug = Config.Debug,
            onEnter = function()
                insideJammerZones[uuid] = true
                callback("fd_radio:updateInsideJammerZone", false, function() end, uuid, true)
                jammers[uuid].object = populateJammer(jammers[uuid].coords, jammers[uuid].heading)

                if not soundEffectPlaying then
                    SendNUIMessage({
                        action = "radio:playJammer",
                        data = {}
                    })

                    soundEffectPlaying = true
                end
            end,
            onExit = function()
                insideJammerZones[uuid] = nil

                if utils.tableLength(insideJammerZones) < 1 and soundEffectPlaying then
                    SendNUIMessage({
                        action = "radio:stopJammer",
                        data = {}
                    })
                    soundEffectPlaying = false
                end

                if jammers[uuid].object ~= nil then
                    callback("fd_radio:updateInsideJammerZone", false, function() end, uuid, false)
                    DeleteObject(jammers[uuid].object)
                    jammers[uuid].object = nil
                end
            end
        })
    else
        jammers[uuid].zone = CircleZone:Create(data.coords, data.radius, {
            name = uuid,
            debugPoly = false
        })

        jammers[uuid].zone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                insideJammerZones[uuid] = true
                callback("fd_radio:updateInsideJammerZone", false, function() end, uuid, true)
                jammers[uuid].object = populateJammer(jammers[uuid].coords, jammers[uuid].heading)

                if not soundEffectPlaying then
                    SendNUIMessage({
                        action = "radio:playJammer",
                        data = {}
                    })

                    soundEffectPlaying = true
                end
            end

            if not isPointInside then
                insideJammerZones[uuid] = nil

                if utils.tableLength(insideJammerZones) < 1 and soundEffectPlaying then
                    SendNUIMessage({
                        action = "radio:stopJammer",
                        data = {}
                    })
                    soundEffectPlaying = false
                end

                if jammers[uuid].object ~= nil then
                    callback("fd_radio:updateInsideJammerZone", false, function() end, uuid, false)
                    DeleteObject(jammers[uuid].object)
                    jammers[uuid].object = nil
                end
            end
        end)
    end

end

function removeJammer(uuid)
    if jammers[uuid] == nil then
        return
    end

    if insideJammerZones[uuid] ~= nil then
        insideJammerZones[uuid] = nil
        callback("fd_radio:updateInsideJammerZone", false, function() end, uuid, false)
    end

    if jammers[uuid].object ~= nil then
        DeleteObject(jammers[uuid].object)
    end

    if jammers[uuid].zone ~= nil then
        if lib ~= nil then
            jammers[uuid].zone:remove()
        else
            jammers[uuid].zone:destroy()
        end
    end

    jammers[uuid] = nil

    if soundEffectPlaying and utils.tableLength(insideJammerZones) < 1 then
        SendNUIMessage({
            action = "radio:stopJammer",
            data = {}
        })
        soundEffectPlaying = false
    end
end

function oxTargetRemove(data)
    local jammer, dist = getInsideClosestJammer(2, cache.coords)

    if jammer == nil then
        return false
    end

    if dist > 2 then
        return false
    end

    playJammerAnim()
    callback.await("fd_radio:removeJammerCB", false, jammer.id)
end

function placeJammer()
    local playerCoords = GetEntityCoords(cache.ped)
    local heading = GetEntityHeading(cache.ped)
    local forward = GetEntityForwardVector(cache.ped)

    local coords = playerCoords + forward * 0.5

    local _, dist = getClosestJammer(Config.MinimumDistanceBetweenJammers + 200)

    if Config.UseJammerItem and Config.JammerItemName and not bridge.hasItem(Config.JammerItemName, 1) then
        print('doesnt have')
        return false
    end

    if dist ~= nil and dist < Config.MinimumDistanceBetweenJammers then
        return bridge.notify(Locale.to_close_to_other_jammer, 'error')
    end

    callback.await("fd_radio:placeJammer", false, coords, heading)
    playJammerAnim()
end

RegisterNetEvent("fd_radio:removeJammer", function(uuid, data)
    removeJammer(uuid)
end)

RegisterNetEvent("fd_radio:newJammerPlaced", function(uuid, data)
    newJammer(uuid, data)
end)

RegisterNetEvent("fd_radio:placeJammers", function(jammers)
    for id, jammer in pairs(jammers) do
        newJammer(id, jammer)
    end
end)

AddEventHandler("fd_radio:removeJammerUsed", function()
    local jammer, dist = getInsideClosestJammer(2, cache.coords)

    if jammer == nil then
        return false
    end

    if dist > 2 then
        return false
    end

    playJammerAnim()
    callback.await("fd_radio:removeJammerCB", false, jammer.id)
end)

Citizen.CreateThread(function()
    TriggerServerEvent("fd_radio:getJammers")
end)
