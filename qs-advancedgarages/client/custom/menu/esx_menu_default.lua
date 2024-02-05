if Config.Menu ~= 'esx_menu_default' then
    return
end

function CreateGarageMenu()
    local elementsList = {}

    table.insert(elementsList, { label = 'Create Vehicle Garage', value = 'create_car' })
    table.insert(elementsList, { label = 'Create Boat Garage', value = 'create_boat' })
    table.insert(elementsList, { label = 'Create Plane Garage', value = 'create_plane' })
    table.insert(elementsList, { label = 'Delete Garage', value = 'delete' })

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'creategarage', {
        title    = 'Management',
        align    = 'right',
        elements = elementsList
    }, function(data, menu)
        if data.current.value == 'create_car' then
            menu.close()
            TriggerEvent('advancedgarages:createVehicleGarage')
        elseif data.current.value == 'create_boat' then
            menu.close()
            TriggerEvent('advancedgarages:createBoatGarage')
        elseif data.current.value == 'create_plane' then
            menu.close()
            TriggerEvent('advancedgarages:createPlaneGarage')
        elseif data.current.value == 'delete' then
            menu.close()
            TriggerEvent('advancedgarages:deleteGarage')
        end
    end, function(data, menu)
        menu.close()
    end)
end

function HandleGarageState()
    local promise = promise.new()
    local Elements = {}

    table.insert(Elements, { label = 'Create Private Garage', value = 'private' })
    table.insert(Elements, { label = 'Create Public Garage', value = 'public' })

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'management', {
        title    = 'Management',
        align    = 'right',
        elements = Elements
    }, function(data, menu)
        if data.current.value == 'private' then
            menu.close()
            promise:resolve('private')
        end
        if data.current.value == 'public' then
            menu.close()
            promise:resolve('public')
        end
    end, function(data, menu)
        menu.close()
    end)
    return Citizen.Await(promise)
end

function OpenManagementMenu()
    local elementsList = {}

    table.insert(elementsList, { label = 'Give Key', value = 'givekey' })
    table.insert(elementsList, { label = 'Key Holders', value = 'keyholders' })
    table.insert(elementsList, { label = 'Sell Garage', value = 'sell' })

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'management', {
        title    = 'Management',
        align    = 'right',
        elements = elementsList
    }, function(data, menu)
        if data.current.value == 'givekey' then
            menu.close()
            TriggerEvent('advancedgarages:openGiveKeyMenu')
        end
        if data.current.value == 'keyholders' then
            menu.close()
            TriggerEvent('advancedgarages:openKeyHoldersMenu')
        end
        if data.current.value == 'sell' then
            menu.close()
            TriggerEvent('advancedgarages:sellGarage')
        end
    end, function(data, menu)
        menu.close()
    end)
end

function openGiveKeyMenu(players)
    local elementsList = {}

    for k, v in pairs(players) do
        table.insert(elementsList, {
            label = 'Player: ' .. v.name.firstName .. ' ' .. v.name.lastName,
            value = {
                id = v.id,
                garage = ClosestGarage
            }
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'givekey', {
        title = 'Give Key',
        align = 'right',
        elements = elementsList
    }, function(data, menu)
        if data.current.value then
            menu.close()
            local selectedData = data.current.value
            local data = {
                id = selectedData.id,
                garage = selectedData.garage
            }
            TriggerServerEvent('advancedgarages:giveKey', data)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function openTakeKeyMenu()
    local elementsList = {}
    local holders = RPC.CallAsync('advancedgarages:getGarageKeyHolders', { garage = ClosestGarage })
    if not holders or #holders == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GARAGE_EMPTY_KEYHOLDERS'), 'inform')
        return
    end
    for k, v in pairs(holders) do
        table.insert(elementsList, {
            label = 'Player: ' .. v.firstname .. ' ' .. v.lastname,
            value = {
                id = v.identifier,
                garage = ClosestGarage
            }
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'keyholders', {
        title = 'Recovery',
        align = 'right',
        elements = elementsList
    }, function(data, menu)
        if data.current.value then
            menu.close()
            local selectedData = data.current.value
            local data = {
                id = selectedData.id,
                garage = selectedData.garage
            }
            TriggerServerEvent('advancedgarages:takeKey', data)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function HandleKeyboard(callback)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'price',
        {
            title = ('Set a price')
        },
        function(data, menu)
            local amount = tonumber(data.value)
            if amount == nil then
                SendTextMessage('Invalid Amount', 'error')
            else
                menu.close()
                callback(amount)
            end
        end,
        function(data, menu)
            menu.close()
        end)
end

function HandleGarageJob()
    local promise = promise.new()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'job',
        {
            title = ('Job Name (you can leave it blank for everyone)')
        },
        function(data, menu)
            local jobName = data.value
            if jobName == nil then
                menu.close()
                return promise:resolve(false)
            end

            promise:resolve(jobName)
            menu.close()
        end,
        function(data, menu)
            menu.close()
        end)
    return Citizen.Await(promise)
end

function OpenRecoveryMenu(vehicleList)
    local elementsList = {}

    for k, v in pairs(vehicleList) do
        table.insert(elementsList, {
            label = v.plate,
            type = v.type,
            value = {
                plate = v.plate,
                type = v.type
            }
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recovery', {
        title = 'Recovery Vehicle (OUT)',
        align = 'right',
        elements = elementsList
    }, function(data, menu)
        if data.current.value then
            menu.close()
            local selectedData = data.current.value
            TriggerServerEvent('advancedgarages:RecoveryVehicle', selectedData)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenDeleteJobVehicleMenu(garage, job)
    local elementsList = {}
    local vehicles = RPC.CallAsync('advancedgarages:getJobVehicles', { garage = garage, job = job })
    if not vehicles or #vehicles == 0 then
        SendTextMessage(Lang('GARAGES_NOTIFICATION_GIVE_EMPTY_OUT'), 'inform')
        return
    end

    for k, v in pairs(vehicles) do
        table.insert(elementsList, {
            label = v.plate,
            value = {
                plate = v.plate,
                garage = garage
            }
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'deletejob', {
        title = 'Delete work vehicles',
        align = 'right',
        elements = elementsList
    }, function(data, menu)
        local selectedData = data.current.value
        if selectedData then
            TriggerServerEvent('advancedgarages:deleteJobVehicle', selectedData)
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end
