if Config.UseTarget ~= 'ox_target' then
    return
end

local function storeVehicleZone2()
    local id = exports.ox_target:addGlobalVehicle({
        {
            name = 'garages:storeVehicle',
            icon = 'fas fa-car',
            label = 'Прибери Автомобил',
            -- bones = { 'door_dside_f', 'seat_dside_f' },
            canInteract = function(entity, distance, coords, name)
                if isNearbyJobGarage() then return true end
                local _garage = ClosestGarage
                if not _garage then
                    return false
                end
                local garage = Config.Garages[_garage]
                if garage.job and not checkJob(garage.job) then return end
                if not garage then
                    return false
                end
                local distance = #(coords - vec3(garage.coords.spawnCoords.x, garage.coords.spawnCoords.y, garage.coords.spawnCoords.z))
                if distance > 50.0 then
                    return false
                end
                return true
            end,
            onSelect = function(data)
                local _garage = isNearbyJobGarage()
                if _garage then
                    StoreVehicle(_garage, true, data.entity)
                    return
                end
                StoreVehicle(ClosestGarage, false, data.entity)
            end
        },
        {
            name = 'advancedgarages:client:radialImpoundVehicle',
            icon = 'fas fa-car',
            label = 'Конфискувай Автомобил',
            -- bones = { 'door_dside_f', 'seat_dside_f' },
            canInteract = function(entity, distance, coords, name)
                local job = checkJob("police")
                if job ~= true then return false end

                return IsJobAllowed("police", 'impound')
            end,
            onSelect = function(data)
                if data.distance < 2 then
                    local vehiclePlate = GetVehicleNumberPlateText(data.entity)

                    local isOwned = lib.callback.await('advancedgarages:server:getVehicle', false, vehiclePlate)

                    local animDict = "mini@repair"
                    local anim = "fixing_a_ped"

                    if isOwned == false then
                        QBCore.Functions.Progressbar('confiscatin-vehicle', "Конфискувате автомобила", 20000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = animDict,
                            anim = anim
                        }, {}, {}, function()
                            DeleteEntity(data.entity)
                        end, function()
                            StopAnimTask(ped, animDict, anim, 1.0)
                        end)
                    else
                        TriggerEvent("advancedgarages:client:radialImpoundVehicle")
                    end
                end
            end
        },
    })
    return id
end

storeVehicleZone2()

local function storeVehicleZone(garage, garageName, isJob)
    local options = {
        { targetIcon = "fa-solid fa-warehouse" },
        {
            onSelect = function()
                if isJob then
                    StoreVehicle(garage, isJob)
                    return
                end
                StoreVehicle(ClosestGarage or garageName, isJob)
            end,
            canInteract = function()
                return (isJob and checkJob(garage.job) and inVehicle) or (not garage.isImpound and (IsGarageOwner or garage.available or IsKeyHolder) and inVehicle)
            end,
            distance = 150.0,
            icon = 'fas fa-car',
            label = 'Прибери Автомобил'
        }
    }
    local id = exports.ox_target:addBoxZone({
        coords = garage.coords.spawnCoords,
        distance = 150.0,
        rotation = 180.0,
        options = options,
        debug = Config.ZoneDebug
    })
    return id
end

local boxZones = {}
function InitZones()
    if #boxZones > 0 then
        for k, v in pairs(boxZones) do
            exports.ox_target:removeZone(v)
        end
        boxZones = {}
    end
    Wait(100)
    for k, garage in pairs(Config.Garages) do
        local options = {
            { targetIcon = "fa-solid fa-warehouse" },
        }
        if garage.type ~= 'plane' or garage.isImpound then
            table.insert(options, {
                onSelect = function()
                    OpenGarageMenu(k, garage.isImpound, nil, garage.type == 'boat')
                end,
                canInteract = function()
                    local job = garage.job and checkJob(garage.job)
                    if not garage.job then job = true end
                    return (IsGarageOwner or garage.available or IsKeyHolder) and job
                end,
                distance = 5.0,
                icon = 'fas fa-car',
                label = 'Гараж'
            })
        end
        if not garage.isImpound and garage.type ~= 'boat' then
            table.insert(options, {
                onSelect = function()
                    GotoShellGarage(k, garage.coords.spawnCoords, garage.shell.shell)
                end,
                canInteract = function()
                    local job = garage.job and checkJob(garage.job)
                    if not garage.job then job = true end
                    return (IsGarageOwner or garage.available or IsKeyHolder) and job
                end,
                icon = 'fas fa-warehouse',
                label = 'Влез в гараж',
                distance = 5.0
            })
        end
        if not garage.owner or garage.owner == '' and not garage.isImpound then
            table.insert(options, {
                onSelect = function()
                    local price = garage.price
                    TriggerServerEvent('advancedgarages:buyGarage', k, price)
                end,
                canInteract = function()
                    local job = garage.job and checkJob(garage.job)
                    if not garage.job then job = true end
                    return job
                end,
                distance = 5.0,
                icon = 'fas fa-store',
                label = 'Купи Гараж',
                debug = true
            })
        end
        local id = exports.ox_target:addBoxZone({
            coords = garage.coords.menuCoords,
            distance = 5.5,
            rotation = 180.0,
            name = 'garage:' .. k,
            id = k,
            index = k,
            options = options,
            debug = Config.ZoneDebug,
        })
        table.insert(boxZones, id)
        local otherId = storeVehicleZone(garage, k, false)
        table.insert(boxZones, otherId)
    end
end

