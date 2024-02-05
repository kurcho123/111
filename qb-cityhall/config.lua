Config = Config or {}

Config.UseTarget = true -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.AvailableJobs = { -- Only used when not using qb-jobs.
    ["trucker"] = {["label"] = "Trucker", ["description"] = "Описание на джоба"},
    ["taxi"] = {["label"] = "Taxi", ["description"] = "Описание на джоба"},
    ["tow"] = {["label"] = "Tow Truck", ["description"] = "Описание на джоба"},
    ["reporter"] = {["label"] = "News Reporter", ["description"] = "Описание на джоба"},
    ["garbage"] = {["label"] = "Garbage Collector", ["description"] = "Описание на джоба"},
    ["bus"] = {["label"] = "Bus Driver", ["description"] = "Описание на джоба"},
    ["hotdog"] = {["label"] = "Hot Dog Stand", ["description"] = "Описание на джоба"}
}

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vec3(318.40, -1640.28, 32.54),
        showBlip = false,
        blipData = {
            sprite = 487,
            display = 4,
            scale = 0.65,
            colour = 0,
            title = "Община"
        },
        licenses = {
            ["id_card"] = {
                label = "Лична Карта",
                cost = 150,
            },
            ["driver_license"] = {
                label = "Шофьорска Книжка",
                cost = 500,
                metadata = "driver"
            },
            ["lawyerpass"] = {
                label = "Адвокатска Карта",
                cost = 100,
            },
            ["pilotlicense"] = {
                label = "Пилотски Лиценз",
                cost = 100000,
            },
        }
    },
}

Config.DrivingSchools = {
    -- { -- Driving School 1
    --     coords = vec3(240.3, -1379.89, 33.74),
    --     showBlip = true,
    --     blipData = {
    --         sprite = 225,
    --         display = 4,
    --         scale = 0.65,
    --         colour = 3,
    --         title = "Driving School"
    --     },
    --     instructors = {
    --         "DJD56142",
    --         "DXT09752",
    --         "SRI85140",
    --     }
    -- },
}

Config.Peds = {
    -- Cityhall Ped
    {
        model = 'a_m_m_hasjew_01',
        coords = vec4(318.40, -1640.28, 32.54 - 1, 317.73),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
}
