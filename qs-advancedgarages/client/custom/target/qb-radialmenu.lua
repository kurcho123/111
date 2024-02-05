if Config.UseTarget ~= 'qb-radialmenu' then
    return
end

local menuItems = {}

local function AddRadialOption()
    RemoveRadialOptions()
    local garage

    if ClosestGarage then
        garage = Config.Garages[ClosestGarage]
    end

    if garage then
        if not inVehicle and garage.available or IsGarageOwner or IsKeyHolder then
            if garage.job and not checkJob(garage.job) then goto continue end
            if garage.type ~= 'plane' and not inVehicle then
                table.insert(menuItems, {
                    id = 'radialOpenMenu',
                    title = 'Open Garage',
                    icon = 'car',
                    type = 'client',
                    event = 'advancedgarages:client:radialOpenMenu',
                    shouldClose = true
                })
            end

            if garage.type ~= 'boat' and not garage.isImpound and not inVehicle or garage.type == 'plane' and garage.isImpound and not inVehicle then
                table.insert(menuItems, {
                    id = 'radialEnterShell',
                    title = 'Enter Garage',
                    icon = 'warehouse',
                    type = 'client',
                    event = 'advancedgarages:client:radialEnterShell',
                    shouldClose = true
                })
            end
        end
        ::continue::
    end

    if inVehicle and ClosestGarage and not garage.isImpound then
        if garage.job and not checkJob(garage.job) then goto continue end
        table.insert(menuItems, {
            id = 'radialSaveVehicle',
            title = 'Store Vehicle',
            icon = 'warehouse',
            type = 'client',
            event = 'advancedgarages:client:radialSaveVehicle',
            garage = ClosestGarage,
            shouldClose = true
        })
        ::continue::
    end

    local nearbyElevator = nearbyElevator()
    if nearbyElevator and nearbyElevator == 0 then
        table.insert(menuItems, {
            id = 'radialExitShell',
            title = 'Exit',
            icon = 'warehouse',
            type = 'client',
            event = 'advancedgarages:client:radialExitShell',
            shouldClose = true
        })
    end

    local recover = checkMenu()
    if recover == 0 then
        table.insert(menuItems, {
            id = 'radialRecoverVehicle',
            title = 'Recover',
            icon = 'car',
            type = 'client',
            event = 'advancedgarages:client:radialRecoverVehicle',
            shouldClose = true
        })
    end

    if IsGarageOwner and not inVehicle then
        table.insert(menuItems, {
            id = 'radialGarageManagement',
            title = 'Management',
            icon = 'bars-progress',
            type = 'client',
            event = 'advancedgarages:client:radialGarageManagement',
            shouldClose = true
        })
    end

    local nearbyHouseGarage = CheckNearbyGarage()
    if nearbyHouseGarage and nearbyHouseGarage == 0 and inVehicle then
        table.insert(menuItems, {
            id = 'save_vehicle',
            title = 'Store Vehicle',
            icon = 'warehouse',
            type = 'client',
            event = 'advancedgarages:client:radialSaveHousingGarage',
            shouldClose = true
        })
    end

    if nearbyHouseGarage and nearbyHouseGarage == 0 and not inVehicle then
        table.insert(menuItems, {
            id = 'enter_garage_shell',
            title = 'Enter Garage',
            icon = 'warehouse',
            type = 'client',
            event = 'advancedgarages:client:radialEnterHousingGarage',
            shouldClose = true
        })
    end

    local job = GetJobName()
    if IsJobAllowed(job, 'impound') and not inVehicle then
        table.insert(menuItems, {
            id = 'radialImpoundVehicle',
            title = 'Impound vehicle',
            icon = 'car-side',
            type = 'client',
            event = 'advancedgarages:client:radialImpoundVehicle',
            shouldClose = true
        })
    end

    if IsJobAllowed(job, 'create') and not inVehicle then
        table.insert(menuItems, {
            id = 'radialCreateGarage',
            title = 'Garage Menu',
            icon = 'compass-drafting',
            type = 'client',
            event = 'advancedgarages:client:radialCreateGarage',
            shouldClose = true
        })
    end

    for k, garage in pairs(Config.JobGarages) do
        local access = checkJob(garage.job)
        if access then
            local dst = #(playercoords - vec3(garage.coords.menuCoords.x, garage.coords.menuCoords.y, garage.coords.menuCoords.z))
            if dst < 15.0 and not inVehicle then
                table.insert(menuItems, {
                    id = 'radialOpenJobGarage',
                    title = 'Open Garage',
                    icon = 'warehouse',
                    type = 'client',
                    event = 'advancedgarages:client:radialOpenJobGarage',
                    garage = k,
                    shouldClose = true
                })
            end

            if dst < 15.0 and inVehicle then
                table.insert(menuItems, {
                    id = 'radialSaveVehicle',
                    title = 'Save Vehicle',
                    icon = 'warehouse',
                    type = 'client',
                    event = 'advancedgarages:client:radialSaveVehicle',
                    garage = k,
                    isJob = true,
                    shouldClose = true
                })
            end
        end
    end

    for _, item in ipairs(menuItems) do
        item.id = exports['qb-radialmenu']:AddOption(item)
    end
end

function RemoveRadialOptions()
    for _, item in ipairs(menuItems) do
        exports['qb-radialmenu']:RemoveOption(item.id)
    end
    menuItems = {}

    Debug('The qb-radialmenu table has been cleaned!')
end

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    AddRadialOption()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (resourceName == 'qs-advancedgarages') then
        RemoveRadialOptions()
    end
end)
