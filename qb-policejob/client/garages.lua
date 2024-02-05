--------Helicopter
local RadialPoliceOption = nil
local HasPoliceHeliOut = false

function EnterPoliceHeliZone()
    lib.showTextUI('Паркинг', {
        position = "right-center"
    })

    RadialPoliceOption = exports['qb-radialmenu']:AddOption({
        id = 'put_pol_veh',
        title = 'Прибери Хеликоптер',
        icon = 'blips',
        type = 'client',
        event = 'sp-policejob:client:delete-heli-money',
        shouldClose = true,
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and IsPedInAnyVehicle(PlayerPedId(), false) and Data.job ~= nil and Data.job.name == "police")
        end
    }, RadialPoliceOption)
end

function ExitPoliceHeliZone()
    lib.hideTextUI()
    exports['qb-radialmenu']:RemoveOption(RadialPoliceOption)
end

local box = lib.zones.box({
	name = "HeliPoliceGarage",
	coords = vec3(476.0, -1003.0, 46.0),
	size = vec3(15.0, 14.0, 5.0),
	rotation = 0.0,
    onEnter = EnterPoliceHeliZone,
    onExit = ExitPoliceHeliZone
})


RegisterNetEvent("sp-policejob:client:delete-heli", function()
    if HasPoliceHeliOut == true then
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        TaskLeaveVehicle(PlayerPedId(), car)
        Wait(2000)
        NetworkFadeOutEntity(car, true,false)
        Wait(500)
        QBCore.Functions.DeleteVehicle(car)
        HasPoliceHeliOut = false
    end
end)

RegisterNetEvent('sp-policejob:client:delete-heli-money', function()
    if HasPoliceHeliOut == true then
        Wait(2000)
        TriggerServerEvent('sp-policejob:server:removemoney')
        HasPoliceHeliOut = false
    end
end)


function SpawnPoliceHeli(vehName)
    for k, v in pairs(Config.PoliceJobHeli.SpawnPointsHeli) do
        local isPositionOccupied = IsPositionOccupied(v.x, v.y, v.z, 10, false, true, false, false, false, 0, false)
        if not isPositionOccupied then
            QBCore.Functions.LoadModel(vehName)
            polHeli = CreateVehicle(vehName, v.x, v.y, v.z, v.w, true, true)
        
            local VehiclePlate = GetVehicleNumberPlateText(polHeli)
            local networkID = NetworkGetNetworkIdFromEntity(polHeli)
            SetEntityAsMissionEntity(polHeli)
            SetNetworkIdExistsOnAllMachines(networkID, true)
            NetworkRegisterEntityAsNetworked(polHeli)
            SetNetworkIdCanMigrate(networkID, true)
            SetVehicleDirtLevel(polHeli, 0)
            SetVehicleEngineOn(polHeli, true, true)
            SetVehicleDoorsLocked(polHeli, 1)
            SetVehicleModKit(polHeli, 0)
            SetVehicleMod(polHeli, 48, 0)
            for i = 0, 13 do
                SetVehicleExtra(polHeli, i, 0)
            end

            TriggerEvent("vehiclekeys:client:SetOwner", VehiclePlate)
            exports["cdn-fuel"]:SetFuel(polHeli, 100)
            HasPoliceHeliOut = true
            return
        end
    end
    QBCore.Functions.Notify("Всички паркоместа са блокирани.", "error", 3000)
end

RegisterNetEvent("sp-policejob:client:policeheli-menu", function()

    local PlyData = QBCore.Functions.GetPlayerData()
    if PlyData.job.name ~= "police" then QBCore.Functions.Notify("Не си полицай.", "error", 3000) return end
    local Menu = {
        id = 'police-heli-menu',
        title = 'Полицейски Хеликоптер',
        options = {
            {
                title = 'Върни хеликоптер',
                description = 'Връща хеликоптера ако той не може да бъде прибран, срещу $20',
                icon = 'money-check-dollar',
                event = 'sp-policejob:client:delete-heli-money',
            }
        }
    }

    for vehSpawnCode, vehData in pairs(Config.PoliceJobHeli.PoliceHelicopter) do
        if vehData.Job == PlyData.job.name then
            if vehData.RequiredRank ~= nil then
                table.insert(Menu.options, {
                    title = vehData.DisplayName,
                    icon = 'car',
                    arrow = true,
                    disabled = PlyData.job.grade.level < vehData.RequiredRank or HasPoliceHeliOut == true,
                    onSelect = function()
                        SpawnPoliceHeli(vehSpawnCode)
                    end
                })
            end
        end
    end

    lib.registerContext(Menu)
    lib.showContext('police-heli-menu')
end)

