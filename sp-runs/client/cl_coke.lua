local SPCore = exports['qb-core']:GetCoreObject()

local hasPackage = false
local collectSupplyId = 0
local cocaLeavesId = 0
local chemicalsId = 0
local ingredientsId = 0
local radiusBlip = nil

-- Functions
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

function CancelJob()
    TriggerServerEvent("sp-runs:server:coke:end-job")
end

function CanStartMission()
    local jobData, groupId = lib.callback.await('sp-runs:server:coke:get-job-data', false)
    local canStart = true

    for k, v in pairs(jobData.Roles) do
        if v == 0 then
            canStart = false
        end
    end

    return canStart
end

-- Events
RegisterNetEvent("sp-runs:coke:client:select-roles", function(MembersInfo)
    local membersMenu = {
        id = 'members-menu',
        title = 'Set Roles',
        onExit = CancelJob,
        options = {}
    }
    local currentPlayer = GetPlayerServerId(PlayerId())

    for k, v in pairs(MembersInfo) do 
        table.insert(membersMenu.options, {
            title = v.name .. (currentPlayer == v.playerId and " (You)" or ""),
            description = 'Current Role: ' .. v.role,
            icon = 'person',
            event = 'sp-runs:coke:client:select-member-role',
            arrow = true,
            args = v
        })
    end

    table.insert(membersMenu.options, {
        title = "Start Mission",
        icon = 'circle-play',
        serverEvent = 'sp-runs:coke:server:start-job',
        disabled = not CanStartMission(),
        arrow = true,
    })

    lib.registerContext(membersMenu)
    lib.showContext('members-menu')
end)

RegisterNetEvent("sp-runs:coke:client:select-member-role", function(memberInfo)    
    local currentPlayer = GetPlayerServerId(PlayerId())
    local rolesMenu = {
        id = 'roles-menu',
        title = 'Set Role - ' .. memberInfo.name .. (currentPlayer == memberInfo.playerId and " (You)" or ""),
        canClose = false,
        options = {
            {
                title = "Supplier",
                description = 'The person does all of the supplying.',
                icon = 'box',
                serverEvent = 'sp-runs:coke:server:select-member-role',
                arrow = true,
                args = {
                    id = memberInfo.playerId,
                    role = "Supplier"
                }
            },
            {
                title = "Instructor",
                description = 'The person does all of the reading of instructions to the chemist and mixer.',
                icon = 'person-chalkboard',
                serverEvent = 'sp-runs:coke:server:select-member-role',
                arrow = true,
                args = {
                    id = memberInfo.playerId,
                    role = "Instructor"
                }
            },
            {
                title = "Mixer",
                description = 'The person does all of the mixing of supplies.',
                icon = 'blender',
                serverEvent = 'sp-runs:coke:server:select-member-role',
                arrow = true,
                args = {
                    id = memberInfo.playerId,
                    role = "Mixer"
                }
            },
            {
                title = "Chemist",
                description = 'The person does all of the mixing of dangerous chemicals.',
                icon = 'flask-vial',
                serverEvent = 'sp-runs:coke:server:select-member-role',
                arrow = true,
                args = {
                    id = memberInfo.playerId,
                    role = "Chemist"
                }
            },
        }
    }


    lib.registerContext(rolesMenu)
    lib.showContext('roles-menu')
end)

RegisterNetEvent("sp-runs:coke:client:start-job", function(JobData)
    collectSupplyId = exports.ox_target:addBoxZone({
        coords = JobData.CocaineSuppliesLocation,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-box", distance = 2.5 },
            {
                label = "Collect Supplies",
                icon = "fa-solid fa-hand-holding-heart",
                distance = 2,
                canInteract = function()
                    return not hasPackage
                end,
                serverEvent = "sp-runs:coke:server:collect-supply"
            },
        }
    })
end)

RegisterNetEvent('sp-runs:coke:client:remove-supply-target', function ()
    exports.ox_target:removeZone(collectSupplyId)
end)

RegisterNetEvent("sp-runs:coke:client:add-blip-radius", function(location)
    radiusBlip = AddBlipForRadius(location , 200.0) -- you can use a higher number for a bigger zone

	SetBlipHighDetail(radiusBlip, true)
	SetBlipColour(radiusBlip, 1)
	SetBlipAlpha (radiusBlip, 128)
end)

RegisterNetEvent("sp-runs:coke:client:remove-blip-radius", function()
    RemoveBlip(radiusBlip)
end)

RegisterNetEvent("sp-runs:coke:client:coca-leaves-stage", function(JobData)
    local currentPlayer = GetPlayerServerId(PlayerId())
    cocaLeavesId = exports.ox_target:addBoxZone({
        coords = JobData.MixingCocaLeavesLocation,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-flask", distance = 2.5 },
            {
                label = "Add Coca Leaves",
                icon = "fa-solid fa-clipboard",
                distance = 2,
                canInteract = function()
                    return currentPlayer == JobData.Roles["Supplier"]
                end,
                serverEvent = "sp-runs:coke:server:add-coca-leaves"
            },
        }
    })