local shellBoxes = {}
function InitShellGarages()
    for k, v in pairs(shellBoxes) do
        exports.ox_target:removeZone(v)
        shellBoxes = {}
    end
    for k, garage in pairs(ShellGarages) do
        if not garage.takeVehicle or not garage.takeVehicle.x then goto continue end
        local options = {
            { targetIcon = "fa-solid fa-warehouse" },
        }

        table.insert(options, {
            onSelect = function()
                local shell = garage?.shell
                nearbyGarageType = 'vehicle'
                GotoGarage(currentGarage, vec4(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z, garage.takeVehicle.h), shell?.shell)
            end,
            distance = 5.0,
            canInteract = function()
                return currentGarage == k and existKey
            end,
            icon = 'fas fa-warehouse',
            label = 'Влез в гараж'
        })
        table.insert(options, {
            onSelect = function()
                local shell = garage?.shell
                nearbyGarageType = 'vehicle'
                SaveVehicle(k, true)
                -- GotoGarage(k, vec4(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z, garage.takeVehicle.h), shell?.shell)
            end,
            distance = 5.0,
            icon = 'fas fa-car',
            label = 'Прибери автомобил',
            canInteract = function()
                return currentGarage == k and existKey and inVehicle
            end,
        })
        local id = exports.ox_target:addBoxZone({
            coords = vec3(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z),
            distance = 5.5,
            rotation = 180.0,
            name = 'shell-garage:' .. k,
            id = 'shell-' .. k,
            index = k,
            options = options,
            debug = Config.ZoneDebug,
        })
        shellBoxes[k] = id
        ::continue::
    end
end

CreateThread(function()
    for k, garage in pairs(Config.JobGarages) do
        local options = {
            { targetIcon = "fa-solid fa-warehouse" },
        }
        table.insert(options, {
            onSelect = function()
                local serverVehicles = RPC.CallAsync('advancedgarages:getJobVehicles', { garage = garage.name, job = garage.job })
                local vehicleList = serverVehicles
                local garageIsAvailable = RPC.CallAsync('advancedgarages:isGarageAvailable', { garage = k })
                if not garageIsAvailable then return SendTextMessage(Lang('GARAGES_NOTIFICATION_GARAGE_NOT_AVAILABLE'), 'error') end
                for _, veh in pairs(vehicleList) do
                    veh.vehicle = json.encode(veh.vehicle)
                end
                for a, model in ipairs(garage.vehicles) do
                    local plate = tostring(garage.job .. math.random(111, 999))
                    table.insert(vehicleList, {
                        vehicle = json.encode({
                            model = model,
                            plate = plate
                        }),
                        plate = plate,
                    })
                end
                TriggerServerEvent('advancedgarages:setInJobGarage', k, true)
                OpenGarageMenu(k, garage.isImpound, vehicleList)
            end,
            canInteract = function()
                return checkJob(garage.job)
            end,
            distance = 5.0,
            icon = 'fas fa-car',
            label = 'Гараж'
        })
        exports.ox_target:addBoxZone({
            coords = garage.coords.menuCoords,
            distance = 5.5,
            rotation = 180.0,
            name = 'job-garage:' .. k,
            id = k,
            index = k,
            options = options,
            debug = Config.ZoneDebug,
        })
        storeVehicleZone(garage, k, true)
    end
end)

CreateThread(function()
    for k, types in pairs(Config.VehicleShowRooms) do
        for a, v in pairs(types) do
            local options = {
                { targetIcon = "fa-solid fa-warehouse" },
            }
            table.insert(options, {
                onSelect = function()
                    ExitGarage()
                end,
                distance = 5.0,
                icon = 'fas fa-warehouse',
                label = 'Излез от гараж'
            })
            exports.ox_target:addBoxZone({
                coords = vec3(v.entry.x, v.entry.y, v.entry.z),
                distance = 5.5,
                rotation = 180.0,
                name = 'exit-garage:' .. k,
                id = k,
                index = k,
                options = options,
                debug = Config.ZoneDebug,
            })
        end
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Recovery.coords) do
        local options = {
            { targetIcon = "fa-solid fa-warehouse" },
        }
        table.insert(options, {
            onSelect = function()
                local vehicleList = RPC.CallAsync('advancedgarages:getRecoveryVehicles')
                if #vehicleList == 0 then
                    return SendTextMessage(Lang('GARAGES_NOTIFICATION_GIVE_EMPTY_OUT'), 'inform')
                end
                OpenRecoveryMenu(vehicleList)
            end,
            distance = 5.0,
            icon = 'fas fa-car-on',
            label = 'Върни автомобил за $' .. Config.Recovery.price
        })
        exports.ox_target:addBoxZone({
            coords = v,
            size = vec3(2.0, 2.0, 2.0),
            rotation = 180.0,
            name = 'recovery-garage:' .. k,
            id = k,
            index = k,
            options = options,
            debug = Config.ZoneDebug,
        })
    end
end)

CreateThread(function()
    local function checkMenu()
        local sleep = 1250
        if not ClosestGarage then return sleep end
        local garage = Config.Garages[ClosestGarage]
        if not IsGarageOwner and not garage.available and not IsKeyHolder then return sleep end
        if garage.job and not checkJob(garage.job) then return sleep end
        if garage.isImpound then return sleep end
        if inVehicle then
            sleep = 0
            -- DrawMarker(1, garage.coords.spawnCoords.x, garage.coords.spawnCoords.y, garage.coords.spawnCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 0.8, 255, 255, 255, 150, false, false, false, true, false, false, false)
        end
        return sleep
    end
    while true do
        local sleep = checkMenu()
        Wait(sleep)
    end
end)
