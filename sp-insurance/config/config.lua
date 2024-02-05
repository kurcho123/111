Config = {}

Config.Restart = false -- ONLY ENABLE THIS FOR DEBUG Config.Utility.Job - NEED TO ACTIVATE THIS TO USE /RESTART sp-insurance
Config.Commands = { -- Command for checking the car insurance
    Enable = true, -- Enable commands?
    Command = "checkinsurance",  -- Command
    NeedJob = true, -- Need job for making the command?
    Job = "ambulance", -- Job Needed
}

Config.Inventory = {
    Ox = true, -- use this for ox inventory
    QB = false, -- use this for qb/lj and other qb-core compatible inventories that make use of the native player functions
    QSV1 = false, -- YOU MUST USE CONFIG.CALIBERS FOR QS-INVENTORY
    QSV2 = false, -- YOU MUST USE CONFIG
    Standalone = false, -- use this for non-standard inventories, this REQURIES you to create custom code in Config.Functions to handle giving/taking items, updating player inventory, and fetching player inventory on the client
    CustomStatebags = {
        Busy = 'invBusy',
        Open = 'invOpen',
    },
    CustomMetadata = { -- do not mess with unless you are running a custom inventory or have modified qb/ox inventory to use a custom field
        Enabled = false, -- enable use of custom metadata field if not using 'info' for any script or 'metadata' for ox_inventory
        Field = 'info' -- the field used for metadata by a script
    }
}
--------------------------
-- Utility
--------------------------
Config.Utility = {
    CoreName = "qb-core", -- Your core name
    SQL = "oxmysql", -- oxmysql or ghmattimysql
    --Phone = "qb-phone", -- qb-phone / qs-smartphone / gksphone / rodaphone
    --PhoneEmail = "qb-phone:server:sendNewMail", -- Your trigger email | qb-phone: qb-phone:server:sendNewMail | qs-smartphone: qs-smartphone:server:sendNewMail | gksphone: qs-gksphone:NewMail
    Target = "qb-target", -- Your target name
    --Management = "qb-management", -- Your qb-management name
    UseableItems = true, -- Can use items to show to close people
    MakeAnimation = true, -- Make animation when see the cards?
    Animation = "book", -- Animation
    Job = "ambulance",   -- If you want a job to make registration/insurance! If no employee on duty people can use peds. (Leave it blank to disable JOB)
    UseSocietyAccount = true, -- If true, then the price goes to company
    Company = "ambulance", -- Job name to the price go
    Range = 3.0, -- Range to access ped with 3rd eye
    Peds = { -- Peds
        --{ type = 4, hash = GetHashKey("s_m_m_gaffer_01"), vector4 = vector4(835.26, -805.76, 25.33, 89.50) },
        -- You can add more peds if you want
    },
    WaitTime = 3000, -- Time to complete the insurance
    CustomPlate = true, -- Use custom plates?
}

Config.Time = { -- This works on car & health insurance
    [1] = 7, -- xTime in days
    [2] = 14, -- 2xTime in days
    [3] = 28, -- 3xTime in days
}

Config.Registration = { -- Even if Registration expire you can still get your insurance (update should come soon)
    Expire = false,
    ExpireTime = 5, -- in days
}

Config.Mot = { -- Even if Registration expire you can still get your insurance (update should come soon)
    Expire = true,
    ExpireTime = 28, -- in days
}

Config.Prices = {
    Type = "bank",
    ByVehicleCategory = false,
    Registration = 2500, -- Price for car registration
    Mot = 2000
}



--██╗░░██╗███████╗░█████╗░██╗░░░░░████████╗██╗░░██╗
--██║░░██║██╔════╝██╔══██╗██║░░░░░╚══██╔══╝██║░░██║
--███████║█████╗░░███████║██║░░░░░░░░██║░░░███████║
--██╔══██║██╔══╝░░██╔══██║██║░░░░░░░░██║░░░██╔══██║
--██║░░██║███████╗██║░░██║███████╗░░░██║░░░██║░░██║
--╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝

Config.Health = {
    UseSocietyAccount = true, -- If true, then the price goes to company
    Company = "ambulance", -- Job name to the price go
    Peds = { -- Peds
        { type = 4, hash = GetHashKey("s_m_m_paramedic_01"), vector4 = vector4(353.17, -593.82, 27.85, 359.58), minZ = 42.28, maxZ = 44.13 },
        -- You can add more peds if you want
    },
    Prices = {
        One = 800, -- 1 Month
        Two = 1500, -- 2 Monts
        Three = 2000, -- 3 Months
    }
}

Config.InsuranceItems = {
    label = "Документи",
    slots = 10,
    job = "ottos",
    items = {
        [1] = {
            name = "insurance_blank",
            price = 10,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "registration_blank",
            price = 10,
            amount = 1,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "mot_blank",
            price = 10,
            amount = 1,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "contract",
            price = 100,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
        },
    }
}