end)

RegisterNetEvent("sp-runs:coke:client:coca-leaves-mixing-stage", function(JobData)
    local currentPlayer = GetPlayerServerId(PlayerId())
    cocaLeavesId = exports.ox_target:addBoxZone({
        coords = JobData.MixingCocaLeavesLocation,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-flask", distance = 2.5 },
            {
                label = "Read Instructions",
                icon = "fa-solid fa-clipboard",
                distance = 2,
                canInteract = function()
                    return currentPlayer == JobData.Roles["Instructor"]
                end,
                event = "sp-runs:coke:client:coca-leaves-mixing-view-number"
            },
            {
                label = "Mix Coca Leaves",
                icon = "fa-solid fa-blender",
                distance = 2,
                canInteract = function()
                    return currentPlayer == JobData.Roles["Mixer"]
                end,
                event = "sp-runs:coke:client:coca-leaves-mixing-enter-number"
            },
        }
    })
end)

RegisterNetEvent('sp-runs:coke:client:remove-coca-leaves-target', function ()
    exports.ox_target:removeZone(cocaLeavesId)
end)

RegisterNetEvent("sp-runs:coke:client:coca-leaves-mixing-view-number", function()
    local jobData, groupId = lib.callback.await('sp-runs:server:coke:get-job-data', false)

    if not jobData.CocaLeavesNumberAlreadySeen then
        local alert = lib.alertDialog({
            header = 'WARNING',
            content = 'After confirming you will see a number on your screen for 3 seconds. \nYou will be able to see this number only once!',
            centered = true,
            cancel = false
        })

        if alert == "confirm" then
            exports['sp-minigame']:ShowNumber(jobData.CocaLeavesNumber, 3000)
            TriggerServerEvent("sp-runs:coke:server:coca-leaves-mixing-view-number-disabled")
        end
    else
        SPCore.Functions.Notify("You have already seen the number.", "error", 3000)
    end
end)

RegisterNetEvent("sp-runs:coke:client:coca-leaves-mixing-enter-number", function()
    local jobData, groupId = lib.callback.await('sp-runs:server:coke:get-job-data', false)

    if jobData.CocaLeavesNumberAlreadySeen then
        local success = exports['sp-minigame']:KeyPad(jobData.CocaLeavesNumber, 3000)
        if success then
            TriggerServerEvent("sp-runs:coke:server:coca-leaves-mixing-done")
        else
            SPCore.Functions.Notify("Try again...", "error", 3000)
        end
    else
        SPCore.Functions.Notify("Maybe first you need to check the number...", "error", 3000)
    end
end)

RegisterNetEvent("sp-runs:coke:client:chemicals-mixing-stage", function(JobData)
    local currentPlayer = GetPlayerServerId(PlayerId())

    ingredientsId = exports.ox_target:addBoxZone({
        coords = JobData.IngredientsLocation,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-flask", distance = 2.5 },
            {
                label = "View Recipe",
                icon = "fa-solid fa-clipboard",
                distance = 2,
                canInteract = function()
                    return currentPlayer == JobData.Roles["Instructor"]
                end,
                event = "sp-runs:coke:client:chemicals-mixing-view-ingredients"
            },
        }
    })

    chemicalsId = exports.ox_target:addBoxZone({
        coords = JobData.MixingChemicalsLocation,
        size = vector3(1, 1, 3),
        options = {
            { targetIcon = "fa-solid fa-flask", distance = 2.5 },
            {
                label = "Create Mixture",
                icon = "fa-solid fa-clipboard",
                distance = 2,
                canInteract = function()
                    return currentPlayer == JobData.Roles["Chemist"]
                end,
                event = "sp-runs:coke:client:chemicals-mixing-enter-ingredients"
            },
        }
    })
end)

RegisterNetEvent('sp-runs:coke:client:remove-chemicals-mixing-target', function ()
    exports.ox_target:removeZone(ingredientsId)
    exports.ox_target:removeZone(chemicalsId)
end)

RegisterNetEvent("sp-runs:coke:client:chemicals-mixing-view-ingredients", function()
    local jobData, groupId = lib.callback.await('sp-runs:server:coke:get-job-data', false)

    if not jobData.IngredientsAlreadySeen then
        local alert = lib.alertDialog({
            header = 'Mixture Recipe',
            content = 'Coca Extract: ' .. jobData.Ingredients["Coca Extract"] .. '\nMethanol: ' .. jobData.Ingredients["Methanol"] .. '\nSulfuric Acid: ' .. jobData.Ingredients["Sulfuric Acid"] .. '\nAcetone: ' .. jobData.Ingredients["Acetone"],
            centered = true,
            cancel = false
        })

        if alert == "confirm" then
            TriggerServerEvent("sp-runs:coke:client:chemicals-mixing-disabled-ingredients")
        end
    else
        SPCore.Functions.Notify("You have already seen the recipe.", "error", 3000)
    end
end)

