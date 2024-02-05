QBCore = exports['qb-core']:GetCoreObject()
Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local isCarrying = false
local beingCarried = false

RegisterCommand('carry', function()
	TriggerEvent('carry:Event')
end)

RegisterNetEvent('carry:Event')
AddEventHandler('carry:Event', function(otherPlayer)
	loadAnim('anim@heists@box_carry@')
	local t, distance = QBCore.Functions.GetClosestPlayer()
	if(distance ~= -1 and distance < 3 and not beingCarried and HasEntityClearLosToEntity( GetPlayerPed(t), PlayerPedId(), 17 ) and not IsPedInAnyVehicle(GetPlayerPed(t)) and not IsPedInAnyVehicle(PlayerPedId())) then
		if isCarrying then
			isCarrying = false
			TriggerServerEvent('undragTarget', GetPlayerServerId(t))
			ClearPedTasksImmediately(PlayerPedId())
		else
			isCarrying = true
			TriggerServerEvent('dragTarget', GetPlayerServerId(t))
			TaskPlayAnim(GetPlayerPed(PlayerId()), 'anim@heists@box_carry@', 'idle', 1.0, 1.0, -1, 49, 0, 0, 0, 0)
		end
	end
end)

RegisterNetEvent('anims:doCarry')
AddEventHandler('anims:doCarry', function(otherPlayer)
	loadAnim('idamb@code_human_in_car_idles@generic@ps@base')
	loadAnim('anim@heists@box_carry@')
	if IsEntityAttachedToEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer))) then
		DetachEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer)), true)
		ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
		beingCarried = false
		TriggerServerEvent("qb-carry:beingCarried", beingCarried)
	else
		AttachEntityToEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer)), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28252), 0.350, 0.15, -0.15, -42.50, -22.50, 22.50, 1, 1, 0, 1, 0, 1)
		TaskPlayAnim(GetPlayerPed(PlayerId()), 'idamb@code_human_in_car_idles@generic@ps@base', 'base', 8.0, -1, -1, 1, 1, 0, 0, 0)
		beingCarried = true
		TriggerServerEvent("qb-carry:beingCarried", beingCarried)
	end
end)

RegisterNetEvent('dragPlayer')
AddEventHandler('dragPlayer', function(closestID)
	local tPed = GetPlayerPed(GetPlayerFromServerId(closestID))
	local pP = PlayerPedId()
	loadAnim("amb@code_human_in_car_idles@generic@ps@base")
	TaskPlayAnim(pP, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
	AttachEntityToEntity(pP, tPed, GetPedBoneIndex(tPed, 28252), 0.350, 0.15, -0.15, -42.50, -22.50, 22.50, true, true, false, true, 1, true)
	beingCarried = true
	TriggerServerEvent("qb-carry:beingCarried", beingCarried)
end)

RegisterNetEvent('undragPlayer')
AddEventHandler('undragPlayer', function(closestID)
 ClearPedTasksImmediately(PlayerPedId())
 beingCarried = false
 DetachEntity(PlayerPedId(), true, false)
 TriggerServerEvent("qb-carry:beingCarried", beingCarried)
end)

RegisterNetEvent('carry:pedEvent')
AddEventHandler('carry:pedEvent', function()
	loadAnim('idamb@code_human_in_car_idles@generic@ps@base')
	loadAnim('anim@heists@box_carry@')
	local closestPed = getNPC()
	if closestPed then
		if IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
			DetachEntity(closestPed, GetPlayerPed(PlayerId()), true)
			ClearPedTasksImmediately(closestPed)
			ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
		else
			local closestPed = getNPC()
			TaskPlayAnim(closestPed, 'idamb@code_human_in_car_idles@generic@ps@base', 'base', 8.0, -1, -1, 1, 1, 0, 0, 0)
			AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
			TaskPlayAnim(GetPlayerPed(PlayerId()), 'anim@heists@box_carry@', 'idle', 1.0, -1, -1, 50, 0, 0, 0, 0)
		end
	end
end)

function getNPC()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local handle, ped = FindFirstPed()
	local success
	local rped = nil
	local distanceFrom
	repeat
	local pos = GetEntityCoords(ped)
	local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
	if canPedBeUsed(ped) and distance < 3.0 and (distanceFrom == nil or distance < distanceFrom) then
		distanceFrom = distance
		rped = ped
		SetEntityAsMissionEntity(rped, true, true)
	end
	success, ped = FindNextPed(handle)
	until not success
	EndFindPed(handle)
	return rped
end

function canPedBeUsed(ped)
	if ped == nil then return false end
	if ped == PlayerPedId() then return false end
	if not DoesEntityExist(ped) then return false end
	if not IsPedOnFoot(ped) then return false end
	if IsEntityDead(ped) then return false end
	if not IsPedHuman(ped) then return false end
	return true
end

function loadAnim(anim)
	RequestAnimDict(anim)
	while not HasAnimDictLoaded(anim) do
		Wait(1)
	end
end

-- Nearest Players
function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end

GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, player)
    end
    return players
end

-- Trunk
local isInTrunk = false
RegisterCommand('trunkkidnap', function(source, args, rawCommand)
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		if isCarrying then
			TriggerServerEvent('putIntoVehicle', GetPlayerServerId(t))
			ClearPedTasksImmediately(PlayerPedId())
		end
	end
end)

CreateThread(function()
	while true do
		Wait(5)
		if isInTrunk then
			DisableControlAction(0, 21, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 327, true)
			DisableControlAction(0, 323, true)
			DisableControlAction(0, Keys['TAB'], true)
			DisableControlAction(0, Keys['1'], true)
			DisableControlAction(0, Keys['2'], true)
			DisableControlAction(0, Keys['3'], true)
			DisableControlAction(0, Keys['4'], true)
			DisableControlAction(0, Keys['5'], true)
			DisableControlAction(0, Keys['6'], true)
			DisableControlAction(0, Keys['F1'], true)
			DisableControlAction(0, Keys['F2'], true)
			DisableControlAction(0, Keys['F5'], true)
			DisableControlAction(0, Keys['F6'], true)
			DisableControlAction(0, Keys['F7'], true)
			DisableControlAction(0, Keys['F8'], true)
			DisableControlAction(0, Keys['F5'], true)
			DisableControlAction(0, Keys['F9'], true)
			DisableControlAction(0, Keys['X'], true)
			DisableControlAction(0, Keys['M'], true)
		end
		if beingCarried then
			DisableControlAction(0, 21, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 327, true)
			DisableControlAction(0, 323, true)
			DisableControlAction(0, Keys['TAB'], true)
			DisableControlAction(0, Keys['1'], true)
			DisableControlAction(0, Keys['2'], true)
			DisableControlAction(0, Keys['3'], true)
			DisableControlAction(0, Keys['4'], true)
			DisableControlAction(0, Keys['5'], true)
			DisableControlAction(0, Keys['6'], true)
			DisableControlAction(0, Keys['F1'], true)
			DisableControlAction(0, Keys['F2'], true)
			DisableControlAction(0, Keys['F5'], true)
			DisableControlAction(0, Keys['F6'], true)
			DisableControlAction(0, Keys['F7'], true)
			DisableControlAction(0, Keys['F8'], true)
			DisableControlAction(0, Keys['F5'], true)
			DisableControlAction(0, Keys['F9'], true)
			DisableControlAction(0, Keys['X'], true)
			DisableControlAction(0, Keys['M'], true)
		end
		if isCarrying then
			EnableAllControlActions(0)
			DisableControlAction(0, 21, true)
		end
	end
end)