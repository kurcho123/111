Config = Config or {}

Config.JobNeeded = false -- if you need a specific job to do the deliveries true/false
Config.JobName = 'digitalera' -- Job needed to do the deliveries if the config above is set to true
Config.JobPed = 'cs_solomon' -- Model of the starting ped
Config.JobPedLocation = vector4(1137.46, -470.73, 66.66, 257.53) -- Where the starting ped is
Config.JobPedAnimation = 'WORLD_HUMAN_CLIPBOARD'
Config.JobBlipName = 'Digital Era' -- Blip of where the starting ped is

--- These should be self explanatory as its labeles as what it is
Config.JobPedBlipSprite = 304
Config.JobPedBlipSpriteColour = 32
Config.JobPedBlipSpriteScale = 0.75

Config.PaymentMethod = 'cash' -- cash/bank how the groups gets paid out at the end
--- Different levels of Reputation best to not have it to low, unless you know how to balance it out with pay etc but can be whatever number you like

Config.DisableInventory = false -- blocks the player from going in the inventory while they have the package
Config.DisableSprintingWithPackages = true
Config.DisableJumpingWithPackages = true
Config.DisableVehicleEnteringWithPackages = true
Config.DisableCrouchWithPackages = true
Config.DisableAttackingWithPackages = true
Config.DisableAimingWithPackages = true

--- THESE LOCATIONS ARE SET TO WORK WITH DEFAULT STORE LOCATIONS
Config.JobLocations = {
    [1] = { -- Do not add a 4th table unless you know what you are doing, its not as simple as just copy and pasting in here
        Coords= { -- These coords are more to the lower part of the map add as many coords as you like 
            vector3(2633.84, 2931.54, 45.63),
            vector3(148.76, -1041.24, 30.69),
            vector3(-33.64, -1088.00, 28.14),
            vector3(-42.08, -1084.67, 28.13),
            vector3(-44.61, -1749.02, 30.34),
            vector3(-33.01, -157.26, 57.91 -1),
            vector3(-33.08, -157.45, 57.95 -1),
            vector3(1159.19, -315.28, 70.04 -1),
            vector3(1217.27, -472.60, 67.06 -1),
            vector3(1209.83, -472.70, 67.33),
            vector3(-1050.94, -239.57, 45.01),
            vector3(-1082.11, -245.87, 38.66),
            vector3(312.80, -280.09, 54.96 -1),
            vector3(379.01, 332.02, 104.41 -1),
            vector3(545.14, 2663.77, 43.00 -1),
            vector3(1960.66, 3748.34, 33.14 - 1),
            vector3(1735.49, 6419.31, 35.88 -1),
            vector3(-273.90, 6226.00, 32.55 -1),
            vector3(-291.89, 6197.04, 32.48 -1),
            vector3(1863.08, 3751.29, 34.07 -1),
            vector3(319.87, 182.79, 104.62 -1),
            vector3(-1150.73, -1424.89, 5.99 -1),
            vector3(-2346.38, 3269.43, 33.80 -1),
            vector3(-2357.28, 3250.82, 102.48 -1),
            vector3(-2361.63, 3250.23, 102.22 -1),
            vector3(-2354.27, 3247.90, 102.25 -1),
            vector3(-2352.10, 3255.17, 92.90),
            vector3(-2363.31, 3248.62, 93.94 -1),
            vector3(-2357.95, 3241.19, 93.90 -1),
        },
        Payment = {--If you want a random payments then replace the number with a math.random(350, 420)
            minamount = 150,
            maxamount = 205,
        },
        Reputation = math.random(1, 3), -- Reputation given after a delivery
    },
}

Config.WarrantyStates = { -- In the mix dont touch
    [1] = { value = true, label = "In Warranty"},
    [2] = { value = false, label = "Expired"}
}

Config.TrueFalse = { true, false }