RegisterNetEvent("sp-runs:coke:client:chemicals-mixing-enter-ingredients", function()
    local jobData, groupId = lib.callback.await('sp-runs:server:coke:get-job-data', false)

    if jobData.IngredientsAlreadySeen then
        local input = lib.inputDialog('Recipe', {
            {type = 'number', label = 'Coca Extract', description = 'Amount of Coca Extract needed (ml)', icon = 'fa-solid fa-flask', required = true},
            {type = 'number', label = 'Methanol', description = 'Amount of Methanol needed (ml)', icon = 'fa-solid fa-flask', required = true},
            {type = 'number', label = 'Sulfuric Acid', description = 'Amount of Sulfuric Acid needed (ml)', icon = 'fa-solid fa-flask', required = true},
            {type = 'number', label = 'Acetone', description = 'Amount of Acetone needed (ml)', icon = 'fa-solid fa-flask', required = true},
        })

        if not input then return end

        local isRecipeRight = true
        if input[1] ~= jobData.Ingredients["Coca Extract"] or input[2] ~= jobData.Ingredients["Methanol"] or input[3] ~= jobData.Ingredients["Sulfuric Acid"] or input[4] ~= jobData.Ingredients["Acetone"] then
            isRecipeRight = false
        end
        
        if isRecipeRight then
            TriggerServerEvent("sp-runs:coke:server:chemicals-mixing-done")
        else
            SPCore.Functions.Notify("Try again...", "error", 3000)
        end
    else
        SPCore.Functions.Notify("Maybe first you need to check the number...", "error", 3000)
    end
end)

RegisterNetEvent("sp-runs:coke:client:clean-everything", function()
    collectSupplyId = 0
    cocaLeavesId = 0
    chemicalsId = 0
    ingredientsId = 0
    radiusBlip = nil
end)

-- NPC Talking Events
RegisterNetEvent("sp-runs:client:coke:spawn-npc-killers", function()
    -- TODO: Spawn npcs with weapons around the coordinated of the npc and target the player
end)

-- Box carrying threads
function HasBoxItems()
    local count = exports.ox_inventory:Search('count', 'coke-box')

    if count >= 1 then
        return true, Coke.PackageInfo
    else
        return false
    end
end

CreateThread(function()
    while true do
        if LocalPlayer.state['isLoggedIn'] then
            local player = PlayerPedId()
            local package, packagesData = HasBoxItems()
            if package then
                if not hasPackage then
                    deliveryItem = package
                    hasPackage = true
                    CreateandAnimate(packagesData)
                end
            elseif hasPackage then
                hasPackage = false
                DeleteEntity(DeliveryBox)
                ClearPedTasks(player)
            end
        end
        Wait(1000)
    end
end)

function CreateandAnimate(packagesData)
    local player = PlayerPedId()
    local animDict = 'anim@heists@box_carry@'
    local animName = 'idle'
    LoadAnim(animDict)
    TaskPlayAnim(player, animDict, animName, 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    local x, y, z = table.unpack(GetEntityCoords(player))
    SPCore.Functions.LoadModel(packagesData.name)
    DeliveryBox = CreateObject(packagesData.name, x, y, z, true, true, true)
    AttachEntityToEntity(DeliveryBox, player, GetPedBoneIndex(player, 28422), packagesData.placement.x,packagesData.placement.y,packagesData.placement.z,packagesData.placement.xrot,
    packagesData.placement.yrot, packagesData.placement.zrot, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(DeliveryBox)
    CarryAnimation(animDict, animName)
    DisableControls()
end

function DisableControls()
    CreateThread(function ()
        while hasPackage do
            DisableControlAction(0, 21, Config.DisableSprintingWithPackages) -- Sprinting
            DisableControlAction(0, 22, Config.DisableJumpingWithPackages) -- Jumping
            DisableControlAction(0, 23, Config.DisableVehicleEnteringWithPackages) -- Vehicle Entering
            DisableControlAction(0, 36, Config.DisableCrouchWithPackages) -- Ctrl
            DisableControlAction(0, 24, Config.DisableAttackingWithPackages) -- Disable Attack
            DisableControlAction(0, 25, Config.DisableAimingWithPackages) -- Disable Aim
            Wait(1)
        end
    end)
end

function CarryAnimation(animDict, animName)
    local player = PlayerPedId()
    CreateThread( function ()
        while hasPackage do
            if not IsEntityPlayingAnim(player, animDict, animName, 3) then
                TaskPlayAnim(player, animDict, animName, 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end