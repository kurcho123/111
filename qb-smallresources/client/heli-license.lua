local QBCore = exports['qb-core']:GetCoreObject()

local oldveh = nil
local turbulence = 0.7
local roll = 0.4

local failureChance = 5 --in %

local inAircraft = false

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsIn(ped, false)
			-- if oldveh == nil or veh ~= oldveh then
				oldveh = veh
				if IsPedInAnyHeli(ped) then
                    local Player = QBCore.Functions.GetPlayerData()
					inAircraft = true
                    if Player.metadata.pilotlicense == true or Player.job.name == "police" then
                    else
                        SetHelicopterRollPitchYawMult(veh, turbulence)
                        SetHeliTurbulenceScalar(veh, roll)
                        TaskVehicleTempAction(ped, veh, 7, math.random(700,950)) -- turn left a bit
                        Wait(500)
                        TaskVehicleTempAction(ped, veh, 8, math.random(700,950))
                    end
				elseif IsPedInAnyPlane(ped) then
					inAircraft = true
                    if Player.metadata.pilotlicense == true or Player.job.name == "police" then
                    else
                        SetPlaneTurbulenceMultiplier(veh, turbulence)
                        TaskVehicleTempAction(ped, veh, 7, math.random(300,750)) -- turn left a bit
                        Wait(500)
                        TaskVehicleTempAction(ped, veh, 8, math.random(300,750))
                    end
				else
					inAircraft = false
				end
			-- end
			if inAircraft then
				local chance = math.random(100)
				if chance >= failureChance then
					SetVehicleEngineOn(veh, false, true, false)
				end
			end
		else
			inAircraft = false
		end
	end
end)