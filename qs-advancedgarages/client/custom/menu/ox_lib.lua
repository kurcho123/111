if Config.Menu ~= 'ox_lib' then
    return
end

function CreateGarageMenu()
    local elements = {
        {
            title = 'Create Vehicle Garage',
            onSelect = function(args)
                TriggerEvent('advancedgarages:createVehicleGarage')
            end
        },
        {
            title = 'Create Boat Garage',
            onSelect = function(args)
                TriggerEvent('advancedgarages:createBoatGarage')
            end
        },
        {
            title = 'Create Plane Garage',
            onSelect = function(args)
                TriggerEvent('advancedgarages:createPlaneGarage')
            end
        },
        {
            title = 'Delete Garage',
            onSelect = function(args)
                TriggerEvent('advancedgarages:deleteGarage')
            end
        },
    }
    lib.registerContext({
        id = 'create_menu',
        title = 'Management',
        options = elements
    })
    lib.showContext('create_menu')
end

function OpenManagementMenu()
    local elements = {
        {
            title = 'Give Key',
            onSelect = function(args)
                TriggerEvent('advancedgarages:openGiveKeyMenu')
            end
        },
        {
            title = 'Key Holders',
            onSelect = function(args)
                TriggerEvent('advancedgarages:openKeyHoldersMenu')
            end
        },
        {
            title = 'Sell Garage',
            onSelect = function(args)
                TriggerEvent('advancedgarages:sellGarage')
            end
        }
    }
    lib.registerContext({
        id = 'management',
        title = 'Management',
        options = elements
    })
    lib.showContext('management')
end

function openGiveKeyMenu(players)
    local elements = {}
    for k, v in pairs(players) do
        table.insert(elements, {
            title = 'Player: ' .. v.name.firstName .. ' ' .. v.name.lastName,
            onSelect = function(args)
                local data = {
                    id = v.id,
                    garage = ClosestGarage
                }
                TriggerServerEvent('advancedgarages:giveKey', data)
            end
        })
    end
    lib.registerContext({
        id = 'givekey',
        title = 'Give Keys',
        options = elements
    })
    lib.showContext('givekey')
end

function openTakeKeyMenu()
    local elements = {}
    local holders = RPC.CallAsync('advancedgarages:getGarageKeyHolders', { garage = ClosestGarage })
    if not holders or #holders == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GARAGE_EMPTY_KEYHOLDERS'), 'inform')
        return
    end
    for k, v in pairs(holders) do
        table.insert(elements, {
            title = 'Player: ' .. v.firstname .. ' ' .. v.lastname,
            onSelect = function(args)
                local data = {
                    id = v.identifier,
                    garage = ClosestGarage
                }
                TriggerServerEvent('advancedgarages:takeKey', data)
            end
        })
    end
    lib.registerContext({
        id = 'keyholders',
        title = 'Key Holders',
        options = elements
    })
    lib.showContext('keyholders')
end

function HandleKeyboard(callback)
    local input = lib.inputDialog('Set a Price', { 'Garage Price...' })

    if not input then return end
    local price = tonumber(input[1])

    if price then
        local amount = price
        if amount == nil then
            SendTextMessage('Invalid Amount', 'error')
        else
            if amount >= 0 then
                callback(amount)
            else
                SendTextMessage('Invalid Amount', 'error')
            end
        end
    end
end

function HandleGarageState()
    local promise = promise.new()
    local elements = {
        {
            title = 'Create Private Garage',
            onSelect = function(args)
                promise:resolve('private')
            end
        },
        {
            title = 'Create Public Garage',
            onSelect = function(args)
                promise:resolve('public')
            end
        }
    }
    lib.registerContext({
        id = 'garagestate',
        title = 'Garage State',
        options = elements
    })
    lib.showContext('garagestate')
    return Citizen.Await(promise)
end

function HandleGarageJob()
    local input = lib.inputDialog('Job Name (you can leave it blank for everyone)', { 'Job Name' })
    if not input or input[1] == '' then return false end
    return input[1]
end

function OpenRecoveryMenu(vehicleList)
    local menu = {}
    for k, v in pairs(vehicleList) do
        table.insert(menu, {
            title = v.plate,
            onSelect = function(args)
                TriggerServerEvent('advancedgarages:RecoveryVehicle', { plate = v.plate, type = v.type })
            end,
        })
    end
    lib.registerContext({
        id = 'recovery',
        title = 'Recovery Vehicle (OUT)',
        options = menu
    })
    lib.showContext('recovery')
end

function OpenDeleteJobVehicleMenu(garage, job)
    local menu = {}
    local vehicles = RPC.CallAsync('advancedgarages:getJobVehicles', { garage = garage, job = job })
    if not vehicles or #vehicles == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GIVE_EMPTY_OUT'), 'inform')
        return
    end
    for k, v in pairs(vehicles) do
        local data = {
            plate = v.plate,
            garage = garage
        }
        table.insert(menu, {
            title = v.plate,
            onSelect = function(args)
                TriggerServerEvent('advancedgarages:deleteJobVehicle', data)
            end,
        })
    end
    lib.registerContext({
        id = 'deletejobvehicle',
        title = 'Delete work vehicles',
        options = menu
    })
    lib.showContext('deletejobvehicle')
end
