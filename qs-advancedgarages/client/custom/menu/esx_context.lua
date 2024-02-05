if Config.Menu ~= 'esx_context' then
    return
end

function CreateGarageMenu()
    local Elements = {
        {
            unselectable = true,
            title = 'Management',
        },
        {
            title = 'Create Vehicle Garage',
            name = 'create_car',
        },
        {
            title = 'Create Boat Garage',
            name = 'create_boat',
        },
        {
            title = 'Create Plane Garage',
            name = 'create_plane',
        },
        {
            title = 'Delete Garage',
            name = 'delete',
        },
    }

    ESX.OpenContext('right', Elements,
        function(menu, element)
            if element.name == 'create_car' then
                TriggerEvent('advancedgarages:createVehicleGarage')
            elseif element.name == 'create_boat' then
                TriggerEvent('advancedgarages:createBoatGarage')
            elseif element.name == 'create_plane' then
                TriggerEvent('advancedgarages:createPlaneGarage')
            elseif element.name == 'delete' then
                TriggerEvent('advancedgarages:deleteGarage')
                ESX.CloseContext()
            end
        end, function(menu)
            ESX.CloseContext()
        end)
end

function HandleGarageState()
    local promise = promise.new()
    local Elements = {
        {
            unselectable = true,
            title = 'Management',
        },
        {
            title = 'Create Private Garage',
            name = 'private',
        },
        {
            title = 'Create Public Garage',
            name = 'public',
        },
    }

    ESX.OpenContext('right', Elements,
        function(menu, element)
            if element.name == 'private' then
                promise:resolve('private')
                ESX.CloseContext()
            elseif element.name == 'public' then
                promise:resolve('public')
            end
        end, function(element)
            ESX.CloseContext()
        end)
    return Citizen.Await(promise)
end

function OpenManagementMenu()
    local Elements = {
        {
            unselectable = true,
            title = 'Management',
        },
        {
            title = 'Give Key',
            name = 'givekey',
        },
        {
            title = 'Key Holders',
            name = 'keyholders',
        },
        {
            title = 'Sell Garage',
            name = 'sell',
        },
    }

    ESX.OpenContext('right', Elements,
        function(menu, element)
            if element.name == 'givekey' then
                TriggerEvent('advancedgarages:openGiveKeyMenu')
                ESX.CloseContext()
            end
            if element.name == 'keyholders' then
                TriggerEvent('advancedgarages:openKeyHoldersMenu')
                ESX.CloseContext()
            end
            if element.name == 'sell' then
                TriggerEvent('advancedgarages:sellGarage')
                ESX.CloseContext()
            end
        end, function(menu)
            ESX.CloseContext()
        end)
end

function openGiveKeyMenu(vehicleList)
    local Elements = {}
    table.insert(Elements, {
        unselectable = true,
        title = 'Give Key',
    })

    for k, v in pairs(vehicleList) do
        table.insert(Elements, {
            title = 'Player: ' .. v.name.firstName .. ' ' .. v.name.lastName,
            name = 'givekey',
            data = {
                id = v.id,
                garage = ClosestGarage
            }
        })
    end

    ESX.OpenContext('right', Elements, function(menu, element)
            if element.name == 'givekey' then
                local selectedData = element.data
                local data = {
                    id = selectedData.id,
                    garage = selectedData.garage
                }
                TriggerServerEvent('advancedgarages:giveKey', data)
                ESX.CloseContext()
            end
        end,
        function(menu)
            ESX.CloseContext()
        end)
end

function openTakeKeyMenu()
    local Elements = {}
    local holders = RPC.CallAsync('advancedgarages:getGarageKeyHolders', { garage = ClosestGarage })
    if not holders or #holders == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GARAGE_EMPTY_KEYHOLDERS'), 'inform')
        return
    end

    table.insert(Elements, {
        unselectable = true,
        title = 'Take Key',
    })

    for k, v in pairs(holders) do
        table.insert(Elements, {
            title = 'Player: ' .. v.firstname .. ' ' .. v.lastname,
            name = 'keyholders',
            data = {
                id = v.identifier,
                garage = ClosestGarage
            }
        })
    end

    ESX.OpenContext('right', Elements, function(menu, element)
            if element.name == 'keyholders' then
                local selectedData = element.data
                local data = {
                    id = selectedData.id,
                    garage = selectedData.garage
                }
                TriggerServerEvent('advancedgarages:takeKey', data)
                ESX.CloseContext()
            end
        end,
        function(menu)
            ESX.CloseContext()
        end)
end

function HandleKeyboard(callback)
    local Elements = {
        {
            title = 'Set a Price',
            input = true,
            inputType = 'number',
            inputValue = 1,
            inputPlaceholder = 'Garage Price...',
            name = 'price',
        },
        {
            title = 'Continue',
            name = 'next',
        },
    }
    ESX.OpenContext('right', Elements, function(menu, element)
        local amount = menu.eles[1].inputValue
        if amount == 0 or amount == nil then return end
        if element.name == 'next' then
            ESX.CloseContext()
            callback(amount)
        end
    end, function(menu)
        ESX.CloseContext()
    end)
end

function HandleGarageJob()
    local promise = promise.new()
    local Elements = {
        {
            title = 'Job Name (you can leave it blank for everyone)',
            input = true,
            inputType = 'text',
            inputValue = '',
            inputPlaceholder = 'Job Name...',
            name = 'Job Name',
        },
        {
            title = 'Continue',
            name = 'next',
        },
    }

    ESX.OpenContext('right', Elements, function(menu, element)
        local jobName = menu.eles[1].inputValue
        if jobName == nil then
            return promise:resolve(false)
        end
        if element.name == 'next' then
            ESX.CloseContext()
            promise:resolve(jobName)
        end
    end, function(menu)
        ESX.CloseContext()
    end)
    return Citizen.Await(promise)
end

function OpenRecoveryMenu(vehicleList)
    local Elements = {}
    table.insert(Elements, {
        unselectable = true,
        title = 'Recovery Vehicle (OUT)',
    })

    for k, v in pairs(vehicleList) do
        table.insert(Elements, {
            title = v.plate,
            plate = v.plate,
            type = v.type,
            name = 'recovery',
            data = {
                plate = v.plate,
                type = v.type
            }
        })
    end

    ESX.OpenContext('right', Elements, function(menu, element)
            if element.name == 'recovery' then
                local selectedData = element.data
                TriggerServerEvent('advancedgarages:RecoveryVehicle', selectedData)
                ESX.CloseContext()
            end
        end,
        function(menu)
            ESX.CloseContext()
        end)
end


function OpenDeleteJobVehicleMenu(garage, job)
    local Elements = {}
    local vehicles = RPC.CallAsync('advancedgarages:getJobVehicles', { garage = garage, job = job })
    if not vehicles or #vehicles == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GIVE_EMPTY_OUT'), 'inform')
        return
    end

    table.insert(Elements, {
        unselectable = true,
        title = 'Delete work vehicles',
    })


    for k, v in pairs(vehicles) do
        table.insert(Elements, {
            title = v.plate,
            name = 'next',
            data = {
                plate = v.plate,
                garage = garage
            }
        })
    end

    ESX.OpenContext('right', Elements, function(menu, element)
        if element.name == 'next' then
            local selectedData = element.data
            TriggerServerEvent('advancedgarages:deleteJobVehicle', selectedData)
            ESX.CloseContext()
        end
    end, function(menu)
        ESX.CloseContext()
    end)
end
