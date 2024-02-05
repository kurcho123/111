if Config.Menu ~= 'nh-context' then
    return
end

function CreateGarageMenu()
    TriggerEvent('nh-context:createMenu', {
        {
            header = 'Management',
        },
        {
            header = 'Create Vehicle Garage',
            event = 'advancedgarages:createVehicleGarage',
        },
        {
            header = 'Create Boat Garage',
            event = 'advancedgarages:createBoatGarage',
        },
        {
            header = 'Create Plane Garage',
            event = 'advancedgarages:createPlaneGarage',
        },
        {
            header = 'Delete Garage',
            event = 'advancedgarages:deleteGarage',
        }
    })
end

local activePromise = nil
function HandleGarageState()
    local promise = promise.new()
    activePromise = promise

    local Elements = {
        {
            header = 'Management',
        },
        {
            header = 'Create Private Garage',
            event = 'advancedgarages:client:createPrivateGarage',
        },
        {
            header = 'Create Public Garage',
            event = 'advancedgarages:client:createPublicGarage',
        },
    }

    TriggerEvent('nh-context:createMenu', Elements,
        function(menu, element)
            if element.onSelect then
                element.onSelect()
            end
        end)

    return Citizen.Await(promise)
end

RegisterNetEvent('advancedgarages:client:createPrivateGarage', function()
    if activePromise then
        activePromise:resolve('private')
        activePromise = nil
    end
end)

RegisterNetEvent('advancedgarages:client:createPublicGarage', function()
    if activePromise then
        activePromise:resolve('public')
        activePromise = nil
    end
end)

function OpenManagementMenu()
    TriggerEvent('nh-context:createMenu', {
        {
            header = 'Management',
        },
        {
            header = 'Give Key',
            event = 'advancedgarages:openGiveKeyMenu',
        },
        {
            header = 'Key Holders',
            event = 'advancedgarages:openKeyHoldersMenu',
        },
        {
            header = 'Sell Garage',
            event = 'advancedgarages:sellGarage',
        }
    })
end

function openGiveKeyMenu(players)
    local Elements = {
        {
            header = 'Give Key',
        }
    }
    for k, v in pairs(players) do
        local data = {
            id = v.id,
            garage = ClosestGarage
        }
        table.insert(Elements, {
            header = 'Give Key',
            context = 'Player: ' .. v.name.firstName .. ' ' .. v.name.lastName,
            event = 'advancedgarages:giveKey',
            server = true,
            args = {
                data
            }
        })
    end
    TriggerEvent('nh-context:createMenu', Elements)
end

function openTakeKeyMenu()
    local Elements = {
        {
            header = 'Take Key',
        }
    }
    local holders = RPC.CallAsync('advancedgarages:getGarageKeyHolders', { garage = ClosestGarage })
    if not holders or #holders == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GARAGE_EMPTY_KEYHOLDERS'), 'inform')
        return
    end
    for k, v in pairs(holders) do
        local data = {
            id = v.identifier,
            garage = ClosestGarage
        }
        table.insert(Elements, {
            header = 'Take Key',
            context = 'Player: ' .. v.firstname .. ' ' .. v.lastname,
            event = 'advancedgarages:takeKey',
            server = true,
            args = {
                data
            }
        })
    end
    TriggerEvent('nh-context:createMenu', Elements)
end

function HandleKeyboard(callback)
    local keyboard, value = exports['nh-keyboard']:Keyboard({
        header = 'Set a Price',
        rows = { 'Price' }
    })
    if keyboard then
        callback(value)
    end
end

function HandleGarageJob()
    local keyboard, value = exports['nh-keyboard']:Keyboard({
        header = 'Job Name (you can leave it blank for everyone)',
        rows = { 'Job Name' }
    })
    if keyboard then
        return value
    end
end

function OpenRecoveryMenu(vehicleList)
    local menu = {}
    table.insert(menu, {
        header = 'Recovery Vehicle (OUT)'
    })
    for k, v in pairs(vehicleList) do
        table.insert(menu, {
            header = v.plate,
            event = 'advancedgarages:RecoveryVehicle',
            server = true,
            args = {
                v
            }
        })
    end
    TriggerEvent('nh-context:createMenu', menu)
end

function OpenDeleteJobVehicleMenu(garage, job)
    local menu = {}
    local vehicles = RPC.CallAsync('advancedgarages:getJobVehicles', { garage = garage, job = job })
    
    if not vehicles or #vehicles == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GIVE_EMPTY_OUT'), 'inform')
        return
    end

    table.insert(menu, {
        header = 'Delete work vehicles'
    })
    
    for k, v in pairs(vehicles) do
        local data = {
            plate = v.plate,
            garage = garage
        }
        table.insert(menu, {
            header = v.plate,
            event = 'advancedgarages:deleteJobVehicle',
            server = true,
            args = {
                data
            }
        })
    end

    TriggerEvent('nh-context:createMenu', menu)
end
