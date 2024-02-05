Config = {
    RentVehicle = {
        Model = "nkrhineharttaxi", -- vehicle model (spawn code)
        Price = 200, -- price for rent
        SpawnLocation = {
            x = 916.7601,
            y = -170.5526,
            z = 74.0686,
            heading = 102.4279
        },
        Time = 300, -- for how long player can be out of vehicle in order not to stop the job
    },
    PricePerMeter = 0.05,
    NPC_Reward = 100, -- reward for driving npcs (government order)
    CompanyPrice = 500000,
    
    Target = {
        PedCoords = vector4(885.2797, -177.6391, 74.7003, 233.7115),
        ped = "a_m_y_business_03",
        distance = 5
    },

    NeedJob = false,
    JobName = "taxi", -- only if Config.NeedJob is true

    TakeCut = true -- should Taxi Company (boss) take cut from the driver ([Config.Price / 2] & [Config.NPC_Reward / 2]) - if false, boss menu has no function
}

function giveVehicleKeys(vehicle)
    TriggerEvent("qb-vehiclekeys:client:AddKeys", GetVehicleNumberPlateText(vehicle))
end