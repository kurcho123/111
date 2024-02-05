if Config.Menu ~= 'qb-menu' then
    return
end

function CreateGarageMenu()
    local elementsList = {
        {
            header = 'Management',
            isMenuHeader = true,
        },
        {
            header = 'Create Vehicle Garage',
            params = {
                event = 'advancedgarages:createVehicleGarage',
            }
        },
        {
            header = 'Create Boat Garage',
            params = {
                event = 'advancedgarages:createBoatGarage',
            }
        },
        {
            header = 'Create Plane Garage',
            params = {
                event = 'advancedgarages:createPlaneGarage',
            }
        },
        {
            header = 'Delete Garage',
            params = {
                event = 'advancedgarages:deleteGarage',
            }
        }
    }

    exports['qb-menu']:openMenu(elementsList)
end

local activePromise = nil
function HandleGarageState()
    local promise = promise.new()
    activePromise = promise

    local Elements = {
        {
            header = 'Create Private Garage',
            params = {
                event = 'advancedgarages:client:createPrivateGarage',
            },
        },
        {
            header = 'Create Public Garage',
            params = {
                event = 'advancedgarages:client:createPublicGarage',
            },
        },
    }

    exports['qb-menu']:openMenu(Elements,
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
    local elementsList = {
        {
            header = 'Management',
            isMenuHeader = true,
        },
        {
            header = 'Give Key',
            params = {
                event = 'advancedgarages:openGiveKeyMenu',
            }
        },
        {
            header = 'Key Holders',
            params = {
                event = 'advancedgarages:openKeyHoldersMenu',
            }
        },
        {
            header = 'Sell Garage',
            params = {
                event = 'advancedgarages:sellGarage',
            }
        },
    }

    exports['qb-menu']:openMenu(elementsList)
end

function openGiveKeyMenu(players)
    local elementsList = {}
    table.insert(elementsList, {
        header = 'Give Key',
        isMenuHeader = true,
    })
    for k, v in pairs(players) do
        table.insert(elementsList, {
            header = 'Player: ' .. v.name.firstName .. ' ' .. v.name.lastName,
            params = {
                isServer = true,
                event = 'advancedgarages:giveKey',
                args = {
                    id = v.id,
                    garage = ClosestGarage
                }
            }
        })
    end
    exports['qb-menu']:openMenu(elementsList)
end

function openTakeKeyMenu()
    local elementsList = {}
    local holders = RPC.CallAsync('advancedgarages:getGarageKeyHolders', { garage = ClosestGarage })
    if not holders or #holders == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GARAGE_EMPTY_KEYHOLDERS'), 'inform')
        return
    end

    table.insert(elementsList, {
        header = 'Take Key',
        isMenuHeader = true,
    })

    for k, v in pairs(holders) do
        table.insert(elementsList, {
            header = 'Player: ' .. v.firstname .. ' ' .. v.lastname,
            params = {
                isServer = true,
                event = 'advancedgarages:takeKey',
                args = {
                    id = v.identifier,
                    garage = ClosestGarage
                }
            }
        })
    end
    exports['qb-menu']:openMenu(elementsList)
end

function HandleKeyboard(callback)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Set a Price',
        submitText = 'Continue',
        inputs = {
            {
                text = 'Garage Price...',
                name = 'price',
                type = 'number',
                isRequired = true,
            }
        },
    })

    if dialog ~= nil then
        for k, v in pairs(dialog) do
            callback(v)
        end
    end
end

function HandleGarageJob()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Job Name (you can leave it blank for everyone)',
        submitText = 'Continue',
        inputs = {
            {
                text = 'Job Name...',
                name = 'Job public garage',
                type = 'text',
                isRequired = false,
            }
        },
    })

    if dialog ~= nil then
        for k, v in pairs(dialog) do
            if v and v ~= '' then
                return v
            end

            return nil
        end
    end
end

function OpenRecoveryMenu(vehicleList)
    local elementsList = {}
    table.insert(elementsList, {
        header = 'Recovery Vehicle (OUT)',
        isMenuHeader = true,
    })

    for k, v in pairs(vehicleList) do
        table.insert(elementsList, {
            header = v.plate,
            params = {
                isServer = true,
                event = 'advancedgarages:RecoveryVehicle',
                args = {
                    plate = v.plate,
                    type = v.type
                }
            }
        })
    end
    exports['qb-menu']:openMenu(elementsList)
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
        table.insert(menu, {
            header = v.plate,
            params = {
                isServer = true,
                event = 'advancedgarages:deleteJobVehicle',
                args = {
                    plate = v.plate,
                    garage = garage
                }
            }
        })
    end

    exports['qb-menu']:openMenu(menu)
end