--Bloads
local RadialBoatsOption = nil
local HasBoatsHeliOut = false

function EnterPoliceboatsZone()
    lib.showTextUI('Паркинг за лодки', {
        position = "right-center"
    })

    RadialBoatsOption = exports['qb-radialmenu']:AddOption({
        id = 'put_pol_veh',
        title = 'Прибери Лодка',
        icon = 'blips',
        type = 'client',
        event = 'sp-policejob:client:delete-boats',
        shouldClose = true,
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and IsPedInAnyVehicle(PlayerPedId(), false) and Data.job ~= nil and Data.job.name == "police")
        end
    }, RadialBoatsOption)
end

function ExitPoliceHboatsZone()
    lib.hideTextUI()
    exports['qb-radialmenu']:RemoveOption(RadialBoatsOption)
end

local box = lib.zones.box({
	name = "boatsgarage",
	coords = vec3(-834.0, -1392.0, 2.0),
	size = vec3(15.0, 41.0, 5.0),
	rotation = 20.0,
    onEnter = EnterPoliceboatsZone,
    onExit = ExitPoliceHboatsZone
})


RegisterNetEvent("sp-policejob:client:delete-boats", function()
    if HasBoatsHeliOut == true then
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        TaskLeaveVehicle(PlayerPedId(), car)
        Wait(2000)
        NetworkFadeOutEntity(car, true,false)
        Wait(500)
        QBCore.Functions.DeleteVehicle(car)
        HasBoatsHeliOut = false
    end
end)

RegisterNetEvent('sp-policejob:client:delete-boats-money', function()
    if HasBoatsHeliOut == true then
        Wait(2000)
        TriggerServerEvent('sp-policejob:server:removemoney')
        HasBoatsHeliOut = false
    end
end)

function SpawnPoliceHeli(vehName)
    for k, v in pairs(Config.PoliceJobBoats.SpawnPointsBoats) do
        local isPositionOccupied = IsPositionOccupied(v.x, v.y, v.z, 10, false, true, false, false, false, 0, false)
        if not isPositionOccupied then
            QBCore.Functions.LoadModel(vehName)
            polHeli = CreateVehicle(vehName, v.x, v.y, v.z, v.w, true, true)
            local VehiclePlate = GetVehicleNumberPlateText(polHeli)
            local networkID = NetworkGetNetworkIdFromEntity(polHeli)
            SetEntityAsMissionEntity(polHeli)
            SetNetworkIdExistsOnAllMachines(networkID, true)
            NetworkRegisterEntityAsNetworked(polHeli)
            SetNetworkIdCanMigrate(networkID, true)
            SetVehicleDirtLevel(polHeli, 0)
            SetVehicleEngineOn(polHeli, true, true)
            SetVehicleDoorsLocked(polHeli, 1)
            SetVehicleModKit(polHeli, 0)
            SetVehicleMod(polHeli, 48, 0)
            for i = 0, 13 do
                SetVehicleExtra(polHeli, i, 0)
            end
            TriggerEvent("vehiclekeys:client:SetOwner", VehiclePlate)
            exports["cdn-fuel"]:SetFuel(polHeli, 100)
            HasBoatsHeliOut = true
            return
        end
    end
    QBCore.Functions.Notify("Всички паркоместа са блокирани.", "error", 3000)
end

RegisterNetEvent("sp-policejob:client:boats-menu", function()
    local PlyData = QBCore.Functions.GetPlayerData()
    if PlyData.job.name ~= "police" then QBCore.Functions.Notify("Не си полицай.", "error", 3000) return end
    local Menu = {
        id = 'police-boats-menu',
        title = 'Полицейскa Лодка',
        options = {
            {
                title = 'Върни Лодката',
                description = 'Връща лоадката ако той не може да бъде прибрана, срещу $20',
                icon = 'money-check-dollar',
                event = 'sp-policejob:client:delete-boats-money',
            }
        }
    }

    for vehSpawnCode, vehData in pairs(Config.PoliceJobBoats.PoliceBoats) do
        if vehData.Job == PlyData.job.name then
            if vehData.RequiredRank ~= nil then
                table.insert(Menu.options, {
                    title = vehData.DisplayName,
                    icon = 'car',
                    arrow = true,
                    disabled = PlyData.job.grade.level < vehData.RequiredRank or HasBoatsHeliOut == true,
                    onSelect = function()
                        SpawnPoliceHeli(vehSpawnCode)
                    end
                })
            end
        end
    end

    lib.registerContext(Menu)
    lib.showContext('police-boats-menu')
end)

local LawyerRadialOption = nil
local HasLawyerVehOut = false

