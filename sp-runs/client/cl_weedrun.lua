local package
local hasPackage = false
local waitingForPackage = false
local packageZone
local delivering = false
local dropOffBlip
local hasDropOff = false
local dropOffArea
local deliveryPed
local madeDeal = false
local QBCore = exports["qb-core"]:GetCoreObject()
--- Functions
--- Checks if a player has a suspicious package on him or her
--- @return nil
local checkPackage = function()
    QBCore.Functions.TriggerCallback('sp-runs:server:suspackageitem', function(success)
       -- QBCore.Functions.HasItem(Shared.SusPackageItem, 1)
    if success then
        if not hasPackage then
            -- Animation
            local ped = PlayerPedId()
            RequestAnimDict('anim@heists@box_carry@')
            while not HasAnimDictLoaded('anim@heists@box_carry@') do Wait(0) end
            TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
    
            -- Package
            local pos = GetEntityCoords(ped, true)
            RequestModel(Shared.PackageProp)
            while not HasModelLoaded(Shared.PackageProp) do Wait(0) end
            local object = CreateObject(Shared.PackageProp, pos.x, pos.y, pos.z, true, true, true)
            AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, 57005), 0.1, 0.1, -0.25, 300.0, 250.0, 15.0, true, true, false, true, 1, true)
            package = object
            hasPackage = true
            
            -- Walk
            CreateThread(function()
                while hasPackage do
                    Wait(0)
                    SetPlayerSprint(PlayerId(), false)
                    DisableControlAction(0, 21, true)
                    DisableControlAction(0, 22, true)
                    if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
                    end
                end
            end)
        end
    else
        DetachEntity(package, true, true)
        DeleteObject(package)
        StopAnimTask(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 1.0)
        package = nil
        hasPackage = false
    end
end)
end

--- Creates a drop off blip at a given coordinate
--- @param coords vector4 - Coordinates of a location
local createDropOffBlip = function(coords)
	dropOffBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(dropOffBlip, 140)
    SetBlipColour(dropOffBlip, 25)
    SetBlipAsShortRange(dropOffBlip, false)
    SetBlipRoute(dropOffBlip, true)
    SetBlipRouteColour(dropOffBlip, 2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(_U('weedrun_delivery_blip'))
    EndTextCommandSetBlipName(dropOffBlip)
end

--- Creates a drop off ped at a given coordinate
--- @param coords vector4 - Coordinates of a location
--- @return nil
local createDropOffPed = function(coords)
	if deliveryPed then return end
	local model = Shared.DropOffPeds[math.random(#Shared.DropOffPeds)]
	local hash = GetHashKey(model)

    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
	deliveryPed = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, true, true)
	while not DoesEntityExist(deliveryPed) do Wait(0) end
	ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)
    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)
	FreezeEntityPosition(deliveryPed, true)
    local netId = NetworkGetNetworkIdFromEntity(deliveryPed)
    local options = {
        {targetIcon = 'fas fa-cannabis', distance = 2.5},
        {
            event = 'sp-runs:client:DeliverWeed',
            icon = 'fas fa-cannabis',
            label = _U('deliver_package'),
            items = Shared.SusPackageItem,
            distance = 1.5
        }
    }
    exports.ox_target:addEntity(netId, options)
end

--- Method to create a drop-off location for delivering the weedrun packages
--- @return nil
local maxDropOffs = 3
local createdDropOffs = 0

local createNewDropOff = function()
    if hasDropOff or createdDropOffs >= maxDropOffs then
        QBCore.Functions.Notify(_U('deliver_not'), "error")
        TriggerEvent('sp-runs:client:ClockOut')
        delivering =  false
        return
    end

    createdDropOffs = createdDropOffs + 1
    if createdDropOffs >= maxDropOffs then
        local randomTimeout = math.random(Shared.SetTimeout[1], Shared.SetTimeout[2])
        SetTimeout(randomTimeout * 60 * 1000, function()
            createdDropOffs = 0
        end)
    end

    hasDropOff = true
    lib.notify({
        title = _U('weedrun_delivery_title'),
        description = _U('weedrun_delivery_godropoff'),
        position = 'center-left',
        style = {
            backgroundColor = '#17181F',
            color = '#38a2e5',
            ['.description'] = {
              color = '#38a2e5'
            }
        },
        icon = 'fas fa-cannabis',
        iconColor = '#51CF66', duration = 5000
    })
    local randomLoc = Shared.DropOffLocations[math.random(#Shared.DropOffLocations)]
    createDropOffBlip(randomLoc)
    dropOffArea = CircleZone:Create(randomLoc.xyz, 85.0, {
        name = 'dropOffArea',
        debugPoly = Shared.Debug
    })

    dropOffArea:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            if not deliveryPed then
                lib.notify({
                    title = _U('weedrun_delivery_title'),
                    description = _U('weedrun_delivery_makedropoff'),
                    position = 'center-left',
                    style = {
                        backgroundColor = '#17181F',
                        color = '#38a2e5',
                        ['.description'] = {
                          color = '#38a2e5'
                        }
                    },
                    icon = 'fas fa-cannabis',
                    iconColor = '#51CF66', duration = 5000
                })
                createDropOffPed(randomLoc)
            end
        end
    end)
end


--- Method to clear current weed run
--- @return nil
clearWeedRun = function()
    -- Deliveries
    delivering = false
    hasDropOff = false
    RemoveBlip(dropOffBlip)
    if dropOffArea then
        dropOffArea:destroy()
        DeletePed(deliveryPed)
	    deliveryPed = nil
    end

    -- Package
    if package then
        DetachEntity(package, true, true)
        DeleteObject(package)
        StopAnimTask(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 1.0)
        package = nil
        hasPackage = false
    end
end

--- Events

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    checkPackage()
end)