Config.RepairStages = {
    [1] = { percent = 10, label = "Със сигуност е ползвона поне 3 години...", time = 50000},
    [2] = { percent = 20, label = "Със сигуност е ползвона поне 3 години...", time = 45000},
    [3] = { percent = 30, label = "Излгежда, сякаш дете си е играло с нея...", time = 40000},
    [4] = { percent = 40, label = "Излгежда, сякаш дете си е играло с нея...", time = 35000},
    [5] = { percent = 50, label = "Някой си е оставил ръцете тук...", time = 30000},
    [6] = { percent = 60, label = "Някой си е оставил ръцете тук...", time = 25000},
    [7] = { percent = 70, label = "Използвана е доста време...", time = 20000},
    [8] = { percent = 80, label = "Използвана е доста време...", time = 15000},
    [9] = { percent = 90, label = "Че то нищо и няма...", time = 10000},
}

Config.Computers = {
    [1] = {
        IsTurnedOn = false,
        HasPassword = true,
        HacksNeeded = math.random(1, 5),
        CurrentHacks = 0,
        HasAccess = false,

        IsBeingTurnedOn = false,
        IsBeingHacked = false,

        Parts = {
            ["motherboard"] = {
                header = "Motherboard",
                label = "OG MPG Z490 GAMING PLUS", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = true,
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["cpu"] = {
                header = "Central Processing Unit",
                label = "OG Core i7-10700k", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["gpu"] = {
                header = "Graphics Processing Unit",
                label = "OG RTX 4060 Ti GAMING X 8G", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["ram"] = {
                header = "Random Access Memory",
                label = "OG VENGEANCE LPX DDR4 RAM 32GB (2x16GB) 3200MHz", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["psu"] = {
                header = "Power Supply Unit",
                label = "OG STRIX 1000W 80+ Gold Fully Modular", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["ssd"] = {
                header = "Solid State Drive",
                label = "2TB OG 970 PLUS SSD", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
        }
    },
    [2] = {
        IsTurnedOn = false,
        HasPassword = true,
        HacksNeeded = math.random(1, 5),
        CurrentHacks = 0,
        HasAccess = false,

        IsBeingTurnedOn = false,
        IsBeingHacked = false,

        Parts = {
            ["motherboard"] = {
                header = "Motherboard",
                label = "OG MPG Z690 GAMING PLUS", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = true,
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["cpu"] = {
                header = "Central Processing Unit",
                label = "OG Core i9-13900k", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["gpu"] = {
                header = "Graphics Processing Unit",
                label = "OG RTX 4090 Ti GAMING X 16G", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["ram"] = {
                header = "Random Access Memory",
                label = "OG VENGEANCE LPX DDR5 RAM 64GB (4x16GB) 4800MHz", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["psu"] = {
                header = "Power Supply Unit",
                label = "OG STRIX 1200W 80+ Platinum Fully Modular", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["ssd"] = {
                header = "Solid State Drive",
                label = "1TB OG 970 SSD", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
        }
    },
    [3] = {
        IsTurnedOn = false,
        HasPassword = true,
        HacksNeeded = math.random(1, 5),
        CurrentHacks = 0,
        HasAccess = false,

        IsBeingTurnedOn = false,
        IsBeingHacked = false,

        Parts = {
            ["motherboard"] = {
                header = "Motherboard",
                label = "OG MPG Z370 GAMING PLUS", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = true,
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["cpu"] = {
                header = "Central Processing Unit",
                label = "OG Core i3-7300k", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["gpu"] = {
                header = "Graphics Processing Unit",
                label = "OG RTX 1050 Ti GAMING X 4GB", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["ram"] = {
                header = "Random Access Memory",
                label = "OG VENGEANCE LPX DDR4 RAM 8GB (2x4GB) 2600MHz", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["psu"] = {
                header = "Power Supply Unit",
                label = "OG STRIX 500W 80+ Silver Fully Modular", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
            ["ssd"] = {
                header = "Solid State Drive",
                label = "512GB OG 670 SSD", 
                hasWarranty = Config.WarrantyStates[math.random(1, 2)],
                needsRepair = Config.TrueFalse[math.random(1, 2)],
                repairsNeeded = Config.RepairStages[math.random(1, 9)],
                isBeingRepaired = false,
                isRepaired = false,
            },
        }
    }
}