function EnterLaweryVehsZone()
    lib.showTextUI('Паркинг', {
        position = "right-center"
    })

    RadialBoatsOption = exports['qb-radialmenu']:AddOption({
        id = 'put_lawyer_veh',
        title = 'Прибери Автомобил',
        icon = 'blips',
        type = 'client',
        event = 'sp-policejob:client:delete-lawyer-veh',
        shouldClose = true,
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and IsPedInAnyVehicle(PlayerPedId(), false) and Data.job ~= nil and Data.job.name == "lawyer")
        end
    }, RadialBoatsOption)
end

function ExitLaweryVehsZone()
    lib.hideTextUI()
    exports['qb-radialmenu']:RemoveOption(RadialBoatsOption)
end

local box = lib.zones.box({
	name = "boatsgarage",
	coords = vec3(258.63, -1563.84, 29.04),
	size = vec3(15.0, 41.0, 5.0),
    rotation = 120,
    onEnter = EnterLaweryVehsZone,
    onExit = ExitLaweryVehsZone
})

function SpawnLawyerVeh(vehName)
    for k, v in pairs(Config.LawyerVehicles.SpawnPoints) do
        local isPositionOccupied = IsPositionOccupied(v.x, v.y, v.z, 10, false, true, false, false, false, 0, false)
        if not isPositionOccupied then
            QBCore.Functions.LoadModel(vehName)
            lawyerVeh = CreateVehicle(vehName, v.x, v.y, v.z, v.w, true, true)
        
            local VehiclePlate = GetVehicleNumberPlateText(lawyerVeh)
            local networkID = NetworkGetNetworkIdFromEntity(lawyerVeh)
            SetEntityAsMissionEntity(lawyerVeh)
            SetNetworkIdExistsOnAllMachines(networkID, true)
            NetworkRegisterEntityAsNetworked(lawyerVeh)
            SetNetworkIdCanMigrate(lawyerVeh, true)
            SetVehicleDirtLevel(lawyerVeh, 0)
            SetVehicleEngineOn(lawyerVeh, true, true)
            SetVehicleDoorsLocked(lawyerVeh, 1)
            SetVehicleModKit(lawyerVeh, 0)
            SetVehicleMod(lawyerVeh, 48, 0)
            for i = 0, 13 do
                SetVehicleExtra(lawyerVeh, i, 0)
            end

            TriggerEvent("vehiclekeys:client:SetOwner", VehiclePlate)
            exports["cdn-fuel"]:SetFuel(lawyerVeh, 100)
            HasLawyerVehOut = true
            return
        end
    end
    QBCore.Functions.Notify("Всички паркоместа са блокирани.", "error", 3000)
end

RegisterNetEvent("sp-policejob:client:delete-lawyer-veh", function()
    if HasLawyerVehOut == true then
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        TaskLeaveVehicle(PlayerPedId(), car)
        Wait(2000)
        NetworkFadeOutEntity(car, true,false)
        Wait(500)
        QBCore.Functions.DeleteVehicle(car)
        HasLawyerVehOut = false
    end
end)

RegisterNetEvent('sp-policejob:client:delete-lawyer-money', function()
    if HasLawyerVehOut == true then
        Wait(2000)
        TriggerServerEvent('sp-policejob:server:removemoney')
        HasLawyerVehOut = false
    end
end)

RegisterNetEvent("sp-policejob:client:lawyer-vehicles-menu", function()
    local PlyData = QBCore.Functions.GetPlayerData()
    if PlyData.job.name ~= "lawyer" then QBCore.Functions.Notify("Не си адвокат.", "error", 3000) return end
    local Menu = {
        id = 'lawyer-vehicle-menu',
        title = 'Автомобили',
        options = {
            {
                title = 'Върни Автомобил',
                description = 'Връща автомобила ако той не може да бъде прибран, срещу $20',
                icon = 'money-check-dollar',
                disabled = HasLawyerVehOut == false,
                event = 'sp-policejob:client:delete-lawyer-money',
            }
        }
    }

    for vehSpawnCode, vehData in pairs(Config.LawyerVehicles.Vehicles) do
        if vehData.Job == PlyData.job.name then
            if vehData.RequiredRank ~= nil then
                table.insert(Menu.options, {
                    title = vehData.DisplayName,
                    icon = 'car',
                    arrow = true,
                    disabled = PlyData.job.grade.level < vehData.RequiredRank or HasLawyerVehOut == true,
                    onSelect = function()
                        SpawnLawyerVeh(vehSpawnCode)
                    end
                })
            end
        end
    end

    lib.registerContext(Menu)
    lib.showContext('lawyer-vehicle-menu')
end)