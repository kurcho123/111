local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for _, v in pairs(QBCore.Shared.Vehicles) do
        local text
        if v.brand then
            text = v.brand..' '..v.name
        else
            text = v.name
        end
        if v.hash and v.hash ~= 0 then
            AddTextEntryByHash(v.hash, text)
        end
    end
end)

-- Traiiinsss
-- Citizen.CreateThread(function()
-- 	SwitchTrainTrack(0, true) 					-- Main train track(s) around LS and towards Sandy Shores 
-- 	SwitchTrainTrack(3, true) 					-- Metro tracks 
-- 	SetTrainTrackSpawnFrequency(0, 120000)		-- The Train spawn frequency set for the game engine 
-- 	SetTrainTrackSpawnFrequency(3, 120000)		-- The Metro spawn frequency set for the game engine 
-- 	SetRandomTrains(true)						-- Telling the game we want to use randomly spawned trains end)
-- end)