RegisterNetEvent('sp-runs:client:CollectPackageGoods', function(data)
    if waitingForPackage then
        TriggerServerEvent('sp-runs:server:CollectPackageGoods', data)
    else
        QBCore.Functions.Notify(_U('weed_nothing'), "primary")
    end
end)

RegisterNetEvent('sp-runs:client:Start', function(data)
    if not waitingForPackage then
        TriggerEvent('sp-runs:client:StartPackage', data)
    else
        QBCore.Functions.Notify(_U('not_supply'), "primary")
    end
end)

RegisterNetEvent('sp-runs:client:StartPackage', function(data)
    if waitingForPackage then return end
    QBCore.Functions.TriggerCallback('sp-runs:server:hasitems', function(hasItem)
    if not hasItem then
        QBCore.Functions.Notify(_U('dont_have_anything'), 'error', 2500)
        return
    end

    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
    Wait(1500)
    PlayAmbientSpeech1(ped, 'Generic_Hi', 'Speech_Params_Force')
    Wait(1000)
    RequestAnimDict('mp_safehouselost@')
    while not HasAnimDictLoaded('mp_safehouselost@') do Wait(0) end
    TaskPlayAnim(ped, 'mp_safehouselost@', 'package_dropoff', 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    QBCore.Functions.Progressbar('weedrun_pack', _U('handing_over_weed'), 4000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        FreezeEntityPosition(ped, false)
        QBCore.Functions.TriggerCallback('sp-runs:server:PackageGoods', function(result)
            if not result then return end
            waitingForPackage = true
            QBCore.Functions.Notify(_U('wait_closeby'), 'primary', 2500)
    
            packageZone = CircleZone:Create(Shared.WeedRunStart.xyz, 10.0, {
                name = 'weedrunning_start',
                debugPoly = Shared.Debug
            })
            
            packageZone:onPlayerInOut(function(isPointInside, point)
                if not isPointInside then
                    packageZone:destroy()
                    if waitingForPackage then
                        TriggerServerEvent('sp-runs:server:DestroyWaitForPackage')
                        waitingForPackage = false
                    end
                end
            end)
        end)
    end, function()
        QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
        FreezeEntityPosition(ped, false)
    end)
end)
end)


RegisterNetEvent('sp-runs:client:StartPackage', function(data)
    if waitingForPackage then return end
    QBCore.Functions.TriggerCallback('sp-runs:server:hasitems', function(hasItem)
    if not hasItem then
        QBCore.Functions.Notify(_U('dont_have_anything'), 'error', 2500)
        return
    end
end)

    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    PlayAmbientSpeech1(ped, 'Generic_Hi', 'Speech_Params_Force')
    RequestAnimDict('mp_safehouselost@')
    while not HasAnimDictLoaded('mp_safehouselost@') do Wait(0) end
    TaskPlayAnim(ped, 'mp_safehouselost@', 'package_dropoff', 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    QBCore.Functions.Progressbar('weedrun_pack', _U('handing_over_weed'), 4000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        FreezeEntityPosition(ped, false)
        QBCore.Functions.TriggerCallback('sp-runs:server:PackageGoods', function(result)
            if not result then return end
            waitingForPackage = true
            QBCore.Functions.Notify(_U('wait_closeby'), 'primary', 2500)
    
            packageZone = CircleZone:Create(Shared.WeedRunStart.xyz, 10.0, {
                name = 'weedrunning_start',
                debugPoly = Shared.Debug
            })
            
            packageZone:onPlayerInOut(function(isPointInside, point)
                if not isPointInside then
                    packageZone:destroy()
                    if waitingForPackage then
                        TriggerServerEvent('sp-runs:server:DestroyWaitForPackage')
                        waitingForPackage = false
                    end
                end
            end)
        end)
    end, function()
        QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
        FreezeEntityPosition(ped, false)
    end)
end)

RegisterNetEvent('sp-runs:client:PackageGoodsReceived', function()
    if waitingForPackage then
        packageZone:destroy()
        waitingForPackage = false
    end
end)

RegisterNetEvent('sp-runs:client:ClockIn', function()
    if delivering then return end
    delivering = true
    lib.notify({
        title = _U('weedrun_delivery_title'),
        description = _U('weedrun_delivery_waitfornew'),
        position = 'center-left',
        style = {
            backgroundColor = '#17181F',
            color = '#38a2e5',
            ['.description'] = {
              color = '#38a2e5'
            }
        },
        icon = 'fas fa-cannabis',
        iconColor = '#51CF66', duration = 5000
    })
    Wait(math.random(Shared.DeliveryWaitTime[1], Shared.DeliveryWaitTime[2]))
    createNewDropOff()
end)

RegisterNetEvent('sp-runs:client:ClockOut', function()
    if not delivering then return end
    delivering = false
    hasDropOff = false
    RemoveBlip(dropOffBlip)
    if dropOffArea then
        dropOffArea:destroy()
        DeletePed(deliveryPed)
	    deliveryPed = nil
    end
    QBCore.Functions.Notify(_U('weedrun_clockout'), 'primary', 2500)
end)

RegisterNetEvent('sp-runs:client:DeliverWeed', function()
    if madeDeal then return end

    if not hasPackage then
        QBCore.Functions.Notify(_U('weedrun_hasnopackage'), 'error', 2500)
        return
    end

    local ped = PlayerPedId()
	if not IsPedOnFoot(ped) then return end
	if #(GetEntityCoords(ped) - GetEntityCoords(deliveryPed)) < 5.0 then
		madeDeal = true
        local netId = NetworkGetNetworkIdFromEntity(deliveryPed)
        exports.ox_target:removeEntity(netId, { 'PedsDelivery' })

        Citizen.CreateThread(function()
            Wait(10000)
            exports.ox_target:removeEntity(netId, { 'PedsDelivery' })
        end)
		-- Alert Cops
		if math.random(100) <= Shared.CallCopsChance then
            if GetResourceState(Shared.Dispatch) == 'started' then
                exports[Shared.Dispatch]:DrugSale()
            end
        end
        
        -- Face each other
        FreezeEntityPosition(ped, true)
		TaskTurnPedToFaceEntity(deliveryPed, ped, 1.0)
		TaskTurnPedToFaceEntity(ped, deliveryPed, 1.0)
    PlayAmbientSpeech1(ped, 'Generic_Hi', 'Speech_Params_Force')
        Wait(1500)
	PlayAmbientSpeech1(deliveryPed, 'Generic_Hi', 'Speech_Params_Force')
        Wait(1000)
		TriggerServerEvent('sp-runs:server:WeedrunDelivery')
		
		-- deliveryPed animation
		PlayAmbientSpeech1(deliveryPed, 'Chat_State', 'Speech_Params_Force')
        Wait(500)
		RequestAnimDict('mp_safehouselost@')
		while not HasAnimDictLoaded('mp_safehouselost@') do Wait(0) end
		TaskPlayAnim(deliveryPed, 'mp_safehouselost@', 'package_dropoff', 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        Wait(3000)

		-- Finishing up
        FreezeEntityPosition(ped, false)
		RemoveBlip(dropOffBlip)
		dropOffBlip = nil
		dropOffArea:destroy()
        Wait(2000)
        lib.notify({
            title = _U('weedrun_delivery_title'),
            description = _U('weedrun_delivery_success'),
            position = 'center-left',
            style = {
                backgroundColor = '#17181F',
                color = '#38a2e5',
                ['.description'] = {
                  color = '#38a2e5'
                }
            },
            icon = 'fas fa-cannabis',
            iconColor = '#51CF66', duration = 5000
        })
        ClearPedTasks(ped)
		
        -- Delete Delivery Ped
        FreezeEntityPosition(deliveryPed, false)
        SetPedKeepTask(deliveryPed, false)
        TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
        ClearPedTasks(deliveryPed)
        TaskWanderStandard(deliveryPed, 10.0, 10)
        SetPedAsNoLongerNeeded(deliveryPed)
        Wait(20000)
        DeletePed(deliveryPed)
        deliveryPed = nil
		hasDropOff = false
		madeDeal = false

        Wait(math.random(Shared.DeliveryWaitTime[1], Shared.DeliveryWaitTime[2]))
        createNewDropOff()
	end
end)

RegisterNetEvent('sp-runs:client:scaming', function ()
    QBCore.Functions.Notify(_U('weedrun_Seriously'), "primary")
    TriggerServerEvent('sp-runs:server:scam:money')
end)