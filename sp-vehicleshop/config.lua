Config = {}
Config.UseTarget = true --GetConvar('UseTarget', 'false') == 'true'
Config.Debug = true

Config.PlateLetters  = 4
Config.PlateNumbers  = 4
Config.PlateUseSpace = false

Config.SpawnVehicle = true  -- TRUE if you want spawn vehicle when purchased (If set to false, MAKE SURE to provide a garage in the shop's config)
Config.FuelSystem = "cdn-fuel"

Config.BlacklistedVehicles = { -- These vehicles won't show up in the shop
    ['akula'] = true,
    ['alkonost'] = true,
    ['annihilator'] = true,
    ['annihilator2'] = true,
    ['apc'] = true,
    ['ardent'] = true,
    ['avenger'] = true,
    ['barrage'] = true,
    ['blazer5'] = true,
    ['bombushka'] = true,
    ['boxville5'] = true,
    ['bruiser'] = true,
    ['brutus'] = true,
    ['buffalo4'] = false,
    ['buzzard'] = true,
    ['buzzard2'] = true,
    ['caracara'] = true,
    ['cerberus'] = true,
    ['cerberus2'] = true,
    ['cerberus3'] = true,
    ['champion'] = true,
    ['chernobog'] = true,
    ['comet4'] = false,
    ['deathbike'] = true,
    ['deity'] = false,
    ['deluxo'] = true,
    ['dinghy5'] = true,
    ['dominator4'] = true,
    ['dune3'] = true,
    ['granger2'] = false,
    ['halftrack'] = true,
    ['hunter'] = true,
    ['hydra'] = true,
    ['impaler2'] = true,
    ['impaler3'] = true,
    ['imperator'] = true,
    ['insurgent'] = true,
    ['insurgent3'] = true,
    ['issi4'] = true,
    ['jb7002'] = true,
    ['jet'] = true,
    ['jubilee'] = false,
    ['khanjali'] = true,
    ['kosatka'] = true,
    ['lazer'] = true,
    ['limo2'] = true,
    ['menacer'] = true,
    ['microlight'] = true,
    ['minitank'] = true,
    ['mogul'] = true,
    ['molotok'] = true,
    ['monster3'] = true,
    ['mule4'] = true,
    ['nightshark'] = true,
    ['nokota'] = true,
    ['oppressor'] = true,
    ['oppressor2'] = true,
    ['paragon2'] = true,
    ['patriot3'] = false,
    ['patrolboat'] = true,
    ['pounder2'] = true,
    ['pyro'] = true,
    ['rcbandito'] = true,
    ['revolter'] = true,
    ['rhino'] = true,
    ['rogue'] = true,
    ['ruiner2'] = true,
    ['savage'] = true,
    ['savestra'] = true,
    ['scarab'] = true,
    ['scarab2'] = true,
    ['scarab3'] = true,
    ['scramjet'] = true,
    ['seabreeze'] = true,
    ['seasparrow2'] = true,
    ['seasparrow3'] = true,
    ['slamvan4'] = true,
    ['speedo4'] = true,
    ['starling'] = true,
    ['strikeforce'] = true,
    ['stromberg'] = true,
    ['tampa3'] = true,
    ['technical'] = true,
    ['technical2'] = true,
    ['technical3'] = true,
    ['terbyte'] = true,
    ['thruster'] = true,
    ['titan'] = true,
    ['toreador'] = true,
    ['trailerlarge'] = true,
    ['trailersmall2'] = true,
    ['tula'] = true,
    ['valkyrie'] = true,
    ['vigilante'] = true,
    ['viseris'] = true,
    ['volatol'] = true,
    ['zr380'] = true,

    -- OTHER
    ['firetruk'] = true,
    ['ambulance'] = true,
    ['blimp'] = true,
    ['blimp2'] = true,
    ['blimp3'] = true,

    ['frogger'] = true,
    ['swift'] = true,
    ['cargobob'] = true,
    ['dune2'] = true,
    ['monster'] = true,
    ['polmav'] = true,
    ['policeb'] = true,

    ['seasparrow'] = true,
    ['havok'] = true,
    ['volatus'] = true,
    ['supervolito'] = true,
    ['supervolito2'] = true,

    ['riot2'] = true,
    ['voltic2'] = true,

    ['airtug'] = true,
    ['camper'] = true,
    ['luxor'] = true,
    ['luxor2'] = true,
    ['maverick'] = true,
    ['mule'] = true,
    ['rrocket'] = true,
    ['shamal'] = true,
}

Config.LimitQuantityVehicles = { -- These vehicles will be limited to the number set (This is only temporary, after the resource is restarted, it returns to its original amount)
    --["blista"] = 1, -- vehicle/quantity
}

Config.PriceDiscount = {
    --["blista"] = 1500 -- vehicle/price change (a positive number adds to the base value, while a negative number removes from the base value qb-core/shared/vehicles.lua)
}

Config.Shops = {
    ['pdm'] = { -- The Shop identifier.
        garage = "Legion Square", -- Value is not required. Used to set primary garage after purchase
        coord = vector4(-31.24, -1097.71, 27.27 - 1, 70.29), -- used for the NPC and blip
        target = { -- Table is REQUIRED if Config.UseTarget is true
            -- For peds
            usePed = true, -- if you want to use a ped instead of a boxzone
            pedModel = `a_m_m_indian_01`, -- the ped model
            pedAnimation = "", -- the ped animation (not required)
            -- For boxzones
            length = 1,
            width = 1,
            minZ = 26.42,
            maxZ = 27.42,
            debugPoly = false,
            -- For both
            distance = 2.5,
            properties = {
                icon = "fas fa-car",
                label = "Purchase a Vehicle",
                job = "" -- if you want to set the interaction of the taget to a job. Can be job = "police" or job = {["police"] = 0, ["ambulance"] = 2}
            }
        },
        setupStore = { -- Table is REQUIRED
            allowTestDrive = { -- Table is not required
                spawnTestLoc = vector4(-11.87, -1080.87, 25.71, 132.0), -- Where the test vehicle will spawn
                testDriveTime = 30 -- in seconds
            },
            spawnPurchaseLoc = vector4(-53.73, -1117.08, 26.05, 336.75), -- where a purchased vehicle will spawn
            shopVehicleLoc = vector4(-47.52, -1092.04, 26.68, 276.57), -- where the preview vehicle will spawn
            shopCameraLoc = {-49.14, -1086.14, 29.88, 193.62, 0.0, 0.0} --posx,posy,poz,rotx,roty,rotz | this is where the camera will be
        },
        showVehicles = { -- Table is not required
            [1] = {model = `comet2`, location = vector4(-37.03, -1093.22, 26.84 - 0.5, 184.59)},
            [2] = {model = `elegy2`, location = vector4(-54.74, -1096.69, 26.59 - 0.5, 192.01)},
            [3] = {model = `tempesta`, location = vector4(-50.12, -1083.64, 26.64 - 0.5, 249.20)},
            [4] = {model = `blista`, location = vector4(-42.36, -1101.08, 27.03 - 0.5, 197.97)},
        }
    },
    ['boats'] = {
        garage = "lsymc",
        coord = vector4(-736.53, -1327.26, 1.6-1, 9.93),
        target = {usePed = false, pedModel = `a_m_m_indian_01`, pedAnimation = "", length = 1, width = 1, minZ = 26.42, maxZ = 27.42, debugPoly = false, distance = 2.5,
            properties = {icon = "fas fa-car", label = "Purchase a Vehicle", job = ""}},
        setupStore = {
            allowTestDrive = {spawnTestLoc = vector4(-722.23, -1351.98, 0.14, 135.33), testDriveTime = 90},
            spawnPurchaseLoc = vector4(-727.87, -1353.1, -0.17, 137.09), shopVehicleLoc = vector4(-884.46, -1360.36, 0.0, 90.76), shopCameraLoc = {-880.46, -1376.26, 4.0, -100.76, 0.0, 0.0}},
        showVehicles = {
            [1] = {model = `seashark`, location = vector4(-727.05, -1326.59, 0.00, 229.5)},
            [2] = {model = `dinghy`, location = vector4(-732.84, -1333.5, -0.50, 229.5)},
            [3] = {model = `speeder`, location = vector4(-737.84, -1340.83, -0.50, 229.5)},
            [4] = {model = `marquis`, location = vector4(-741.53, -1349.7, -2.00, 229.5)},
        },
    },
    ['air'] = {
        garage = "intairport",
        coord = vector4(-1622.43, -3154.02, 13.99-1, 52.81),
        target = {usePed = false, pedModel = `a_m_m_indian_01`, pedAnimation = "", length = 1, width = 1, minZ = 26.42, maxZ = 27.42, debugPoly = false, distance = 2.5,
            properties = {icon = "fas fa-car", label = "Purchase a Vehicle", job = ""}},
        setupStore = {
            allowTestDrive = {spawnTestLoc = vector4(-1625.19, -3103.47, 13.94, 330.28), testDriveTime = 90},
            spawnPurchaseLoc = vector4(-1650.84, -3140.54, 13.99, 328.23), shopVehicleLoc = vector4(-1647.82, -3135.33, 13.99, 331.9), shopCameraLoc = {-1635.82, -3123.33, 18.99, 331.9, 0.0, 0.0}},
        showVehicles = {
            [1] = {model = `nimbus`, location = vector4(-1651.36, -3162.66, 12.99, 346.89)},
            [2] = {model = `luxor2`, location = vector4(-1668.53, -3152.56, 12.99, 303.22)},
            [3] = {model = `volatus`, location = vector4(-1632.02, -3144.48, 12.99, 31.08)},
            [4] = {model = `frogger`, location = vector4(-1663.74, -3126.32, 12.99, 275.03)},
        },
    },
    ['truck'] = {
        coord = vector4(900.45, -1155.58, 25.16-1, 175.08),
        target = {usePed = false, pedModel = `a_m_m_indian_01`, pedAnimation = "", length = 1, width = 1, minZ = 26.42, maxZ = 27.42, debugPoly = false, distance = 2.5,
            properties = {icon = "fas fa-car", label = "Purchase a Vehicle", job = ""}},
        setupStore = {
            allowTestDrive = {spawnTestLoc = vector4(867.65, -1192.4, 25.37, 95.72), testDriveTime = 30},
            spawnPurchaseLoc = vector4(909.35, -1181.58, 25.55, 177.57), shopVehicleLoc = vector4(886.89, -1237.79, 25.98, 303.82), shopCameraLoc = {880.36, -1227.97, 29.18, 182.48, 0.0, 0.0}},
        showVehicles = {
            [1] = {model = `hauler`, location = vector4(890.84, -1170.92, 25.08, 269.58)},
            [2] = {model = `phantom`, location = vector4(878.45, -1171.04, 25.05, 273.08)},
            [3] = {model = `mule`, location = vector4(880.44, -1163.59, 24.87, 273.08)},
            [4] = {model = `mixer`, location = vector4(896.95, -1162.62, 24.98, 273.08)},
        },
    },
}