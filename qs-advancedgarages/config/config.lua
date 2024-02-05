--[[
    Welcome to the qs-advancedgarages configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/information/welcome
]]

Config = Config or {}
Locales = Locales or {}

--░██████╗░░█████╗░██████╗░░█████╗░░██████╗░███████╗░██████╗
--██╔════╝░██╔══██╗██╔══██╗██╔══██╗██╔════╝░██╔════╝██╔════╝
--██║░░██╗░███████║██████╔╝███████║██║░░██╗░█████╗░░╚█████╗░
--██║░░╚██╗██╔══██║██╔══██╗██╔══██║██║░░╚██╗██╔══╝░░░╚═══██╗
--╚██████╔╝██║░░██║██║░░██║██║░░██║╚██████╔╝███████╗██████╔╝
--░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═════╝░

--[[
    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!
]]

Config.Language = 'en'

--[[
    Framework configuration and tools of your server!
    Please read the usable options carefully, in case they
    are not here you can add more or modify the default ones
    in the client/custom/* and server/custom/* directories.

    In case of weather or vehiclekeys, you can select false so
    that it does not depend on either of them.

    Please choose from the following options:

    Menu:
        'esx_menu_default'
        'nh-context'
        'ox_lib'
        'qb-menu'
        'esx_context'

    Fuel:
        'qs-fuelstations'
        'LegacyFuel'
        'okokGasStation'
        'esx-sna-fuel'
        'ps-fuel'
        'lj-fuel'
        'ox_fuel'
        'ti_fuel'
        'FRFuel'
        'ND_Fuel'
        'cdn-fuel'

        'none'

    Weather:
        'cd_easytime'
        'vSync'
        'qb-weathersync'

        'none'

    Vehiclekeys:
        'qs-vehiclekeys'
        'qb-vehiclekeys'
        'vehicles_keys'
        'fivecode_carkeys'
        'stasiek_vehiclekeys'
        'xd_locksystem'
        'ti_vehicleKeys'
        'F_RealCarKeysSystem'
        'mono_carkeys'
        'glfp10_carkeys'
        'wasabi_carlock'

        'none

    UseTarget:
        'ox_target'
        'qb-radialmenu'

        'none'
]]

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'esx'

Config.Menu = 'ox_lib'
Config.Fuel = 'cdn-fuel'
Config.Weather = 'qb-weathersync'
Config.Vehiclekeys = 'qb-vehiclekeys'
Config.UseTarget = 'ox_target'

--[[
    General and visual configuration, please read each
    comment on each configuration, as it is crucial that
    you understand what you are going to modify.

    If you want the garages to be shared and have slots in
    common you can enable Config.GaragesSync, this way when you
    enter the shell (interior) you will see all the cars in that garage.
]]

Config.BlipSprites = {
    ['plane'] = {
        owned = 423,
        notOwned = 372,
        size = 0.6,
        color = 67
    },
    ['vehicle'] = {
        owned = 357,
        notOwned = 369,
        size = 0.6,
        color = 67
    },
    ['boat'] = {
        owned = 410,
        notOwned = 371,
        size = 0.6,
        color = 67
    },
    ['impound'] = {
        color = 6
    }
}

Config.TransferGaragePrice = 500       -- Price to be charged for taking out a vehicles
Config.GarageSellTax = 1.3             -- Percentage of profit that the person who creates the garage receives when it is sold (by default it is 50% of the total price)
Config.ImpoundPrice = 100              -- Impound default value to remove vehicles

Config.DisableBlips = true            -- Disable all blips or show them on your map?
Config.ShortNames = false              -- This config will shorten the names so your blips are much less
Config.startCinematic = 5              -- Cinematic Cams being AFK in the garage, it's a beautiful cinematic cam (by default it is 1.3, one and a half minutes)
Config.PlayerToVehicleAnimation = true -- Enable or disable the animation of the player entering the car
Config.SetEntityAlpha = true           -- When he saves the car, he makes animations and degrades the car
Config.GarageSync = true               -- This option will make the garages share the same number of slots and players will see all the cars inside their shell
Config.PersistentVehicles = false       -- Configure if the vehicles are persistent on the map or not
Config.PersistentVehiclesLocked = true -- When persistent vehicles appear, will they be closed or open?

Config.RepairKit = false               -- Enable or disable the 'repairkit' item

--[[
    Music system inside the garage, you can remove this
    feature using false in the Conifg.Sounds or add music
    yourself in html/sounds/, it must be in mp3 format and
    its name must not contain spaces. One of the random
    songs will come out and each player can pause it if enabled.
]]

Config.Sounds = true     -- Enable or disable the music and its Pause button
Config.SoundVolume = 0.1 -- Sound volume (we recommend 0.01-0.05 for ambient)
Config.SoundFiles = {
    'A$AP_Rocky_-_Shittin_Me',
    -- Add more in html/sounds/*.ogg
}

Config.MenuSounds = true -- The menu includes sound effects, choose whether to use them or not

--[[
    In this part we have the jobs configuration, with this you can
    create garages or even have access to the impound command to
    remove garages from the streets. You also have an administrative
    command called mdv, which allows you to delete cars as dv.
]]

Config.AllowedJobs = {
    -- 'mechanic',
    -- 'realestate',
    -- 'realestatejob'
}

Config.ImpoundJobs = {
    'police',
    -- 'sheriff'
}

--[[
    List of garages and impounds available.

    IMPORTANT: Do not change the name of the first Impound as
    that is where the player's cars will go when they go offline
    or are not using them for a long time. The impound and mdv
    command will send them there as well, so you shouldn't rename it.

    We recommend creating each garage on a test basis as the
    cinematic camera and vehicle position is a bit tricky
    to set up if you are not a developer.
]]

Config.Recovery = {
    coords = {
        vec3(408.975830, -1622.887939, 29.279907),
        vec3(944.373657, -463.318665, 61.547241),
    },
    blip = {
        sprite = 67,
        color = 6,
        scale = 0,
        name = 'Recovery',
        shortRange = true
    },
    price = 1000
}

Config.Garages = {
    --[[
        Impound Garages, don't delete all of them, you should
        at least leave one created. It is a dependency of this
        system, please do not remove all impound.
    ]]
    ['Hayes Autos'] = {
        owner = true,     -- If it is public, put false
        available = true, -- If it is public, set true
        isImpound = true, -- If it is an impound, set it to false (Only for impound zone)
        type = 'vehicle',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(483.75, -1312.29, 29.21),
            spawnCoords = vec4(488.68, -1313.91, 29.26, 294.49),
            polyzone = {
                points = {
                    vec3(398.86, -1278.41, 25.0),
                    vec3(482.58, -1341.67, 25.0),
                    vec3(514.39, -1331.06, 25.0),
                    vec3(491.67, -1268.94, 25.0)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(492.857147, -1317.085693, 28.824951, 260.787415),
            camera = {
                coords = vec3(494.162628, -1320.975830, 29.195557),
                rotation = vec3(-2.0, 2.0, 28.0),
                ped = vec4(494.729675, -1315.925293, 29.246094, 170.259842)
            }
        },
        cinematicCams = {
            vec3(495.230774, -1318.892334, 29.246094),
            vec3(492.065948, -1318.852783, 29.229248)
        }
    },
    ['Airport Impound Hangar'] = {
        owner = true,
        available = true,
        isImpound = true,
        type = 'plane',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(-1299.520874, -3407.564941, 13.929688),
            spawnCoords = vec4(-1271.512085, -3380.808838, 13.929688, 331.653534),
            polyzone = {
                points = {
                    vec3(-1240.378052, -3377.591309, 13.929688),
                    vec3(-1273.991211, -3424.958252, 13.508423),
                    vec3(-1310.386841, -3403.951660, 13.508423),
                    vec3(-1282.971436, -3353.287842, 13.508423)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(-1271.512085, -3380.822021, 13.643188, 331.653534),
            camera = {
                coords = vec3(-1273.885742, -3375.032959, 13.929688),
                rotation = vec3(-2.0, 2.0, 213.0),
                ped = vec4(-1274.268188, -3381.243896, 13.929688, -10.000000)
            }
        },
        cinematicCams = {
            vec3(-1271.973633, -3373.279053, 13.229688),
            vec3(-1273.780273, -3380.650635, 13.929688)
        }
    },
    ['Boat Impound Pier'] = {
        owner = true,
        available = true,
        isImpound = true,
        type = 'boat',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(-858.039551, -1470.685669, 1.629272),
            spawnCoords = vec4(-859.621948, -1476.909912, 0.432983, 291.968506),
            polyzone = {
                points = {
                    vec3(-852.435181, -1479.824219, 1.5),
                    vec3(-866.373596, -1484.993408, 1.5),
                    vec3(-870.487915, -1473.890137, 1.5),
                    vec3(-856.140686, -1468.483521, 1.5)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(-859.648376, -1476.923096, 0.432983, 291.968506),
            camera = {
                coords = vec3(-857.762634, -1471.569214, 1.629272),
                rotation = vec3(-10.0, 2.0, 178.0),
                ped = vec4(-867.006592, -1481.564819, 1.578735, 311.811035)
            }
        },
        cinematicCams = {
            vec3(-858.316467, -1474.628540, 1.176929),
            vec3(-864.567017, -1476.382446, 1.576929)
        }
    },

    --[[
        Garages for cars, there are multiple configured,
        you can customize them, but it requires you to
        change positions and cinematic cam.
    ]]
    ['Legion Square'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(215.446167, -809.802185, 30.728882),
            spawnCoords = vec4(232.931870, -790.087891, 29.454932, 158.740158),
            polyzone = {
                points = {
                    vec3(264.184631, -770.241760, 30.5),
                    vec3(243.956055, -823.094482, 30.5),
                    vec3(200.057144, -805.753845, 30.5),
                    vec3(218.637360, -755.195618, 30.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(251.406601, -752.479126, 34.301147, 289.133850),
            camera = {
                coords = vec3(253.793411, -749.169250, 34.421216),
                rotation = vec3(-5.0, 3.0, 168.0),
                ped = vec4(253.806595, -753.534058, 34.638062, 365.826782)
            }
        },
        cinematicCams = {
            vec3(252.817581, -750.540649, 34.421216),
            vec3(250.087921, -751.476929, 34.621216)
        }
    },
    ['Pillbox Hill Garage'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(100.99, -1071.73, 29.23),
            spawnCoords = vec4(113.87, -1071.64, 28.19, 85.48),
            polyzone = {
                points = {
                    vec3(115.53, -1027.65, 25.0),
                    vec3(79.92, -1118.56, 25.0),
                    vec3(190.15, -1116.67, 25.0),
                    vec3(195.08, -1054.17, 25.0)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(142.008789, -1081.094482, 28.487915, 56.692913),
            camera = {
                coords = vec3(141.072525, -1076.729614, 28.978711),
                rotation = vec3(-1.0, 3.0, 197.0),
                ped = vec4(139.542862, -1081.160400, 29.178711, -22.3742)
            }
        },
        cinematicCams = {
            vec3(141.098907, -1078.378052, 28.678711),
            vec3(143.169235, -1079.142822, 29.178711)
        }
    },
    ['Vinewood West'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(-338.769226, 267.428589, 85.709839),
            spawnCoords = vec4(-334.443939, 283.410980, 84.777344, 178.582672),
            polyzone = {
                points = {
                    vec3(-350.175812, 262.865936, 84.0),
                    vec3(-352.259338, 300.171417, 84.0),
                    vec3(-326.347260, 309.178040, 86.5),
                    vec3(-325.424164, 268.786804, 86.6)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-348.646149, 269.630768, 85.103271, 308.976379),
            camera = {
                coords = vec3(-348.632965, 274.048340, 85.003271),
                rotation = vec3(-2.0, 3.0, 198.0),
                ped = vec4(-346.140656, 269.643951, 85.288696, 27.007874)
            }
        },
        cinematicCams = {
            vec3(-347.670319, 272.360443, 84.704346),
            vec3(-350.940643, 270.026367, 85.019043)
        }
    },
    ['Vinewood Center'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(70.074722, 12.342858, 68.944336),
            spawnCoords = vec4(75.890114, 19.292309, 67.927490, 158.740158),
            polyzone = {
                points = {
                    vec3(55.054947, 31.476925, 70.5),
                    vec3(48.738464, 15.600001, 69.5),
                    vec3(74.953850, 4.483517, 68.6),
                    vec3(81.098907, 24.052750, 69.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(60.830769, 19.872530, 69.163330, 357.165344),
            camera = {
                coords = vec3(58.720879, 23.907694, 69.436328),
                rotation = vec3(-2.0, 3.0, 230.0),
                ped = vec4(62.479122, 21.982420, 69.500366, 76.535431)
            }
        },
        cinematicCams = {
            vec3(59.696705, 22.364838, 69.567749),
            vec3(59.076923, 18.909891, 68.898218)
        }
    },
    ['Penitentiary'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(1899.138428, 2602.852783, 45.742188),
            spawnCoords = vec4(1892.400024, 2601.349365, 44.287231, 269.291351),
            polyzone = {
                points = {
                    vec3(1922.281372, 2594.347168, 45.978027),
                    vec3(1918.430786, 2617.041748, 45.590454),
                    vec3(1883.762695, 2621.894531, 45.236572),
                    vec3(1883.723022, 2594.782471, 45.236572)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(1849.186768, 2608.773682, 45.169189, 215.433090),
            camera = {
                coords = vec3(1853.248413, 2608.219727, 45.657837),
                rotation = vec3(-8.0, 3.0, 102.0),
                ped = vec4(1848.830811, 2606.465820, 45.573608, 298.125977)
            }
        },
        cinematicCams = {
            vec3(1851.613159, 2607.718750, 44.957837),
            vec3(1849.753906, 2610.171387, 45.590454)
        }
    },
    ['Motel Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(273.705505, -344.241760, 44.916504),
            spawnCoords = vec4(285.428558, -347.894501, 43.950195, 161.574799),
            polyzone = {
                points = {
                    vec3(288.501099, -357.573639, 45.337769),
                    vec3(264.316498, -348.936249, 44.697388),
                    vec3(270.026367, -323.182404, 44.916504),
                    vec3(299.960449, -331.925262, 44.916504)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(288.804382, -346.127472, 44.427856, 354.330719),
            camera = {
                coords = vec3(286.048340, -343.556030, 44.916504),
                rotation = vec3(-8.0, 3.0, 246.0),
                ped = vec4(290.426361, -344.215393, 44.916504, 86.031494)
            }
        },
        cinematicCams = {
            vec3(287.591217, -344.254944, 45.216504),
            vec3(287.287903, -347.446167, 44.533350)
        }
    },
    ['Spanish Ave Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(-1160.347290, -740.967041, 19.675415),
            spawnCoords = vec4(-1151.973633, -749.512085, 17.929663, 223.937012),
            polyzone = {
                points = {
                    vec3(-1156.800049, -707.353821, 21.5),
                    vec3(-1109.010986, -760.285706, 21.5),
                    vec3(-1133.551636, -783.863708, 21.5),
                    vec3(-1184.624146, -731.907715, 21.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-1161.916504, -726.395630, 19.928223, 65.196854),
            camera = {
                coords = vec3(-1165.186768, -728.795593, 20.467407),
                rotation = vec3(-4.0, 3.0, 321.0),
                ped = vec4(-1161.744995, -727.846130, 20.501099, 121.889763)
            }
        },
        cinematicCams = {
            vec3(-1164.039551, -727.173645, 20.168481),
            vec3(-1162.206543, -728.808777, 20.950562)
        }
    },
    ['Little Seoul Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(-350.861542, -874.839539, 31.065918),
            spawnCoords = vec4(-357.771423, -883.226379, 29.893042, 0.000000),
            polyzone = {
                points = {
                    vec3(-336.804382, -895.186829, 31.0),
                    vec3(-363.982422, -896.821960, 31.0),
                    vec3(-363.876923, -863.182434, 31.0),
                    vec3(-334.707703, -868.905518, 31.0)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-327.151642, -911.683533, 30.509888, 243.779526),
            camera = {
                coords = vec3(-324.698914, -915.850525, 31.065918),
                rotation = vec3(-4.0, 3.0, 36.0),
                ped = vec4(-324.923065, -911.261536, 31.065918, 185.748032)
            }
        },
        cinematicCams = {
            vec3(-324.936249, -914.571411, 31.065918),
            vec3(-329.327454, -912.923096, 31.465918)
        }
    },
    ['Laguna Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(364.074738, 297.903290, 103.486450),
            spawnCoords = vec4(367.503296, 296.004395, 102.195654, 348.661407),
            polyzone = {
                points = {
                    vec3(360.593414, 306.593414, 103.385376),
                    vec3(401.432983, 290.610992, 103.385376),
                    vec3(386.413177, 251.380219, 103.385376),
                    vec3(350.558258, 273.956055, 103.385376)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(374.769226, 283.450562, 102.559692, 51.023624),
            camera = {
                coords = vec3(374.017578, 287.538452, 103.216797),
                rotation = vec3(-4.0, 3.0, 195.0),
                ped = vec4(374.637360, 285.125275, 103.199951, 19.842520)
            }
        },
        cinematicCams = {
            vec3(374.241760, 286.562653, 103.416797),
            vec3(377.643951, 284.070343, 102.532568)
        }
    },
    ['Airport Los Santos'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(-796.865906, -2024.663696, 8.874756),
            spawnCoords = vec4(-790.153870, -2022.949463, 7.719800, 56.692913),
            polyzone = {
                points = {
                    vec3(-793.964844, -2004.909912, 8.8),
                    vec3(-775.753845, -2024.571411, 8.8),
                    vec3(-786.817566, -2038.747192, 8.8),
                    vec3(-813.428589, -2025.665894, 8.8)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-761.287903, -2049.336182, 8.470337, 14.173228),
            camera = {
                coords = vec3(-758.808777, -2045.881348, 8.908447),
                rotation = vec3(-4.0, 3.0, 155.0),
                ped = vec4(-760.285706, -2048.320801, 8.908447, 342.992126)
            }
        },
        cinematicCams = {
            vec3(-759.389038, -2047.239502, 9.308447),
            vec3(-759.375793, -2049.982422, 8.908447)
        }
    },
    ['San Andreas Beach'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(-1183.226318, -1510.958252, 4.359009),
            spawnCoords = vec4(-1183.516479, -1501.912109, 3.254590, 218.267715),
            polyzone = {
                points = {
                    vec3(-1183.885742, -1516.298950, 4.3),
                    vec3(-1169.947266, -1506.435181, 4.3),
                    vec3(-1177.450562, -1492.773682, 4.3),
                    vec3(-1193.406616, -1503.507690, 4.3)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-1194.250488, -1499.221924, 3.954590, 240.944885),
            camera = {
                coords = vec3(-1189.951660, -1498.087891, 4.375854),
                rotation = vec3(-4.0, 3.0, 124.0),
                ped = vec4(-1193.525269, -1501.239502, 4.359009, 327.480316)
            }
        },
        cinematicCams = {
            vec3(-1191.731812, -1498.272583, 4.375854),
            vec3(-1194.619751, -1496.993408, 3.975854)
        }
    },
    ['The Motor Hotel'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(1142.123047, 2663.934082, 38.159668),
            spawnCoords = vec4(1137.441772, 2654.175781, 36.919409, 0.000000),
            polyzone = {
                points = {
                    vec3(1144.879150, 2667.929688, 38.5),
                    vec3(1133.090088, 2668.496826, 38.5),
                    vec3(1132.153809, 2652.619873, 38.5),
                    vec3(1142.320923, 2651.156006, 38.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(1126.166992, 2659.569336, 37.620483, 53.858269),
            camera = {
                coords = vec3(1125.890137, 2663.327393, 37.991211),
                rotation = vec3(-8.0, 3.0, 192.0),
                ped = vec4(1127.525269, 2660.215332, 37.991211, 25.000000)
            }
        },
        cinematicCams = {
            vec3(1125.138428, 2662.153809, 37.791211),
            vec3(1128.131836, 2660.822021, 37.991211)
        }
    },
    ['Alamo Sea Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 1 -- Single Garage
        },
        coords = {
            menuCoords = vec3(959.683533, 3618.975830, 32.666626),
            spawnCoords = vec4(950.703308, 3615.586914, 31.610596, 90.708656),
            polyzone = {
                points = {
                    vec3(935.446167, 3607.780273, 32.5),
                    vec3(935.367065, 3626.452637, 32.5),
                    vec3(975.046143, 3626.043945, 32.5),
                    vec3(974.571411, 3599.432861, 32.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(963.679138, 3653.736328, 31.571411, 102.047249),
            camera = {
                coords = vec3(961.239563, 3650.822021, 32.177979),
                rotation = vec3(-8.0, 3.0, -18.0),
                ped = vec4(961.529663, 3654.725342, 31.958984, 189.921265)
            }
        },
        cinematicCams = {
            vec3(962.017578, 3650.822021, 32.177979),
            vec3(964.694519, 3652.364746, 31.693750)
        }
    },
    ['Sandy Shore Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(1737.942871, 3709.199951, 34.132568),
            spawnCoords = vec4(1737.797852, 3718.839600, 32.876538, 19.842520),
            polyzone = {
                points = {
                    vec3(1748.307739, 3710.531982, 33.8),
                    vec3(1738.285767, 3733.925293, 33.8),
                    vec3(1712.703247, 3721.186768, 33.8),
                    vec3(1717.687866, 3701.156006, 33.8)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(1726.562622, 3723.639648, 33.576538, 76.535431),
            camera = {
                coords = vec3(1724.465942, 3727.859375, 33.896729),
                rotation = vec3(-4.0, 3.0, 217.0),
                ped = vec4(1727.208740, 3725.287842, 34.065186, 48.188972)
            }
        },
        cinematicCams = {
            vec3(1724.479126, 3726.263672, 34.014648),
            vec3(1729.424194, 3724.694580, 34.814648)
        }
    },
    ['Paleto Bay Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(84.725281, 6421.437500, 31.520874),
            spawnCoords = vec4(85.200005, 6427.846191, 30.214307, 45.354328),
            polyzone = {
                points = {
                    vec3(67.054947, 6421.582520, 31.318726),
                    vec3(85.542862, 6439.885742, 31.318726),
                    vec3(94.839569, 6420.962402, 31.352417),
                    vec3(79.925278, 6406.984375, 31.571411)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(88.338463, 6366.949219, 30.813232, 323.149597),
            camera = {
                coords = vec3(86.571426, 6370.667969, 31.217529),
                rotation = vec3(-4.0, 3.0, 222.0),
                ped = vec4(90.646156, 6367.477051, 31.217529, 54.015747)
            }
        },
        cinematicCams = {
            vec3(87.956047, 6369.389160, 31.217529),
            vec3(86.479126, 6366.791016, 30.717529)
        }
    },
    ['Elysian Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(204.646149, -3132.843994, 5.774414),
            spawnCoords = vec4(203.498901, -3129.336182, 4.753149, 87.874016),
            polyzone = {
                points = {
                    vec3(193.068130, -3137.604492, 5.774414),
                    vec3(193.107697, -3111.375732, 5.774414),
                    vec3(210.883514, -3112.272461, 5.774414),
                    vec3(210.975830, -3137.314209, 7.442505)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(190.404404, -3172.800049, 5.336304, 17.007874),
            camera = {
                coords = vec3(186.421982, -3172.786865, 5.774414),
                rotation = vec3(-4.0, 3.0, 285.0),
                ped = vec4(189.547256, -3173.947266, 5.774414, 73.700790)
            }
        },
        cinematicCams = {
            vec3(187.846161, -3171.942871, 5.974414),
            vec3(187.898895, -3175.160400, 5.074414)
        }
    },
    ['Airport Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(-992.281311, -2699.393311, 13.828613),
            spawnCoords = vec4(-982.325256, -2700.131836, 12.660034, 56.692913),
            polyzone = {
                points = {
                    vec3(-1000.061523, -2704.522949, 13.5),
                    vec3(-986.228577, -2680.694580, 13.5),
                    vec3(-945.599976, -2703.995605, 13.5),
                    vec3(-964.958252, -2721.600098, 13.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-1013.657166, -2691.177979, 13.339966, 215.433090),
            camera = {
                coords = vec3(-1015.674744, -2695.068115, 13.963379),
                rotation = vec3(-4.0, 3.0, 343.0),
                ped = vec4(-1011.573608, -2691.666016, 13.980225, 130.393707)
            }
        },
        cinematicCams = {
            vec3(-1013.986816, -2693.327393, 13.963379),
            vec3(-1015.621948, -2690.663818, 13.280225)
        }
    },
    ['Centro Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(-352.879120, -676.470337, 32.043213),
            spawnCoords = vec4(-349.028564, -688.101074, 31.628516, 0.000000),
            polyzone = {
                points = {
                    vec3(-363.046143, -675.863708, 31.9),
                    vec3(-363.652740, -705.929688, 31.9),
                    vec3(-316.351654, -706.021973, 31.9),
                    vec3(-317.551636, -676.720886, 31.9)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-334.628571, -776.716492, 38.345093, 102.047249),
            camera = {
                coords = vec3(-339.125275, -775.213196, 38.766357),
                rotation = vec3(-4.0, 3.0, 256.0),
                ped = vec4(-335.934052, -778.654968, 38.766357, 34.015747)
            }
        },
        cinematicCams = {
            vec3(-336.118683, -775.648376, 38.766357),
            vec3(-334.140656, -775.226379, 38.766357)
        }
    },
    ['Cypress Flats Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(722.228577, -2016.342896, 29.279907),
            spawnCoords = vec4(740.479126, -2016.553833, 28.291260, 263.622070),
            polyzone = {
                points = {
                    vec3(754.061523, -2008.312134, 29.5),
                    vec3(751.384644, -2034.501099, 29.5),
                    vec3(715.213196, -2029.556030, 29.5),
                    vec3(719.314270, -2003.261475, 29.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(732.672546, -1983.639526, 28.791260, 25.511812),
            camera = {
                coords = vec3(728.584595, -1982.004395, 29.279907),
                rotation = vec3(-4.0, 3.0, 268.0),
                ped = vec4(733.147278, -1981.450562, 29.279907, 113.385826)
            }
        },
        cinematicCams = {
            vec3(730.417603, -1982.307739, 29.279907),
            vec3(731.854919, -1985.287964, 28.779907)
        }
    },
    ['El Burro Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(1384.325317, -2079.876953, 52.397827),
            spawnCoords = vec4(1382.320923, -2052.065918, 50.893408, 36.850395),
            polyzone = {
                points = {
                    vec3(1369.028564, -2097.600098, 51.9),
                    vec3(1343.037354, -2067.982422, 51.9),
                    vec3(1384.153809, -2034.501099, 51.9),
                    vec3(1408.443970, -2068.166992, 51.9)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(1358.360474, -2095.160400, 51.572144, 334.488190),
            camera = {
                coords = vec3(1355.551636, -2091.481201, 51.993408),
                rotation = vec3(-4.0, 3.0, 232.0),
                ped = vec4(1356.896729, -2095.160400, 51.993408, 39.685040)
            }
        },
        cinematicCams = {
            vec3(1357.424194, -2092.879150, 51.993408),
            vec3(1355.723022, -2094.989014, 52.593408)
        }
    },
    ['La Mesa Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(903.665955, -1575.890137, 30.813232),
            spawnCoords = vec4(871.437378, -1567.081299, 29.488623, 104.881889),
            polyzone = {
                points = {
                    vec3(863.947266, -1581.863770, 30.5),
                    vec3(860.043945, -1564.114258, 30.5),
                    vec3(905.301086, -1543.476929, 30.5),
                    vec3(911.406616, -1582.865967, 30.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(923.327454, -1560.356079, 30.324585, 25.511812),
            camera = {
                coords = vec3(918.567017, -1559.854980, 30.762695),
                rotation = vec3(-4.0, 3.0, 281.5),
                ped = vec4(922.378052, -1561.239502, 30.745728, 93.543304)
            }
        },
        cinematicCams = {
            vec3(920.413208, -1559.709839, 30.745728),
            vec3(921.771423, -1562.373657, 30.728882)
        }
    },
    ['Big Ranch Station'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(345.151642, -1687.424194, 32.515015),
            spawnCoords = vec4(357.125275, -1691.419800, 31.393750, 138.897629),
            polyzone = {
                points = {
                    vec3(363.586823, -1710.830811, 32.5),
                    vec3(373.648346, -1698.725220, 32.5),
                    vec3(347.076935, -1676.967041, 32.5),
                    vec3(338.795593, -1691.815430, 32.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(358.180237, -1690.997803, 47.865234, 82.204727),
            camera = {
                coords = vec3(354.883514, -1694.057129, 48.303345),
                rotation = vec3(-5.0, 3.0, 331.0),
                ped = vec4(358.417572, -1692.329712, 48.303345, 127.559052)
            }
        },
        cinematicCams = {
            vec3(356.175842, -1692.540649, 48.403345),
            vec3(358.865936, -1692.606567, 48.103345)
        }
    },
    ['Rancho Garage'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 1 -- Single Garage
        },
        coords = {
            menuCoords = vec3(450.448364, -1981.714233, 24.393433),
            spawnCoords = vec4(461.037354, -1993.648315, 21.888306, 130.393707),
            polyzone = {
                points = {
                    vec3(443.670319, -1986.632935, 23.4),
                    vec3(461.775818, -1967.643921, 23.4),
                    vec3(477.032959, -1993.912109, 23.4),
                    vec3(463.529663, -2006.755981, 23.4)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(437.802185, -1960.615356, 22.405151, 334.488190),
            camera = {
                coords = vec3(435.969238, -1955.670288, 23.079102),
                rotation = vec3(-3.0, 3.0, 220.0),
                ped = vec4(436.206604, -1960.470337, 23.062256, 12.677164)
            }
        },
        cinematicCams = {
            vec3(436.747253, -1957.371460, 23.062256),
            vec3(434.584625, -1959.771484, 22.712793)
        }
    },
    ['La Mesa Mechanics'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(807.006592, -810.000000, 26.196289),
            spawnCoords = vec4(814.892334, -822.725281, 24.840259, 93.543304),
            polyzone = {
                points = {
                    vec3(823.964844, -828.250549, 26.2),
                    vec3(798.184631, -827.775818, 26.2),
                    vec3(798.672546, -803.235168, 26.2),
                    vec3(824.360413, -796.958252, 26.2)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(797.037354, -818.254944, 25.657104, 34.015747),
            camera = {
                coords = vec3(792.580200, -818.228577, 26.246826),
                rotation = vec3(-3.0, 3.0, 285.0),
                ped = vec4(796.443970, -819.586792, 26.179443, 76.535431)
            }
        },
        cinematicCams = {
            vec3(794.650574, -818.189026, 26.246826),
            vec3(795.850525, -820.694519, 25.896289)
        }
    },
    ['Mirror Park Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(1038.092285, -764.320862, 57.924561),
            spawnCoords = vec4(1040.676880, -775.608765, 56.822290, 8.503937),
            polyzone = {
                points = {
                    vec3(1052.571411, -768.514282, 57.7),
                    vec3(1022.861572, -749.749451, 57.7),
                    vec3(1005.389038, -764.597778, 57.7),
                    vec3(1033.463745, -796.219788, 57.7)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(1021.556030, -656.017578, 58.413208, 354.330719),
            camera = {
                coords = vec3(1018.681335, -652.615356, 58.783936),
                rotation = vec3(-3.0, 3.0, 236.5),
                ped = vec4(1020.079102, -656.452759, 58.767090, 39.685040)
            }
        },
        cinematicCams = {
            vec3(1019.419800, -653.604370, 58.717627),
            vec3(1019.723083, -656.716492, 58.250244)
        }
    },
    ['Del Perro Private'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 7 -- Big Public Garage
        },
        coords = {
            menuCoords = vec3(-1562.742798, -540.210999, 33.593384),
            spawnCoords = vec4(-1542.975830, -564.421997, 24.669653, 36.850395),
            polyzone = {
                points = {
                    vec3(-1527.969238, -567.916504, 25.6),
                    vec3(-1556.057129, -526.879150, 25.6),
                    vec3(-1573.938477, -544.351624, 25.6),
                    vec3(-1546.536255, -580.061523, 25.6)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-1543.608765, -568.430786, 25.269653, 147.401581),
            camera = {
                coords = vec3(-1541.314331, -571.964844, 25.707642),
                rotation = vec3(-5.0, 3.0, 46.0),
                ped = vec4(-1542.092285, -568.786804, 25.707642, 201.259842)
            }
        },
        cinematicCams = {
            vec3(-1542.593384, -570.342834, 25.707642),
            vec3(-1542.052734, -568.430786, 25.407642)
        }
    },
    ['Vinewood Small Park'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 6 -- Small Public Garage
        },
        coords = {
            menuCoords = vec3(-570.382446, 311.301086, 84.479858),
            spawnCoords = vec4(-559.345032, 327.336273, 83.374365, 269.291351),
            polyzone = {
                points = {
                    vec3(-579.072510, 341.789001, 82.6),
                    vec3(-580.457153, 312.000000, 82.6),
                    vec3(-542.162659, 309.956055, 82.6),
                    vec3(-538.747253, 339.032959, 82.6)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-573.415405, 335.129669, 84.159668, 235.275589),
            camera = {
                coords = vec3(-572.808777, 330.738464, 84.547241),
                rotation = vec3(-5.0, 3.0, 374.5),
                ped = vec4(-571.411011, 335.472534, 84.530396, 175.748032)
            }
        },
        cinematicCams = {
            vec3(-572.663757, 332.531860, 84.547241),
            vec3(-575.301086, 334.206604, 84.631470)
        }
    },
    ['Gran Señora Desert'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(180.632965, 2793.375732, 45.640991),
            spawnCoords = vec4(192.290115, 2787.613281, 44.802881, 280.629913),
            polyzone = {
                points = {
                    vec3(198.250549, 2804.307617, 45.5),
                    vec3(177.257141, 2800.707764, 45.5),
                    vec3(184.589020, 2777.564941, 45.5),
                    vec3(204.224182, 2781.494629, 45.5)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(261.679138, 2846.333984, 43.197754, 65.196854),
            camera = {
                coords = vec3(257.498901, 2844.870361, 43.619019),
                rotation = vec3(-5.0, 3.0, 303.0),
                ped = vec4(261.560455, 2844.857178, 43.602173, 104.881889)
            }
        },
        cinematicCams = {
            vec3(259.200012, 2844.382324, 43.619019),
            vec3(261.929688, 2844.237305, 43.568481)
        }
    },
    ['Small Paleto Park'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 1 -- Single Garage
        },
        coords = {
            menuCoords = vec3(-379.556030, 6062.175781, 31.487183),
            spawnCoords = vec4(-398.597809, 6051.204590, 30.515381, 133.228333),
            polyzone = {
                points = {
                    vec3(-410.756042, 6048.870117, 31.4),
                    vec3(-398.492310, 6036.870117, 31.4),
                    vec3(-372.804382, 6064.101074, 31.4),
                    vec3(-386.676910, 6076.430664, 31.4)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(-447.600006, 6052.562500, 30.863770, 147.401581),
            camera = {
                coords = vec3(-445.463745, 6048.553711, 31.335571),
                rotation = vec3(-5.0, 3.0, 42.0),
                ped = vec4(-446.241760, 6052.457031, 31.335571, 201.259842)
            }
        },
        cinematicCams = {
            vec3(-446.452759, 6050.492188, 31.335571),
            vec3(-445.345062, 6052.826172, 30.835571)
        }
    },
    ['Grapeseed Parking'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(2564.320801, 4680.435059, 34.065186),
            spawnCoords = vec4(2550.817627, 4682.188965, 32.740698, 17.007874),
            polyzone = {
                points = {
                    vec3(2563.885742, 4703.261719, 33.1),
                    vec3(2578.048340, 4691.960449, 33.1),
                    vec3(2548.720947, 4663.041992, 33.1),
                    vec3(2539.173584, 4681.252930, 33.1)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(2561.828613, 4688.333984, 33.593384, 96.377945),
            camera = {
                coords = vec3(2558.254883, 4690.232910, 33.930420),
                rotation = vec3(-5.0, 3.0, 246.5),
                ped = vec4(2560.404297, 4686.725098, 34.115723, 39.685040)
            }
        },
        cinematicCams = {
            vec3(2559.784668, 4689.679199, 33.997803),
            vec3(2562.567139, 4690.140625, 33.531494)
        }
    },
    ['Grapeseed Village Park'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'vehicle',
        shell = {
            shell = 5 -- Mechanic Garage
        },
        coords = {
            menuCoords = vec3(1707.230713, 4791.890137, 41.967773),
            spawnCoords = vec4(1697.195557, 4804.549316, 40.744360, 141.732285),
            polyzone = {
                points = {
                    vec3(1717.279175, 4790.479004, 41.8),
                    vec3(1716.909912, 4811.116699, 41.8),
                    vec3(1688.360474, 4811.894531, 41.8),
                    vec3(1689.454956, 4789.450684, 41.8)
                },
                thickness = 25.0
            },
        },
        vehicleCamera = {
            vehicleCoords = vec4(1690.694458, 4786.865723, 41.445435, 127.559052),
            camera = {
                coords = vec3(1686.567017, 4787.340820, 41.917236),
                rotation = vec3(-5.0, 3.0, 270.0),
                ped = vec4(1690.325317, 4784.755859, 41.917236, 51.023624)
            }
        },
        cinematicCams = {
            vec3(1688.334106, 4786.812988, 41.917236),
            vec3(1690.813232, 4788.830566, 41.317236)
        }
    },

    --[[
        Boat garages, there are multiple set up, you
        can customize them, but it requires you to
        change positions and cinematic cam.
    ]]
    ['La Puerta Pier'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'boat',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(-789.1887, -1490.7750, 1.5952),
            spawnCoords = vec4(-796.127441, -1502.109863, 0.112793, 110.551186),
            polyzone = {
                points = {
                    vec3(-805.951660, -1496.690063, 1.5),
                    vec3(-799.780212, -1513.833008, 1.5),
                    vec3(-777.929688, -1506.158203, 1.5),
                    vec3(-786.026367, -1487.749390, 1.5)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(-794.874695, -1501.833008, 0.348755, 291.968506),
            camera = {
                coords = vec3(-791.525269, -1497.138428, 1.476929),
                rotation = vec3(-5.0, 3.0, 169.0),
                ped = vec4(-793.226379, -1509.336304, 1.578735, 348.661407)
            }
        },
        cinematicCams = {
            vec3(-791.934082, -1499.116455, 0.976929),
            vec3(-799.239563, -1499.432983, 2.476929)
        }
    },
    ['Paleto Cove Pier'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'boat',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(-1605.323120, 5258.281250, 2.067383),
            spawnCoords = vec4(-1600.457153, 5263.279297, 0.348755, 22.677164),
            polyzone = {
                points = {
                    vec3(-1614.738403, 5261.604492, 0.2),
                    vec3(-1608.501099, 5245.542969, 0.2),
                    vec3(-1585.885742, 5257.424316, 0.2),
                    vec3(-1593.151611, 5273.617676, 0.2)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(-1600.760498, 5260.602051, 0.331909, 0.000000),
            camera = {
                coords = vec3(-1597.872559, 5266.628418, 1.850537),
                rotation = vec3(-15.0, 3.0, 157.0),
                ped = vec4(-1604.624146, 5256.685547, 2.067383, 328.818909)
            }
        },
        cinematicCams = {
            vec3(-1598.465942, 5264.465820, 1.073242),
            vec3(-1598.149414, 5258.479004, 1.060059)
        }
    },
    ['Paleto Bay Pier'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'boat',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(-243.059341, 6598.101074, 7.391968),
            spawnCoords = vec4(-288.553833, 6617.802246, -0.399292, 48.188972),
            polyzone = {
                points = {
                    vec3(-236.518677, 6536.966797, 0.2),
                    vec3(-200.452744, 6595.793457, 0.2),
                    vec3(-263.380219, 6673.529785, 0.2),
                    vec3(-306.778015, 6617.354004, 0.2)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(-292.378021, 6618.764648, 0.365601, 70.866142),
            camera = {
                coords = vec3(-299.050537, 6615.534180, 1.153174),
                rotation = vec3(-3.0, 3.0, 316.0),
                ped = vec4(-286.615387, 6627.837402, 7.139160, 150.236221)
            }
        },
        cinematicCams = {
            vec3(-295.437347, 6615.692383, 0.845410),
            vec3(-286.483521, 6616.628418, 1.245410)
        }
    },
    ['Pacific Small Pier'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'boat',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(3852.725342, 4459.898926, 1.865234),
            spawnCoords = vec4(3855.388916, 4454.347168, 0.115063, 269.291351),
            polyzone = {
                points = {
                    vec3(3872.004395, 4444.694336, 1.1),
                    vec3(3874.852783, 4468.522949, 1.1),
                    vec3(3827.986816, 4467.969238, 1.1),
                    vec3(3838.298828, 4444.114258, 1.1)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(3857.986816, 4446.975586, 0.247559, 272.125977),
            camera = {
                coords = vec3(3864.804443, 4442.637207, 1.241699),
                rotation = vec3(-3.0, 3.0, 57.0),
                ped = vec4(3859.331787, 4458.540527, 1.831543, 184.251968)
            }
        },
        cinematicCams = {
            vec3(3861.177979, 4444.786621, 0.173584),
            vec3(3853.437256, 4444.246094, 0.173584)
        }
    },

    --[[
        Aircraft hangars, there are multiple configured,
        you can customize them, but it requires you to
        change positions and cinematic cam.
    ]]
    ['Airport Hangar'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'plane',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(-940.958252, -2954.043945, 13.929688),
            spawnCoords = vec4(-980.228577, -2997.375732, 12.929688, 59.527554),
            polyzone = {
                points = {
                    vec3(-967.727478, -2915.538574, 13.9),
                    vec3(-908.386841, -2953.595703, 13.9),
                    vec3(-972.474731, -3044.215332, 13.9),
                    vec3(-1020.118652, -3021.468018, 13.9)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(-980.228577, -2997.375732, 12.929688, 59.527554),
            camera = {
                coords = vec3(-985.674744, -2999.604492, 13.929688),
                rotation = vec3(0.0, 2.0, -52.0),
                ped = vec4(-980.571411, -2999.446045, 13.929688, 87.874016)
            }
        },
        cinematicCams = {
            vec3(-990.712097, -2998.734131, 13.929688),
            vec3(-982.008789, -3001.028564, 13.929688)
        }
    },
    ['Trevor Hangar'] = {
        owner = true,
        available = true,
        isImpound = false,
        job = false, -- You can give it a job by simply adding 'police' for example
        type = 'plane',
        shell = {
            shell = 1
        },
        coords = {
            menuCoords = vec3(1759.199951, 3298.562744, 41.714966),
            spawnCoords = vec4(1740.224121, 3277.740723, 40.191553, 144.566910),
            polyzone = {
                points = {
                    vec3(1722.949463, 3289.477051, 41.1),
                    vec3(1766.228516, 3303.454834, 41.1),
                    vec3(1766.716431, 3249.322998, 41.1),
                    vec3(1724.690063, 3241.054932, 41.1)
                },
                thickness = 25.0
            }
        },
        vehicleCamera = {
            vehicleCoords = vec4(1740.210938, 3277.740723, 40.805176, 141.732285),
            camera = {
                coords = vec3(1741.239502, 3269.248291, 41.209473),
                rotation = vec3(0.0, 2.0, 23.0),
                ped = vec4(1742.162598, 3277.292236, 41.108398, 201.259842)
            }
        },
        cinematicCams = {
            vec3(1740.408813, 3273.929688, 41.058936),
            vec3(1743.534058, 3279.164795, 41.574707)
        }
    },
}

--[[
    Garage section for workers, here you can give a car spot for
    each job, rent or give for free, do it following the example!
]]

Config.JobGarages = {
    
}

--[[
    Default cameras, these cameras and zones are the ones that will
    appear in case of deleting vehicleCamera and cinematicCams, or
    in the players' personal Garages. We recommend leaving them by
    default in case something fails in other garages, this will be
    the alternative camera and zone.
]]

Config.vehicleCamera = {
    vehicleCoords = vec4(-148.628571, -594.474731, 166.723755, 155.905502),
    camera = {
        coords = vec3(-145.780212, -598.232971, 166.993408),
        rotation = vec3(-2.0, 2.0, 51.5),
        ped = vec4(-147.032959, -595.186829, 166.993408, 201.259842)
    },
    cinematicCams = {
        vec3(-147.389008, -596.940674, 167.193408),
        vec3(-145.608795, -594.079102, 166.993408)
    }
}

Config.BoatCamera = {
    vehicleCoords = vec4(-859.648376, -1476.923096, 0.432983, 291.968506),
    camera = {
        coords = vec3(-857.762634, -1471.569214, 1.629272),
        rotation = vec3(-10.0, 2.0, 178.0),
        ped = vec4(-867.006592, -1481.564819, 1.578735, 311.811035)
    },
    cinematicCams = {
        vec3(-858.316467, -1474.628540, 1.176929),
        vec3(-864.567017, -1476.382446, 1.576929)
    }
}

Config.PlaneCamera = {
    vehicleCoords = vec4(1729.635132, 3298.760498, 40.788330, 359.661407),
    camera = {
        coords = vec3(1733.762695, 3303.072510, 41.209473),
        rotation = vec3(-5.0, 2.0, 145.0),
        ped = vec4(1731.098877, 3298.826416, 41.209473, 340.133850)
    },
    cinematicCams = {
        vec3(1732.035156, 3302.742920, 41.709473),
        vec3(1731.468140, 3296.861572, 41.209473)
    }
}

--[[
    The action controls are the ones that are
    set for the creation of Garages, these can
    be modified to be read with their specific
    language, but we do not recommend changing
    their keys for better functionality!
]]

Config.ActionControls = {
    forward = {
        label = 'Forward +/-',
        codes = { 33, 32 }
    },
    right = {
        label = 'Right +/-',
        codes = { 35, 34 }
    },
    up = {
        label = 'Up +/-',
        codes = { 52, 51 }
    },
    add_point = {
        label = 'Add Point',
        codes = { 24 }
    },
    undo_point = {
        label = 'Undo Last',
        codes = { 25 }
    },
    set_position = {
        label = 'Set Position',
        codes = { 24 }
    },
    add_garage = {
        label = 'Add Garage',
        codes = { 24 }
    },
    rotate_z = {
        label = 'RotateZ +/-',
        codes = { 20, 73 }
    },
    rotate_z_scroll = {
        label = 'RotateZ +/-',
        codes = { 17, 16 }
    },
    increase_z = {
        label = 'Z Boundary +/-',
        codes = { 180, 181 }
    },
    decrease_z = {
        label = 'Z Boundary +/-',
        codes = { 21, 180, 181 }
    },
    change_shell = {
        label = 'Next Shell Model',
        codes = { 217 }
    },
    done = {
        label = 'Done',
        codes = { 191 }
    },
    change_player = {
        label = 'Player +/-',
        codes = { 82, 81 }
    },
    select_player = {
        label = 'Select Player',
        codes = { 191 }
    },
    cancel = {
        label = 'Cancel',
        codes = { 194 }
    },
    select_vehicle = {
        label = 'Vehicle +/-',
        codes = { 82, 81 }
    },
    spawn_vehicle = {
        label = 'Spawn Vehicle',
        codes = { 191 }
    },
    leftApt = {
        label = 'Previous Interior',
        codes = { 174 }
    },
    rightApt = {
        label = 'Next Interior',
        codes = { 175 }
    },
    select_menuCoords = {
        label = 'Set Menu Location',
        codes = { 47 }
    },
    select_spawnCoords = {
        label = 'Set Vehicle Spawn Location',
        codes = { 74 }
    },
}

--[[
    Debug mode, this mode is to receive constant prints and information
    from the system, we do not recommend enabling it if you are not a
    developer, but it will help to understand how the resource works.
]]

Config.Debug = false
Config.ZoneDebug = false
