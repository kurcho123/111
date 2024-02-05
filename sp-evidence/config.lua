-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------        r14-evidence         -------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-------                           Permanent Discord Invite: https://discord.gg/Dj3nXTaUYZ                             -------
-------                           Tebex Storefront: https://r14-dev.tebex.io/                                         -------
-------                           Online Documentation: https://regalonefour.github.io/                               -------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()
--ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()
ox_inventory = GetResourceState('ox_inventory') == 'started' and exports.ox_inventory
--QS = nil TriggerEvent('qs-core:getSharedObject', function(library) QS = library end) -- fetch QS for QS users

Config = {}

-----------------------------------------------------------------------------------------------------------
--------------------------------------        Debug Config         ----------------------------------------
-----------------------------------------------------------------------------------------------------------

Config.Debug = {
    DebugCommand = false, -- enable debug command
    Evidence = {enabled = false, label = "Print evidence creation to console.", order = 1}, -- enable this to print debug information when normal evidence is created
    CarEvidence = {enabled = false, label = "Print car evidence creation to console.", order = 2}, -- enable this to print debug information when car evidence is created
    Database = {enabled = false, label = "Print database events to server console.", server = true, order = 3}, -- enable this to print debug information related to vehicle evidence being uploaded to the database
    Bucket = {enabled = false, label = "Print current bucket to console.", order = 4}, -- enable this to print debug information relating to routing buckets here
    ViewEvidence = {enabled = false, label = "View evidence without camera or police job", order = 5}, -- enable seeing evidence at all times without use of camera for testing
    PrintBAC = {enabled = false, label = "Print the contents of the PlayerBAC table to server console during loop", server = true, order = 7}, -- this will print the PlayerBAC table every loop
    PrintTamperLoop = {enabled = false, label = "Print the contents of the Vehicle Tamper tables to server console during loop", server = true, order = 8}, -- this will print the PlayerBAC table every loop
    PrintStatus = {enabled = false, label = "Print the contents of the player status table to server console during loop", server = true, order = 9}, -- this will print the player status table every loop
    PrintFade =  {enabled = false, label = "Print evidence expiring to server console", server = true, order = 10}, -- this will print evidence pieces being removed by the time check loop to server console
    PrintTest = {enabled = false, label = "Print result of player checks/tests to server console", server = true, order = 11}, -- print results of BAC, GSR, frisks, and investigates to server console
    PrintTestC = {enabled = false, label = "Print data sent to player check/test events to console.", order = 12}, -- print data sent to BAC, GSR, frisks, and investigates to console
    OutlineCasings = {enabled = false, label = "Draw entity outline for shell casing objects", order = 13}, -- print data sent to BAC, GSR, frisks, and investigates to console
    ConfirmDrugPositive = {enabled = false, label = "Create server print and notify player when they test positive for a drug.", order = 14}, -- print/notify when a player returns positive for a drug to assist in testing drug/consumables integration
    PrintEventTriggerArgs = {enabled = false, label = "Print the arguments for your alochol and drug triggers to server console", server = true, order = 15}, -- this will print event trigger args to server console
}

-----------------------------------------------------------------------------------------------------------
-------------------------------        Framework/Scripts Config         -----------------------------------
-----------------------------------------------------------------------------------------------------------

Config.Framework = {
    QB = true, -- set to true for QB Core
    ESX = false, -- set to true for ESX legacy, this is an EARLY AND EXPERIMENTAL implementation, please report any issues on the discord
    Standalone = false, -- use this for non-standard frameworks, this REQURES you to create custom code in Config.Functions to handle getting player data such as job, rank, name, identifier, fingerprint, and downed/dead status
    CustomUpdateEvents = { -- this will define events where the script will update player data, you should include events triggered on load, unload, job updates, or character switch
        Client = { -- these are for events triggered on the client side
            ['QBCore:Client:OnPlayerLoaded'] = true,
            ['QBCore:Client:OnPlayerUnload'] = true,
            ['QBCore:Client:OnJobUpdate'] = true,
        },
    },
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

Config.Target = {
    Ox = true, -- use this for ox_target
    QB = false, -- use this for qb-target
    Custom = false, -- set this to a string which matches your targeting resource name
}

Config.Context = {
    Ox = true, -- use this for ox_lib
    QB = false, -- use this for qb-ui/input
    Custom = false, -- set this to a string of your context menu resource name
}

Config.MDT = { -- this config sets up OPTIONAL photo upload to MDT systems/reports
    DRX = true, -- this uploads photos to DRX evidence & specific reports
    PS = false, -- this uploads photos to ps-mdt reports
}

Config.DB = { -- this config sets what table you are using to store vehicle evidence
    Vehicle = Config.Framework.QB and 'player_vehicles' or Config.Framework.ESX and 'owned_vehicles', -- set this to your player vehicle table
    Plate = 'plate', -- the column in your vehicle table that contains your license plate
    Evidence = 'evidence', -- the column in your vehicle table that contains evidence info
    Identifiers = 'ev_identifiers', -- if you use ESX or a standalone framework and need to generate citizenids, fingerprints, and bloodtypes, set this to your custom table
}

-----------------------------------------------------------------------------------------------------------
------------------------------------        Subsystem Configs         -------------------------------------
-----------------------------------------------------------------------------------------------------------

Config.EvidenceLimits = {
    Max = 2000, -- max number of evidence pieces held on the server
    RemoveAfterLimit = 100, -- number of evidence pieces removed when hitting the max limit
}

Config.EvidenceFadeTime = {
    Casings = 60, -- time, in minutes, that casings remain before being removed
    Impact = 45, -- time, in minutes, that bullet impacts remain in workd before being removed
    Blood = 60, -- time, in minutes, that fingerprints remain before being removed
    Fingerprint = 20, -- time, in minutes, that fingerprint evidence gets removed without player intervention
    Tampering = 15, -- time, in minutes, that lock tamperings get removed
    Fragment = 45, -- time, in minutes, that vehicle fragments remain in world before being removed
    NetImpact = 30, -- time in minutes, that network entity remain in world before getting removed
    NetPedImpact = 30, -- time in minutes, that network ped impacts remain in world before getting removed
    VehTampers = 15, -- time, in minutes, that vehicle tampers remain before being removed
    VehFingerprints = 3, -- time, in days, that vehicle fingerprints gets removed from vehicles without player intervention
    VehCasings = 14, -- time, in days, that vehicle casings get removed from vehicles without player intervention
    VehBlood = 21, -- time, in days, that vehicle blood get removed from vehicles without player intervention
    WeaponPrints = 365, -- time, in days, that fingerprints stay on weapons without player intervention
    WeaponBlood = 14, -- time, in days, that blood stays on a weapon without player intervention
}

Config.VehCasingChance = 70 -- set this to a number between 1 and 100, higher equals greater chance of casings staying in vehicle when fired in drive by

Config.Bleed = {
    EnableCommand = true, -- set to FALSE to disabled the /bleed command that allows players to generate blood evidence (but recieve damage when doing so)
    PreventDeath = true, -- set to FALSE to allow players to down themselves using the bleed command
    Cooldown = 10, -- the amount, in seconds, to set the cooldown timer for the /bleed command
    DamageChance = 40, -- the chance a damage event causes a player to bleed, which a rng must 'beat' or go over to result in bleed
}

Config.GSR = {
    MinShotsStatus = 5, -- the amount of times someone can fire nearby a player before they get a gunpowder status effect
    MinShotsPositive = 2, -- the amount of times a player needs to shoot to test positive for GSR (not get a gunpowder status effect)
    FadeTime = 10, -- the amount, in minutes, it takes for a player to not test positive for GSR
    WhileAiming = true, -- this sets whether or not aiming a weapon will generate a positive GSR test
    AimingTime = 5, -- the time, in seconds, it takes for a player to test positive for GSR if aiming a weapon
    ShootingChance = 70, -- set to FALSE to use only MinShotsPositive, or set to a number between 1 and 100 to enable a chance of becoming GSR positive (less realistic, more rp leeway)
    NearbyChance = 70, -- set to FALSE to use only MinShotsStatus, or set to a number between 1 and 100 to enable a chance of becoming GSR positive (less realistic, more rp leeway)
    AimingChance = 50, -- set to FALSE to use only AimingTime, or set to a number between 1 and 100 to enable a chance of becoming GSR positive (less realistic, more rp leeway)
    WashOff = true, -- set to TRUE for gsr to wash off in water
}

Config.Fingerprints = {
    RequireKit = true, -- set this to TRUE if you want to require a player have a fingerprint kit and mikrosil/fingerprint tape to lift prints
}

Config.EvidenceCleanup = {
    RemoveFingerprints = { -- these items will remove fingerprints and can be combined with the remove blood items   *********IF YOU ARE USING OX_INVENTORY YOU MUST ADD A SERVER EXPORT FOR IT TO BE USEABLE************
        ['microfibercloth'] = {useable = true}, -- this item will open a weapon interaction menu to wipe it down or clean it
        ['rag'] = {useable = false}, -- this item will allow you to wipe down the weapon if you use the /cleanweapon command  *********IF YOU ARE USING OX_INVENTORY YOU MUST ADD A SERVER EXPORT FOR IT TO BE USEABLE************
    },
    AlwaysAvailable = true, -- set to FALSE to require rag item for removing fingerprints, removing blood will require a dedicated rag still
    RemoveBlood = { -- these items will remove blood, but requires a rag from RemoveFingerprints to use
        ['blox'] = true, -- can add a status effect with the same name for a specific status
        ['bleach'] = true,
        ['gunsolvent'] = true,
    },
    ConsumeRemoveBlood = true, -- set to TRUE if you want the cleanser item to be consumed on use
}

Config.Consume = {
    GSR = true, -- set this to true if you want GSR tests to be consumed upon use
    DNA = true, -- set this to true if you want DNA tests to be consumed upon use
    AccessTool = 20, -- set to a number of uses if desired, if not set to false for no usage limit
}

Config.VehInAndOut = { -- this OPTIONALLY configures your server side event that triggers when garaging or ungaraging a vehicle, the paramaters for base qb-garages are included, cd_garages is not supported
    InEvent = Config.Framework.ESX and 'esx_garage:updateOwnedVehicle' or 'qb-garage:server:updateVehicle',
    InState = Config.Framework.ESX and true or 1, -- the state receieved when placing a vehicle in a garage
    InStateVar = 1, -- the argument that is received for the vehicle state when putting it in a garage
    InStateVarSubfield = nil, -- the subfield of the in state var in the table that is supplied, you can use a period to search multiple subfields
    InPlateVar = Config.Framework.ESX and 4 or 5, -- the argument that is received for the vehicle plate when putting it in a garage
    InPlateVarSubfield = Config.Framework.ESX and 'vehicleProps.plate', -- use a . to access further subfields
    OutEvent = Config.Framework.ESX and 'esx_garage:updateOwnedVehicle' or 'qb-garage:server:updateVehState',
    OutState = Config.Framework.ESX and false or 0,
    OutStateVar = 1,
    OutStateVarSubfield = nil, -- the subfield of the out state var in the table that is supplied, you can use a period to search multiple subfields
    OutPlateVar = Config.Framework.ESX and 4 or 2,
    OutPlateVarSubfield = Config.Framework.ESX and 'vehicleProps.plate', -- use a . to access further subfields
}

Config.ViewEmotes = { -- this tale allows you to set which animations/emotes allow you civlians to view evidence
    [1] = {scenario = 'WORLD_HUMAN_MOBILE_FILM_SHOCKING'},
    [2] = {scenario = 'WORLD_HUMAN_PAPARAZZI'}, -- use scenario for scenarios
    [3] = {animDict = 'amb@world_human_paparazzi@male@base', animName = 'base'}, -- use animDict and animName for regular animations
}

--[[------------ Breathalyzer Config ----------------

This table allows you to set up or completely disable breathalying in this script. Out of the box, r14-evidence provides support for qb-core smallresources through
a built in event handler, and requires set up to use with other frameworks and third party resources. You can use the EventTriggers subfield below to set up
events which will trigger ABV increases for a player that can be tested using the breahtalyzer target option by police characters, or you can follow the guide at
regalonefour.github.io to insert the appropriate event triggers into your consumables or inventory resource in order to trigger the proper ABV increase.

    [2] = {
        event = 'consumables:server:drinkAlcohol', -- name of the event
        type = 'server', -- OPTIONAL, server or client to specify which type of event
        alcoholArgPos = 1, -- OPTIONAL, the position of the argument recieved in the event handler
        alocholArgSubField = 'item', -- OPTIONAL, if the arg is a table, the subfield you want to check such as in this case arg[1].item
        alcoholArgValue = { -- OPTIONAL, the value the argument should be equal to in order to trigger, can either be a value or a table
            ['beer'] = true,
            ['vodka'] = 20, -- you can specify a custom ABV by setting the key equal to a value instead of true, in this case it will raise ABV by 0.02 instead of 0.15
        },
    },

--]]--------------------------------------------------


Config.Breathalyzer = {
    Enabled = true, -- set this to true if you want to use the breathalyzer events contained in this script (may require additional setup if not using qb-smallresources)
    UsingESX = false, -- set this to true if you are using ESX and want to use the native ESX.setPlayerStatus function to set BAC
    EventTriggers = {
        [1] = {
            event = 'consumables:client:DrinkAlcohol', -- name of the event
            type = 'client', -- OPTIONAL, server or client to specify which type of event
            alcoholArgPos = 1, -- OPTIONAL, the position of the argument recieved in the event handler
            alocholArgSubField = 'item', -- OPTIONAL, if the arg is a table, the subfield you want to check such as in this case arg[1].item
            alcoholArgValue = { -- OPTIONAL, the value the argument should be equal to in order to trigger, can either be a value or a table
                ["beer"] = true,
                ["whiskey"] = 500,
                ["dvrcocktail"] = 20,
                ["kamikaze"] = 20,
                ["jbcocktail"] = 20,
                ["marvelcocktail"] = 20,
                ["vitodaiquiri"] = 20,
                ["yoshishooter"] = 20,
                ["iflag"] = 20,
                ["hulkcocktail"] = 20,
                ["voodoo"] = 20,
                ["cappucc"] = 20,
                ["milkdragon"] = 20,
                ["bkamikaze"] = 20,
                ["scarcolada"] = 20,
                ["cookies_frappuccino"] = 20,
                ["pink_coconut"] = 20,
                ["strawberry_juice"] = 20,
                ["brussian"] = 20,
                ["cb_cocktail"] = 20,
                ["cb_coconut_drink"] = 20,
                ["cb_island_fantasy"] = 20,
                ["cb_kamikaze"] = 20,
                ["cb_redhot_daquiri"] = 20,
                ['vodka'] = 500, -- you can specify a custom ABV by setting the key equal to a value instead of true, in this case it will raise ABV by 0.02 instead of 0.15
            },
        },
    },
}

--[[---------- Drug Testing Config ----------

This table allows you to set up or completely disable drug testing in the script, out of the box, r14-evidence is set up to work with the drugs included
in qb-core through built-in event listeners/handlers both in the server and client. If you are using a third party drug script, you can use the EventTriggers
subfield to set up custom event handlers to integreate with your drug/consumables script, or you can follow the guide at regalonefour.github.io to insert
custom event triggers into your drug/consumables resource code in order to trigger the proper drug testing events in r14-evidence.

Below, we will add a sample config for a hypothetical drug script in which were we specify the paramaters that will trigger drug usage.

    [4] = {
        event = 'customdrugs:server:cocaine', -- REQUIRED IF NOT USING JIMS VARIABLE, name of the event to listen for
        drugType = 'cocaine' -- REQUIRED, specify the config drug test that will be set positive by this event trigger
        type = 'server', -- OPTIONAL, will default to server if not specified, if you want to use a client event you must specify client
        positiveTime = 4, -- OPTIONAL, specify a custom time in hours for the character to return positive
        drugArgPos = 4, -- OPTIONAL, if your script uses one event for multiple drugs, you can access an argument to validate the drug
        drugArgSubfield = 'drugName', -- OPTIONAL, if your argument is a table, specify the name of the key to be accessed
        drugArgValue = 'cocaine', -- OPTIONAL, the value the argument should be to trigger the drug usage, by default this will be true if not specified and you have specified an arg, this can also be a table for multiple drugs
        cidArgPos = 2, -- OPTIONAL, if your server event is being triggered by the server for some reason, specify the arg of the player CID, not needed if triggering from client
        cidArgSubfield = , -- OPTIONAL, specify the subfield if the arg is a table, not needed if triggering from client, not needed if triggering from client
        sourceArgPos = 3, -- OPTIONAL, if your server event is being triggered by the server for some reason, specify the source fo the player to find their CID, not needed if triggering from client
        souceArgSubfield = originalSource, -- OPTIONAL, specify the original source subfield if the arg is a table, such as here arg[3].originalSource, not needed if triggering from client
    },

--]]------------------------------------------

Config.DrugTesting = {
    Enabled = true,
    UsingQBSR = true, -- set to true if you are using basic qb-smallresources, if not you will need to specify an event trigger or edit your consumables resource
    DefaultPositiveTime = 1, -- number, in hours, that a player remains positive for a drug test (does not extend past script reset)
    Drugs = { -- these are DRUG TYPES that show up on your drug test, avoid adding too many as they will make the drug test results cluttered and oversized
        ['weed'] = {
            label = 'Марихуана'
        },
        ['oxycodone'] = {
            label = 'Оксикодон',
        },
        ['ecstacy'] = {
            label = "Екстази",
        },
        ['cocaine'] = {
            label = 'Кокаин',
        },
        ['meth'] = {
            label = 'Метамфетамин',
        },
    },
    EventTriggers = {
        --[1] = {event = 'consumables:server:useMeth', type = 'server', drugType = 'meth', positiveTime = 4},
        --[2] = {event = 'evidence:client:SetStatus', type = 'client', drugType = 'weed', drugArgPos = 1, drugArgSubfield = nil, drugArgValue = 'weedsmell'}, -- this is how you could trigger weed in QBSR

        [1] = { -- event trigger for jim-consumables
            event = 'jim-consumables:server:toggleItem',
            drugArgPos = 2,
            drugArgValue = { -- add additional drug items here
                ['joint'] = 'weed',
                ['cokebaggy'] = 'cocaine',
                ['crackbaggy'] = 'cocaine',
                ['xtcbaggy'] = 'ecstacy',
                ['oxy'] = 'oxycodone',
                ['meth'] = 'meth',
            }
        },
    }
}

--[[---------- Camera Upload Config ----------

YOU MUST SET UP YOUR WEBHOOKS IN THE SERVER/NIKON.LUA FOR THE CAMERA TO BE ABLE TO TAKE ANY PHOTOS, THE NUMBER OF THE CHANNEL BELOW WILL UPLOAD
TO THE MATCHING NUMBER IN YOUR WEBHOOK TABLE IN YOUR SERVER/NIKON.LUA

This table contains the upload channels or image spaces that players can link their camera too to upload pictures to both discord and for other
players to view in city. Out of the box, the first image space will be the one that is posted when a user takes ANY photo in the city, whether or not
they ultimately choose to upload it to an image space, and should be linked to a hidden webhook in the discord that staff are able to see but other users are
not to try and prevent metagaming photos users did not actually post.

To create a custom image space for users to upload too, you can use the following template showing an example of creating a webhook for a military job
in our city:

    [7] = {
        Path = 'SANG_NSS/GEN', -- lets name our image space, we'll shorten San Andreas National Guard Nikoff Secure Space to SANG_NSS
        Password = 'getsome', -- lets set a password so that not all members of our job can get to it
        Job = 'armynationalguard' -- we can use the name of our job to limit it to that job
        Type = 'military' -- we can set a job type if we want to use, maybe we have multiple national guard jobs
        Auth = 'SANG' -- we can also create a custom auth function in the config, and then set the Auth field to it
    }

--]]------------------------------------------

Config.Camera = {
    [1] = {Path = 'LOCAL STORAGE'}, -- do not remove the default upload, this serves as local storage for the camera to save onto the camera item/sd card WITHOUT uploading it
    [2] = {Path = 'NIKOFF IMAGE SPACE', Password = nil, Auth = 'LEO'}, -- this is a public webhook/image space for civilians to use the camera for, not required but recommended
    --[3] = {Path = 'SA_NSS/GENERAL/', Password = nil, Auth = 'LEO'},
    --[4] = {Path = 'SA_NSS/DRUGTASKFORCE/', Password = 'password123', Auth = 'LEO'},
    --[5] = {Path = 'SA_NSS/INVESTIGATIONS/', Password = 'password1234', Auth = 'LEO'},
    --[6] = {Path = 'SA_NSS/MEDICAL/', Password = 'password123', Auth = 'EMS'},
    --[7] = {Path = 'WEAZEL_NSS/BREAKING', Password = 'thetruth', Job = 'reporter'}, -- this is a private webhook for the reporter job, you can make job-specific webhooks using this method
}

Config.Notification = {
    ClutterReminder = 'Забелязвате, че превозното средство е пълно с боклук и безпорядък.',
    Clipboard = 'Копирахте %s', -- requires one %s for copied text
    NoTarget = 'Няма никой окло Вас!',
    Evading = "Избягаха.. Мамка му..!", -- suspect attempting to flee a test/investigation
    NoEvidence = 'Не са открити никакви доказателства в %s', -- requires one %s for plate
    Bleed = 'Кръвта се стича от раната Ви и се чувствате по зле.',
    CancelEvidenceClear = "Дори не можете да го направите както трябва?",
    Unlock = "Превозното средство е отключено!",
    IncorrectJob = 'Това е предназначено само за спешни услуги',
    Overweight = "Нямате място в джобовете си, за да носите тези доказателства!",
    NoBag = "Не разполагате с плик за доказателства, в който да ги приберете!",
    NoTamper = "Не забелязвате нищо необичайно в Граждански номер%s", -- requires one %s for plate
    CantBleed = 'Не можете да направите това толкова скоро, моля, изчакайте',
    LeftFingerprint = 'Притискате пръста си към външната част на автомобила и оставяте отпечатък.',
    Gloves = 'Този човек е с ръкавици',
    GottenGloves = 'Изглежда, че този човек носи ръкавици???',
    NoWeapon = 'Не изглежда да държите оръжие',
    CleanWeapon = 'Почиствате оръжието възможно най-добре...',
    WipeWeapon = 'Избърсвате оръжието, доколкото можете...',
    WipedDownArea = 'Избърсахте района, доколкото можахте...',
    UploadedToMDT = 'Снимката е качена в Доклад %s', -- requires one %s for the report number
    UploadedToImageSpace = 'Снимката е качена в %s', -- requires one %s for the image space name
    DidNotFindReport = 'Не съществува Рапорт с номер # , опитайте отново.' -- for when upload to MDT fails to find an incident number
}

-- this is the table used to preform job checking functions, if you are using a custom name or
-- job type, please add it to the Job/Type arrays so that they have access to those functions

Config.AuthorizedJobs = {
    LEO = { -- this is for job checks which should only return true for police officers
        Jobs = {['police'] = true, ['bcso'] = true, ['pbso'] = true, ['sahp'] = true, ['sapr'] = true, ['sast'] = true, ['sasp'] = true},
        Types = {['police'] = true, ['leo'] = true},
        Check = function(source)
            local PlyData = nil

            if source then PlyData = Config.Functions.PlayerDataServer(source) else PlyData = Config.Functions.PlayerDataClient() end

            local job, jobtype = PlyData.job, PlyData.jobtype

            if Config.AuthorizedJobs.LEO.Jobs[job] or Config.AuthorizedJobs.LEO.Types[jobtype] then return true end
        end
    },
    EMS = { -- this if for job checks which should only return true for ems workers
        Jobs = {['ambulance'] = true, ['fire'] = true},
        Types = {['ambulance'] = true, ['fire'] = true, ['ems'] = true},
        Check = function(source)
            local PlyData = nil
            if source then PlyData = Config.Functions.PlayerDataServer(source) else PlyData = Config.Functions.PlayerDataClient() end

            local job, jobtype = PlyData.job, PlyData.jobtype

            if Config.AuthorizedJobs.EMS.Jobs[job] or Config.AuthorizedJobs.EMS.Types[jobtype] then return true end
        end
    },
    FirstResponder = { -- do not touch, this is a combined job checking function for emergency services (police and ems)
        Check = function(source)
            local PlyData = nil
            if source then PlyData = Config.Functions.PlayerDataServer(source) else PlyData = Config.Functions.PlayerDataClient() end

            local job, jobtype = PlyData.job, PlyData.jobtype

            if Config.AuthorizedJobs.LEO.Check() or Config.AuthorizedJobs.EMS.Check() then return true end
        end
    },
    Frisk = { -- this is for configuring the frisk job check, you can enable it for all civlians, or specific jobs
        All = false, -- set this to true if you want everyone to have access to frisk
        Jobs = {['police'] = true, ['bcso'] = true, ['pbso'] = true, ['sahp'] = true, ['sapr'] = true, ['sast'] = true, ['sasp'] = true, ['ambulance'] = true},
        Types = {['police'] = true, ['leo'] = true},
        Check = function(source)
            local PlyData = nil
            if source then PlyData = Config.Functions.PlayerDataServer(source) else PlyData = Config.Functions.PlayerDataClient() end

            local job, jobtype, rank = PlyData.job, PlyData.jobtype, PlyData.jobgrade

            if Config.AuthorizedJobs.Frisk.All then return true end
            if type(Config.AuthorizedJobs.Frisk.Jobs[job]) == 'table' then if Config.AuthorizedJobs.Frisk.Jobs[job][rank] then return true end end
            if Config.AuthorizedJobs.LEO.Jobs[job] or Config.AuthorizedJobs.LEO.Types[jobtype] then return true end
        end,
    }
}

-- labels

Config.ImpactLabels = {
    [1950175060] = "Калибър на пистолет",
    [1820140472] = "Калибър на пистолет",
    [218444191] = "Калибър на автоматично",
    [1788949567] = "Калибър на автоматично",
    [`ammo_stungun`] = "Щифтове на тейзър",
    [-1878508229] = "Гилза от пушка",
    [1285032059] = "High-Caliber Rifle Round",
    [`weapon_musket`] = "Musket Ball?",
}

Config.StatusList = {
    ['fight'] = 'Натъртвания по ръцете',
    ['widepupils'] = 'Уголемени',
    ['redeyes'] = 'Зачервени очи',
    ['weedsmell'] = 'Миризма на трева',
    ['gunpowder'] = 'Барут по дрехите',
    ['chemicals'] = 'Миризма на химикали',
    ['heavybreath'] = 'Тежко дишане',
    ['sweat'] = 'Обилно потене',
    ['handbleed'] = 'Кръв по ръцете',
    ['confused'] = 'Замаяни и объркани',
    ['alcohol'] = 'Миризма на алкохол',
    ['heavyalcohol'] = 'Миризма на бъчва',
    ['bloody'] = 'Покрити с кръв',
    ['blox'] = 'Миризма на белина'
}

Config.CarStatusList = {
    ['widepupils'] = 'има уголемени зеници',
    ['redeyes'] = 'има зачервени очи',
    ['weedsmell'] = 'мирише на трева',
    ['gunpowder'] = 'следи от барут',
    ['chemicals'] = 'мирише на химикали',
    ['heavybreath'] = 'диша доста тежко',
    ['sweat'] = 'се поти обилно',
    ['confused'] = 'е замаян и объркан',
    ['alcohol'] = 'мирише на алкохол',
    ['heavyalcohol'] = 'мирише на бъчва',
    ['bloody'] = 'е покрит с кръв',
    ['blox'] = 'мирише на белина'
}

--[[---------- custom frisk table ----------

This list of items will result in a player using frisk positively detecting a weapon or contraband, it is highly recommended to only add items that would be large, bulky, or that would otherwise be
clearly 'detectable' even under a suspect's clothing. You should not add any drug item just because it a drug item, and should consider whether or not you could tell what it was in your pocket without
removing it

For real world reference, Minnesota v. Dickerson (1993), determined that officers could seize contraband that is immediately identifiable as contraband when touched under a 'plain touch' doctrine,
but that they could not legally seize contraband by "squeezing, sliding and otherwise manipulating the contents of the defendant’s pocket". This means you shouldn't make a joint discoverable via frisk,
but it might make sense if a crack pipe or coke brick was. If you make things too easy to discover, crims will no longer 'trust' that a Frisk is only a frisk for weapons, and your police will lose a
valuable tool!                                                                                                                                                                                              --]]

Config.FriskContrabandItems = {
    ['spikestrip'] = true
}

--------------------------------------------------------------------------------------------------------------
-----------------------------------        Custom Alert Functions       --------------------------------------
--[[----------------------------------------------------------------------------------------------------------

This config allows you to defind custom alerts that are triggered by specific events in the script, by default
there are alerts for gunshots, drivebys, melee fights, explosive devices, using the firework launcher, and use
of the access tool by non-police players. These events are current set up to trigger the native qb-policejob
alerts, and will need to modified to work with a thirdparty alert script!

--]]----------------------------------------------------------------------------------------------------------

Config.Alerts = { -- you can add custom code here to trigger your alert script
    Active = true, -- set to false if you don't want to use these
    Timeout = 10000, -- specify how long before the script will generate a second alert of that type
    ShotsFired = function()
        if math.random(1, 100) > 50 then
            TriggerServerEvent('police:server:policeAlert', "Shots Fired")
        end
    end,
    DriveBy = function()
        if math.random(1, 100) > 50 then
            TriggerServerEvent('police:server:policeAlert', "Shots Fired From Vehicle")
        end
    end,
    Melee = function()
        if math.random(1, 100) > 50 then
            TriggerServerEvent('police:server:policeAlert', "Fight In Progress")
        end
    end,
    ExplosiveDevice = function()
        if math.random(1, 100) > 20 then
            TriggerServerEvent('police:server:policeAlert', "Report of Explosive Device")
        end
    end,
    IllegalFireworks = function()
        if math.random(1, 100) > 70 then
            TriggerServerEvent('police:server:policeAlert', "Possible Illegal Fireworks")
        end
    end,
    VehicleTheft = function()
        if math.random(1, 100) > 60 then
            TriggerServerEvent('police:server:policeAlert', "Possible Vehicle Theft In Progress")
        end
    end,
}

--------------------------------------------------------------------------------------------------------------
-----------------------------------        Unique Weapon Tables         --------------------------------------
--------------------------------------------------------------------------------------------------------------

Config.NoGSRWeapon = { -- these weapons do not cause the GSR status effect on players
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_stungun`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_raypistol`] = true,
    [`weapon_raycarbine`] = true,
    [`weapon_railgun`] = true,
    [`weapon_rayminigun`] = true,
    [`weapon_grenade`] = true,
    [`weapon_bzgas`] = true,
    [`weapon_molotov`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_pipebomb`] = true,
    [`weapon_ball`] = true,
    [`weapon_smokegrenade`] = true,
    [`weapon_flare`] = true,
}

Config.NoCasingWeapon = { -- these weapons do not generate casings
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_raycarbine`] = true,
    [`weapon_musket`] = true,
    [`weapon_firework`] = true,
    [`weapon_railgun`] = true,
    [`weapon_rayminigun`] = true,
    [`weapon_molotov`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_pipebomb`] = true,
    [`weapon_ball`] = true,
    [`weapon_rpg`] = true,
    [`weapon_metaldetector`] = true,
}

Config.NoImpactWeapon = { -- these weapons do not generate impacts
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_grenade`] = true,
    [`weapon_bzgas`] = true,
    [`weapon_molotov`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_pipebomb`] = true,
    [`weapon_ball`] = true,
    [`weapon_smokegrenade`] = true,
    [`weapon_flare`] = true,
    [`weapon_flaregun`] = true,
}

Config.NoAlertWeapon = { -- these weapons do not trigger alerts and are ignored by the script
    [`weapon_snowball`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_ball`] = true,
    [`weapon_flare`] = true,
}

Config.ExplosiveDevice = { -- these weapons trigger explosive device alerts
    [`weapon_pipebomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_grenade`] = true,
    [`weapon_rpg`] = true,
    [`weapon_grenadelauncher`] = true,
    [`weapon_grenadelauncher_smoke`] = true,
    [`weapon_hominglauncher`] = true,
    [`weapon_compactlauncher`] = true,
    [`weapon_emplauncher`] = true,
}

Config.NonCasingWeapon = { -- when civlians view evidence, instead of displaing '9x19mm Casing', it displays these tags instead
    [`weapon_stungun`] = 'Taser AFID',
}

Config.LeftHandEject = { -- simulate leftward ejecting weapons
    [`weapon_mg`] = true,
}

Config.DownEject = { -- simulate downward ejecting weapons or weapons where the casing left behind
    [`weapon_flaregun`] = true,
    [`weapon_musket`] = true,
    [`weapon_stungun`] = true,
}

--------------------------------------------------------------------------------------------------------------
-------------------------------        Vehicle Fragment Color Names         ----------------------------------
--------------------------------------------------------------------------------------------------------------

-- In order to generate the names on vehicle fragments, this table defines the label each color uses. If you
-- have a custom mechanic or benny's script that uses different names, you can modify them here to match.

Config.Colours = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steel",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Black",
    ['16'] = "Black Poly",
    ['17'] = "Dark silver",
    ['18'] = "Silver",
    ['19'] = "Gun Metal",
    ['20'] = "Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Red",
    ['44'] = "Bright Red",
    ['45'] = "Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Dark Green",
    ['57'] = "Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Dark Blue",
    ['76'] = "Midnight Blue",
    ['77'] = "Blue",
    ['78'] = "Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Maui Blue Poly",
    ['81'] = "Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Brown",
    ['109'] = "Medium Brown",
    ['110'] = "Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black Steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "Police Car Blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metallic Dark Blue",
    ['147'] = "Black",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "Default Alloy Color",
    ['157'] = "Epsilon Blue",
    ['158'] = "Pure Gold",
    ['159'] = "Brushed Gold",
}

Config.Walks = { -- it's dumb but this list lets the script reset the walk for certain animations that override them
    [`move_m@alien`] = "move_m@alien",
    [`anim_group_move_ballistic`] = "anim_group_move_ballistic",
    [`move_f@arrogant@a`] = "move_f@arrogant@a",
    [`move_m@hurry_butch@a`] = "move_m@hurry_butch@a",
    [`move_m@hurry_butch@b`] = "move_m@hurry_butch@b",
    [`move_m@hurry_butch@c`] = "move_m@hurry_butch@c",
    [`move_m@buzzed`] = "move_m@buzzed",
    [`move_m@brave`] = "move_m@brave",
    [`move_m@brave@a`] = "move_m@brave@a",
    [`move_casey`] = "move_casey",
    [`move_m@casual@a`] = "move_m@casual@a",
    [`move_m@casual@b`] = "move_m@casual@b",
    [`move_m@casual@c`] = "move_m@casual@c",
    [`move_m@casual@d`] = "move_m@casual@d",
    [`move_m@casual@e`] = "move_m@casual@e",
    [`move_m@casual@f`] = "move_m@casual@f",
    [`move_f@chichi`] = "move_f@chichi",
    [`move_m@confident`] = "move_m@confident",
    [`move_m@business@a`] = "move_m@business@a",
    [`move_m@business@b`] = "move_m@business@b",
    [`move_m@business@c`] = "move_m@business@c",
    [`move_m@coward`] = "move_m@coward",
    [`move_chubby`] = "move_chubby",
    [`move_f@chubby@a`] = "move_f@chubby@a",
    [`move_characters@dave_n`] = "move_characters@dave_n",
    [`move_f@multiplayer`] = "move_f@multiplayer",
    [`move_m@multiplayer`] = "move_m@multiplayer",
    [`move_m@depressed@a`] = "move_m@depressed@a",
    [`move_m@depressed@b`] = "move_m@depressed@b",
    [`move_f@depressed@a`] = "move_f@depressed@a",
    [`move_f@depressed@c`] = "move_f@depressed@c",
    [`move_dreyfuss`] = "move_dreyfuss",
    [`move_m@drunk@a`] = "move_m@drunk@a",
    [`move_m@buzzed`] = "move_m@buzzed",
    [`move_m@drunk@moderatedrunk`] = "move_m@drunk@moderatedrunk",
    [`move_m@drunk@moderatedrunk_head_up`] = "move_m@drunk@moderatedrunk_head_up",
    [`move_m@drunk@slightlydrunk`] = "move_m@drunk@slightlydrunk",
    [`move_m@drunk@verydrunk`] = "move_m@drunk@verydrunk",
    [`move_m@fat@a`] = "move_m@fat@a",
    [`move_f@fat@a`] = "move_f@fat@a",
    [`move_m@fat@bulky`] = "move_m@fat@bulky",
    [`move_f@fat@a_no_add`] = "move_f@fat@a_no_add",
    [`move_f@femme@`] = "move_f@femme@",
    [`move_m@femme@`] = "move_m@femme@",
    [`move_characters@franklin@fire`] = "move_characters@franklin@fire",
    [`move_characters@michael@fire`] = "move_characters@michael@fire",
    [`move_m@fire`] = "move_m@fire",
    [`move_f@flee@a`] = "move_f@flee@a",
    [`move_f@flee@c`] = "move_f@flee@c",
    [`move_m@flee@a`] = "move_m@flee@a",
    [`move_m@flee@b`] = "move_m@flee@b",
    [`move_m@flee@c`] = "move_m@flee@c",
    [`move_characters@floyd`] = "move_characters@floyd",
    [`move_p_m_one`] = "move_p_m_one",
    [`move_m@gangster@generic`] = "move_m@gangster@generic",
    [`move_gangster`] = "move_gangster",
    [`move_m@gangster@ng`] = "move_m@gangster@ng",
    [`move_m@gangster@var_a`] = "move_m@gangster@var_a",
    [`move_m@gangster@var_b`] = "move_m@gangster@var_b",
    [`move_m@gangster@var_c`] = "move_m@gangster@var_c",
    [`move_m@gangster@var_d`] = "move_m@gangster@var_d",
    [`move_m@gangster@var_e`] = "move_m@gangster@var_e",
    [`move_m@gangster@var_f`] = "move_m@gangster@var_f",
    [`move_m@gangster@var_g`] = "move_m@gangster@var_g",
    [`move_m@gangster@var_h`] = "move_m@gangster@var_h",
    [`move_m@gangster@var_i`] = "move_m@gangster@var_i",
    [`move_m@gangster@var_j`] = "move_m@gangster@var_j",
    [`move_m@gangster@var_k`] = "move_m@gangster@var_k",
    [`move_m@generic`] = "move_m@generic",
    [`move_f@generic`] = "move_f@generic",
    [`anim@move_m@grooving@`] = "anim@move_m@grooving@",
    [`anim@move_f@grooving@`] = "anim@move_f@grooving@",
    [`move_m@prison_gaurd`] = "move_m@prison_gaurd",
    [`move_m@prisoner_cuffed`] = "move_m@prisoner_cuffed",
    [`move_f@heels@c`] = "move_f@heels@c",
    [`move_f@heels@d`] = "move_f@heels@d",
    [`move_m@hiking`] = "move_m@hiking",
    [`move_f@hiking`] = "move_f@hiking",
    [`move_m@hipster@a`] = "move_m@hipster@a",
    [`move_m@hobo@a`] = "move_m@hobo@a",
    [`move_m@hobo@b`] = "move_m@hobo@b",
    [`move_f@injured`] = "move_f@injured",
    [`move_m@injured`] = "move_m@injured",
    [`move_m@intimidation@1h`] = "move_m@intimidation@1h",
    [`move_m@intimidation@cop@unarmed`] = "move_m@intimidation@cop@unarmed",
    [`move_m@intimidation@unarmed`] = "move_m@intimidation@unarmed",
    [`move_p_m_zero_janitor`] = "move_p_m_zero_janitor",
    [`move_p_m_zero_slow`] = "move_p_m_zero_slow",
    [`move_characters@jimmy`] = "move_characters@jimmy",
    [`move_m@jog@`] = "move_m@jog@",
    [`move_characters@lamar`] = "move_characters@lamar",
    [`anim_group_move_lemar_alley`] = "anim_group_move_lemar_alley",
    [`move_heist_lester`] = "move_heist_lester",
    [`move_lester_caneup`] = "move_lester_caneup",
    [`move_f@maneater`] = "move_f@maneater",
    [`move_ped_bucket`] = "move_ped_bucket",
    [`move_m@money`] = "move_m@money",
    [`move_m@muscle@a`] = "move_m@muscle@a",
    [`move_characters@jimmy@nervous@`] = "move_characters@jimmy@nervous@",
    [`move_characters@patricia`] = "move_characters@patricia",
    [`move_paramedic`] = "move_paramedic",
    [`move_m@posh@`] = "move_m@posh@",
    [`move_f@posh@`] = "move_f@posh@",
    [`move_m@quick`] = "move_m@quick",
    [`move_characters@ron`] = "move_characters@ron",
    [`female_fast_runner`] = "female_fast_runner",
    [`move_m@sad@a`] = "move_m@sad@a",
    [`move_m@sad@b`] = "move_m@sad@b",
    [`move_m@sad@c`] = "move_m@sad@c",
    [`move_f@sad@a`] = "move_f@sad@a",
    [`move_f@sad@b`] = "move_f@sad@b",
    [`move_m@sassy`] = "move_m@sassy",
    [`move_f@sassy`] = "move_f@sassy",
    [`move_f@scared`] = "move_f@scared",
    [`move_f@sexy@a`] = "move_f@sexy@a",
    [`move_m@shadyped@a`] = "move_m@shadyped@a",
    [`move_characters@jimmy@slow@`] = "move_characters@jimmy@slow@",
    [`move_f@stripper@a`] = "move_f@stripper@a",
    [`move_m@swagger`] = "move_m@swagger",
    [`move_m@swagger@b`] = "move_m@swagger@b",
    [`move_m@tough_guy@`] = "move_m@tough_guy@",
    [`move_f@tough_guy@`] = "move_f@tough_guy@",
    [`move_m@tool_belt@a`] = "move_m@tool_belt@a",
    [`move_f@tool_belt@a`] = "move_f@tool_belt@a",
    [`clipset@move@trash_fast_turn`] = "clipset@move@trash_fast_turn",
    [`missfbi4prepp1_garbageman`] = "missfbi4prepp1_garbageman",
    [`move_characters@tracey`] = "move_characters@tracey",
    [`move_p_m_two`] = "move_p_m_two",
    [`move_m@leaf_blower`] = "move_m@leaf_blower",
    [`move_m@bag`] = "move_m@bag",
}

--------------------------------------------------------------------------------------------------------------
-------------------------------        MP Freemode Ped Gloves Table         ----------------------------------
--[[----------------------------------------------------------------------------------------------------------

By default, the multiplayer male & female models are considered to be wearing gloves when using the included
fingerprint creation event. If you have a custom EUP that modifies the arm components for these peds, you must
manually define which components DO NOT have gloves. If you have not modified the arm components for mp_freemode
peds you do not have to alter this table.

--]]--------------------------------------

Config.NoGloves = {
    [`mp_m_freemode_01`] = {
        [0] = true,
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
        [13] = true,
        [14] = true,
        [15] = true,
        [17] = true,
        [18] = true,
        [19] = true,
        [20] = true,
        [21] = true,
        [23] = true,
        [24] = true,
        [25] = true,
        [26] = true,
        [27] = true,
        [28] = true,
        [31] = true,
        [65] = true,
        [66] = true,
        [67] = true,
        [68] = true,
        [69] = true,
        [70] = true,
        [71] = true,
        [72] = true,
        [73] = true,
        [74] = true,
        [75] = true,
        [76] = true,
        [125] = true,
        [126] = true,
        [127] = true,
        [131] = true,
        [138] = true,
        [145] = true,
        [149] = true,
        [150] = true,
        [154] = true,
        [155] = true,
        [156] = true,
        [166] = true,
        [167] = true,
        [197] = true,
        [201] = true,
        [215] = true,
        [216] = true,
        [217] = true,
        [218] = true,
        [219] = true,
        [220] = true,
        [221] = true,
        [222] = true,
        [223] = true,
        [224] = true,
        [225] = true,
        [226] = true,
        [227] = true,
        [228] = true,
        [229] = true,
        [230] = true,
        [231] = true,
        [232] = true,
        [233] = true,
        [235] = true,
        [236] = true,
        [237] = true,
    },
    [`mp_f_freemode_01`] = {
        [0] = true,
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
        [13] = true,
        [14] = true,
        [15] = true,
        [19] = true,
        [22] = true,
        [23] = true,
        [24] = true,
        [25] = true,
        [26] = true,
        [27] = true,
        [28] = true,
        [29] = true,
        [30] = true,
        [31] = true,
        [32] = true,
        [33] = true,
        [34] = true,
        [35] = true,
        [36] = true,
        [37] = true,
        [38] = true,
        [39] = true,
        [40] = true,
        [41] = true,
        [42] = true,
        [43] = true,
        [44] = true,
        [45] = true,
        [46] = true,
        [47] = true,
        [48] = true,
        [49] = true,
        [50] = true,
        [51] = true,
        [52] = true,
        [53] = true,
        [54] = true,
        [55] = true,
        [56] = true,
        [57] = true,
        [58] = true,
        [59] = true,
        [60] = true,
        [63] = true,
        [64] = true,
        [65] = true,
        [66] = true,
        [67] = true,
        [68] = true,
        [70] = true,
        [79] = true,
        [80] = true,
        [81] = true,
        [82] = true,
        [87] = true,
        [92] = true,
        [99] = true,
        [100] = true,
        [101] = true,
        [102] = true,
        [117] = true,
        [122] = true,
        [123] = true,
        [124] = true,
        [125] = true,
        [126] = true,
        [127] = true,
        [128] = true,
        [129] = true,
        [173] = true,
        [174] = true,
        [175] = true,
        [197] = true,
        [213] = true,
        [214] = true,
        [215] = true,
        [216] = true,
        [217] = true,
        [218] = true,
        [248] = true,
        [273] = true,
        [288] = true,
        [305] = true,
        [306] = true,
        [307] = true,
    },
}

--------------------------------------------------------------------------------------------------------------
--------------------------------             Car Wash Config             -------------------------------------
--[[----------------------------------------------------------------------------------------------------------

This config enables you to place carwashes across the city which will allow players to both clean the exteriors of
their car, as well as clean the interior of their vehicle of any evidence which may be contained in it. Simply specify
a vector3 coord and heading.

--]]--------------------------------------

Config.CarWash = {
    Settings = {
        usePoly = true, -- will use polyzone to create car washes, false it will distance check
        use3Dtext = false, -- will use 3D world text to draw carwash
        useQBdrawtext = false, -- will use built in QB draw text function
        useOXdrawtext = true, -- will use ox_lib text UI
        Price = 50,
        Label3D = '~g~E ~w~- Use Car Wash',
        Label2D = '[E] - Автомивка',
        debugPoly = false, -- set to true if you want to draw polyzones
    },
    -- Blip = {
    --     Sprite = 100,
    --     Scale = 0.75,
    --     Color = 37,
    --     Name = 'Автомивка',
    -- },
    Interior = {
        Label = 'Детайлинг',
        Description = 'Прахосмучене и почистване!',
    },
    Exterior = {
        Label = 'Измиване',
        Description = 'Измиване и нанасяне на вакса',
    },
    Locations = {
        [1] = {
            Coords = vector3(174.81, -1736.77, 28.87),
            Heading = 359, -- REQUIRED IF USING POLYZONE
            Length = 10, -- OPTIONAL, specify the length of the polyzone
            Width = 8, -- OPTIONAL, specify the width of the polyzone
        },
        [2] = {
            Coords = vector3(25.2, -1391.98, 28.91),
            Heading = 90,
            Length = 20,
            Width = 3,
        },
        [3] = {
            Coords = vector3(-74.27, 6427.72, 31.02),
            Heading = 315,
        },
        [4] = {
            Coords = vector3(1362.69, 3591.81, 34.5),
            Heading = 21,
        },
        [5] = {
            Coords = vector3(-699.84, -932.68, 18.59),
            Heading = 0,
        },
    },
}

--------------------------------------------------------------------------------------------------------------
--------------------------------        Default Ped Gloves Table         -------------------------------------
--[[----------------------------------------------------------------------------------------------------------

By default, peds which are not the multiplayer male & female models are considered to not wear gloves, you must
defind both the specific ped and the specific arm component in this table for the fingerprint creation function
to register that a default ped is wearing gloves.

--]]--------------------------------------

Config.Gloves = {
    [`ig_chef`] = {
        [0] = true,
        [1] = true,
    },
    [`ig_clay`] = {
        [0] = true,
        [1] = true,
    },
    [`ig_talina`] = {
        [0] = true,
        [1] = true,
    },
    [`a_m_m_tranvest_01`] = { -- i know this an outdated term, but it's the name of the model
        [0] = true,
        [1] = true,
    },
    [`a_m_y_dhill_01`] = {
        [0] = true,
        [1] = true,
    },
    [`a_m_y_motox_01`] = {
        [0] = true,
        [1] = true,
    },
    [`a_m_y_motox_02`] = {
        [0] = true,
        [1] = true,
    },
    [`g_m_m_chemwork_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_CHEMSEC_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_DOCKWORK_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_GAFFER_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_GARDENER_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_MIGRANT_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_MOVSPACE_01`] = {
        [0] = true,
        [1] = true,
    },
    [`S_M_M_PILOT_02`] = {
        [0] = true,
        [1] = true,
    },
    [`a_f_m_prolhost_01`] = {
        [0] = true,
        [1] = true,
    }
}

-----------------------------------------------------------------------------------------------------------
--------------------------------        Custom Function Configs         -----------------------------------
--[[-------------------------------------------------------------------------------------------------------

This table allows us to define the custom functions which enable framework compatability and allows you to modify
your notification and chat functions. By default, framework dependent functions are defined for QBCore and ESX
out of the box, and supports both qb-inventory compatabile scripts and ox_inventory by default.

--]]------------------------------------------

Config.Functions = {
    Chat = function(args) -- this should be used from the server to trigger a chat message
        TriggerEvent('chat:addMessage', args)
    end,
    ServerNotify = function(target, string, notifytype) -- this should be used to trigger player notifications from the server
        if Config.Framework.Ox or Config.Framework.ESX then
            TriggerClientEvent('evidence:client:notify', target, string, notifytype, 'top-right')
        elseif Config.Framework.QB then
            TriggerClientEvent('QBCore:Notify', target, string, notifytype)
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    AddItem = function(source, item, amount, slot, data, nobox) -- this function adds an item to inventory
        if Config.Inventory.Ox then
            local success, response = ox_inventory:AddItem(source, item, amount, data, slot)

            if success then return true end
        elseif Config.Inventory.QB then
            local Player = QBCore.Functions.GetPlayer(source)

            if not nobox then TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add") end

            return Player.Functions.AddItem(item, amount, slot, data)
        elseif Config.Inventory.QSV1 then
            local Player = QS.GetPlayerFromId(source)
            data.showAllDescriptions = true

            if not nobox then TriggerClientEvent("inventory:client:ItemBox", source, QS.Shared.Items[item], "add") end

            return Player.addItem(item, amount, slot, data)
        elseif Config.Inventory.QSV2 then
            return exports['qs-inventory']:AddItem(source, item, amount, slot, data)
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    RemoveItem = function(source, item, amount, slot, nobox) -- removes an item from the player inventory
        if Config.Inventory.Ox then
            local success = ox_inventory:RemoveItem(source, item, amount, false, slot)

            if success then return true end
        elseif Config.Inventory.QB then
            local Player = QBCore.Functions.GetPlayer(source)

            if not nobox then TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove") end

            return Player.Functions.RemoveItem(item, amount, slot)
        elseif Config.Inventory.QSV1 then
            local Player = QS.GetPlayerFromId(source)

            if not nobox then TriggerClientEvent("inventory:client:ItemBox", source, QS.Shared.Items[item], "remove") end

            return Player.removeItem(item, amount, slot)
        elseif Config.Inventory.QSV2 then
           return exports['qs-inventory']:RemoveItem(source, item, amount, slot)
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    UpdateMetadata = function(source, slot, data) -- this function is used to update an items metadata
        if Config.Inventory.Ox then
            ox_inventory:SetMetadata(source, slot, data)
        elseif Config.Inventory.QB then
            local Player = QBCore.Functions.GetPlayer(source)

            Player.PlayerData.items[slot].info = data

            Player.Functions.SetInventory(Player.PlayerData.items, true)
        elseif Config.Inventory.QSV1 then
            local Player = QS.GetPlayerFromId(source)
			local items = Player.GetInventory()

            items[slot].info = data

            Player.SetInventory(items)
        elseif Config.Inventory.QSV2 then
            exports['qs-inventory']:SetItemMetadata(source, slot, data)
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    GetInventoryServer = function(source) -- this function should return the player inventory table
        if Config.Inventory.Ox then
            return ox_inventory:GetInventory(source)?.items
        elseif Config.Inventory.QB then
            local Player = QBCore.Functions.GetPlayer(source)

            return Player.PlayerData.items
        elseif Config.Inventory.QSV1 then
            local Player = QS.GetPlayerFromId(source)

            return Player.GetInventory()
        elseif Config.Inventory.QSV2 then
            return exports['qs-inventory']:GetInventory(source)
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    RegisterCallback = function(name, cbfunc)
        if Config.Framework.ESX then
            ESX.RegisterServerCallback(name, cbfunc)
        elseif Config.Framework.QB then
            QBCore.Functions.CreateCallback(name, cbfunc)
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    PlayerDataServer = function(source) -- gets player data on server
        if Config.Framework.ESX then
            local PlyData = ESX.GetPlayerFromId(source)

            local PlayerData = {
                identifier = PlyData.identifier,
                citizenid = nil,
                bloodtype = nil,
                fingerprint = nil,
                firstname = PlyData.variables.firstName,
                lastname = PlyData.variables.lastName,
                job = PlyData.job.name,
                jobgrade = PlyData.job.grade,
            }

            return PlayerData
        elseif Config.Framework.QB then
            local PlyData = QBCore.Functions.GetPlayer(source).PlayerData

            local PlayerData = {
                identifier = PlyData.citizenid,
                citizenid = PlyData.citizenid,
                bloodtype = PlyData.metadata.bloodtype,
                fingerprint = PlyData.metadata.fingerprint,
                firstname = PlyData.charinfo.firstname,
                lastname = PlyData.charinfo.lastname,
                job = PlyData.job.name,
                jobgrade = tostring(PlyData.job.grade.level),
                jobtype = PlyData.job.type,
            }

            return PlayerData
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    CreateUseableItem = function(name, cbfunc)
        if Config.Inventory.Ox then
            exports(name, cbfunc)
        elseif Config.Inventory.QB then
            QBCore.Functions.CreateUseableItem(name, cbfunc)
        elseif Config.Inventory.QSV1 then
            QS.RegisterUsableItem(name, cbfunc)
        elseif Config.Inventory.QSV2 then
            exports['qs-inventory']:CreateUsableItem(name, cbfunc)
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    CreateCommand = function(name, suggestion, args, reqargs, cbfunc, permission)
        if Config.Framework.ESX then
            RegisterCommand(name, cbfunc, permission)
            -- ESX.RegisterCommand(name, permission or 'user', cbfunc, true, {help = suggestion}, args)
        elseif Config.Framework.QB then
            QBCore.Commands.Add(name, suggestion, args, reqargs, cbfunc, permission or 'user')
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    RemoveMoney = function(src, price, reason)
        if Config.Framework.ESX then
            local xPlayer = ESX.GetPlayerFromId(src)

            if xPlayer.getMoney() >= price then
                xPlayer.removeMoney(price)
                return true
            elseif xPlayer.getAccount('bank').money >= price then
                xPlayer.removeAccountMoney('bank', price)
                return true

            else
                Config.Functions.ServerNotify(src, 'You do not have enough to do this!', 'error')
                return false
            end
        elseif Config.Framework.QB then
            local Player = QBCore.Functions.GetPlayer(src)

            if Player.Functions.RemoveMoney('cash', price, reason) or Player.Functions.RemoveMoney('bank', price, reason) then
                TriggerClientEvent('qb-carwash:client:washCar', src)
                return true
            else
                Config.Functions.ServerNotify(src, 'You do not have enough to do this!', 'error')
                return false
            end
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,

    -- these are client functions

    Notify = function(string, notifytype) -- used from the client to trigger a notification
        if Config.Framework.Ox or Config.Framework.ESX then
            lib.notify({
                id = 'evnotify',
                title = string,
                position = 'top-right',
                type = notifytype,
            })
        elseif Config.Framework.QB then
            QBCore.Functions.Notify(string, notifytype)
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    SearchInventoryClient = function(item, results) -- this function can be used to find an item in your inventory
        if Config.Inventory.Ox then
            local found = false

            if ox_inventory:Search('count', item) > 0 then found = true end

            if results then found = ox_inventory:Search('slots', item) end

            return found
        elseif Config.Inventory.QB then
            local found = false
            local PlayerData = QBCore.Functions.GetPlayerData()

            for k, v in pairs(PlayerData.items) do
                if v.name == item then found = true end
            end

            if results then found = PlayerData.items end

            return found
        elseif Config.Inventory.QSV1 then
            local found = false
            local PlayerData = QS.GetPlayerData()

            for k, v in pairs(PlayerData.items) do
                if v.name == item then found = true end
            end

            if results then found = PlayerData.items end

            return found
        elseif Config.Inventory.QSV2 then
            local found = false
            local playerItems = exports['qs-inventory']:getUserInventory()

            for k, v in pairs(playerItems) do
                if v.name == item then found = true end
            end

            if results then found = PlayerData.items end

            return found
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    GetPlate = function(vehicle) -- gets trimmed plate on client or server
        local plate = GetVehicleNumberPlateText(vehicle)

        if vehicle == 0 then return end
        if not plate then return end

        return (string.gsub(plate, '^%s*(.-)%s*$', '%1'))
    end,
    CheckDead = function() -- checks if player is dead on client
        if Config.Framework.Ox then
            -- wip
        elseif Config.Framework.ESX then
            local isDead = nil

            ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(dead)
                isDead = dead and true or false
            end)

            if isDead ~= false or isDead ~= true then Wait(100) end

            return isDead
        elseif Config.Framework.QB then
            local PlayerData = QBCore.Functions.GetPlayerData()
            local isDead = false

            if PlayerData.metadata['inlaststand'] or PlayerData.metadata['isdead'] then isDead = true end

            return isDead
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    TriggerCallback = function(name, cbfunc, var)
        if Config.Framework.ESX then
            ESX.TriggerServerCallback(name, cbfunc, var)
        elseif Config.Framework.QB then
            QBCore.Functions.TriggerCallback(name, cbfunc, var)
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
        if not next(prop) then prop = nil end
        if not next(propTwo) then propTwo = nil end
        if prop and propTwo then prop = {prop, propTwo} end

        if Config.Framework.Ox or Config.Framework.ESX then
            if lib.progressBar({
                duration = duration,
                label = label,
                useWhileDead = useWhileDead,
                canCancel = canCancel,
                disable = {
                    move = disableControls?.disableMovement,
                    car = disableControls?.disableCarMovement,
                    combat = disableControls?.disableCombat,
                    mouse = disableControls?.disableMouse,
                },
                anim = {
                    dict = animation?.animDict,
                    clip = animation?.anim,
                    flag = animation?.flags,
                },
                prop = prop,
            }) then onFinish() else onCancel() end
        elseif Config.Framework.QB then
            QBCore.Functions.Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    PlayerDataClient = function()
        if Config.Framework.ESX then
            local PlyData = ESX.GetPlayerData()

            local PlayerData = {
                identifier = PlyData.identifier,
                citizenid = nil, -- the script will generate a unique citizen id for each character based on the unique character identifier
                bloodtype = nil, -- the script will assign a bloodtype for each character based on the unique character identifier
                fingerprint = nil, -- the script will generate a unique fingerprint for each character based on the unique character identifier
                firstname = PlyData.firstName,
                lastname = PlyData.lastName,
                job = PlyData.job?.name,
                jobgrade = PlyData.job?.grade,
            }

            return PlayerData
        elseif Config.Framework.QB then
            local PlyData = QBCore.Functions.GetPlayerData()

            local PlayerData = {
                identifier = PlyData.citizenid,
                citizenid = PlyData.citizenid,
                bloodtype = PlyData.metadata.bloodtype,
                fingerprint = PlyData.metadata.fingerprint,
                firstname = PlyData.charinfo.firstname,
                lastname = PlyData.charinfo.lastname,
                job = PlyData.job.name,
                jobgrade = tostring(PlyData.job.grade.level),
                jobtype = PlyData.job.type,
            }

            return PlayerData
        elseif Config.Framework.Standalone then
            -- there is nothing here, you must write it
        end
    end,
    GetCaliber = function(weapon)
        if Config.UseConfigCalibers or Config.Inventory.QSV1 or Config.Inventory.QSV2 then return Config.Calibers[weapon] end

        if Config.Inventory.Ox then
            if not OxWeapons then
                OxWeapons = {}
                for k, v in pairs(exports.ox_inventory:Items()) do if v.weapon then OxWeapons[v.hash or joaat(k)] = v.caliber end end
            end

            local caliber = OxWeapons and OxWeapons[weapon] or 'Unknown'

            return caliber
        elseif Config.Framework.QB or Config.Inventory.QB then
            local caliber = QBCore.Shared.Weapons[weapon] and QBCore.Shared.Weapons[weapon].caliber or 'Unknown'

            return caliber
        elseif Config.Inventory.Standalone then
            -- there is nothing here, you must write it
        end
    end,
}

-----------------------------------------------------------------------------------------------------------
-----------------------------        OPTIONAL Caliber Table Configs         -------------------------------
--[[-------------------------------------------------------------------------------------------------------

If you really do not want to modify your qb-core/shared/weapons.lua or ox_inventory/data/weapons.lua you can use this table to set
your calibers. You will need to modify this table WHENEVER you add a weapon to your server, the script will check if it's in this table
and if it is not it will yell at you. I don't want to see tickets about what does this mean when the script tells you waht you need to do.

--]]------------------------------------------

Config.UseConfigCalibers = true

Config.Calibers = {
	[`weapon_pistol`] 				 = '9x19mm Parabellum',
	[`weapon_pistol_mk2`] 			 = '9x19mm Parabellum',
	[`weapon_combatpistol`] 		 = '9x19mm Parabellum',
	[`weapon_appistol`] 			 = '9x19mm Parabellum',
	[`weapon_stungun`] 				 = 'TASER AFID',
	[`weapon_pistol50`] 			 = '.50 Action Express',
	[`weapon_snspistol`] 			 = '.40 S&W',
	[`weapon_snspistol_mk2`] 	     = '.40 S&W',
	[`weapon_heavypistol`] 			 = '.45 ACP',
	[`weapon_vintagepistol`] 		 = '.32 ACP',
	[`weapon_flaregun`] 			 = '25mm Flare',
	[`weapon_marksmanpistol`] 		 = '.45-70 Government',
	[`weapon_revolver`] 			 = '.357 Magnum',
	[`weapon_revolver_mk2`] 		 = '.44 Magnum',
	[`weapon_doubleaction`] 	     = '.38 Long Colt',
	[`weapon_raypistol`]			 = nil,
	[`weapon_ceramicpistol`]		 = '9x19mm Parabellum',
	[`weapon_navyrevolver`]        	 = '.38 Centerfire',
	[`weapon_gadgetpistol`] 		 = '9x19mm Parabellum',
	[`weapon_stungun_mp`] 			 = 'Taser AFID',
	[`weapon_microsmg`] 			 = '9x19mm Parabellum',
	[`weapon_smg`] 				 	 = '9x19mm Parabellum',
	[`weapon_smg_mk2`] 				 = '9x19mm Parabellum',
	[`weapon_assaultsmg`] 			 = '9x19mm Parabellum',
	[`weapon_combatpdw`] 			 = '9x19mm Parabellum',
	[`weapon_machinepistol`] 		 = '9x19mm Parabellum',
	[`weapon_minismg`] 				 = '9x19mm Parabellum',
	[`weapon_raycarbine`]	         = 'Laser Dust????',
	[`weapon_pumpshotgun`] 			 = '12 Gauge',
	[`weapon_pumpshotgun_mk2`]		 = '12 Gauge',
	[`weapon_sawnoffshotgun`] 		 = '12 Gauge',
	[`weapon_assaultshotgun`] 		 = '12 Gauge',
	[`weapon_bullpupshotgun`] 		 = '12 Gauge',
	[`weapon_musket`] 			     = 'A Percussion Cap?',
	[`weapon_heavyshotgun`] 		 = '12 Gauge',
	[`weapon_dbshotgun`] 			 = '12 Gauge',
	[`weapon_autoshotgun`] 			 = '12 Gauge',
	[`weapon_combatshotgun`]		 = '12 Gauge',
	[`weapon_assaultrifle`] 		 = '7.62x39mm Soviet',
	[`weapon_assaultrifle_mk2`] 	 = '7.62x39mm Soviet',
	[`weapon_carbinerifle`] 		 = '5.56x45mm NATO',
    [`weapon_carbinerifle_mk2`] 	 = '5.56x45mm NATO',
	[`weapon_advancedrifle`] 		 = '5.56x45mm NATO',
	[`weapon_specialcarbine`] 		 = '5.56x45mm NATO',
	[`weapon_specialcarbine_mk2`]	 = '5.56x45mm NATO',
	[`weapon_bullpuprifle`] 		 = '5.8×42mm DBP87',
	[`weapon_bullpuprifle_mk2`]		 = '5.8×42mm DBP87',
	[`weapon_compactrifle`] 		 = '7.62x39mm Soviet',
	[`weapon_militaryrifle`]		 = '5.56x45mm NATO',
    [`weapon_heavyrifle`] 			 = '5.56x45mm NATO',
	[`weapon_mg`] 					 = '7.62x51mm NATO',
	[`weapon_combatmg`] 			 = '7.62x51mm NATO',
	[`weapon_combatmg_mk2`]	 		 = '.45 ACP',
	[`weapon_gusenberg`] 			 = '7.62x51mm NATO',
	[`weapon_sniperrifle`] 			 = '.310 Win Mag',
	[`weapon_heavysniper`] 			 = '.50 BMG',
	[`weapon_heavysniper_mk2`]		 = '.50 BMG',
	[`weapon_marksmanrifle`] 		 = '7.76x51mm NATO',
	[`weapon_marksmanrifle_mk2`]	 = '7.76x51mm NATO',
	[`weapon_remotesniper`] 		 = '.50 BMG',
	[`weapon_rpg`] 					 = nil,
	[`weapon_grenadelauncher`] 		 = '40mm Grenade',
	[`weapon_grenadelauncher_smoke`] = '40mm Grenade',
	[`weapon_minigun`] 				 = '5.56x45mm NATO',
	[`weapon_firework`] 			 = 'Firework Packaging',
	[`weapon_railgun`] 				 = nil,
	[`weapon_hominglauncher`] 		 = nil,
	[`weapon_compactlauncher`] 		 = '40mm Grenade',
	[`weapon_rayminigun`]			 = 'Laser Dust???',
    [`weapon_emplauncher`] 			 = '40mm Grenade',
	[`weapon_grenade`] 		        = 'Grenade Pin',
	[`weapon_bzgas`] 		        = 'Grenade Pin',
	[`weapon_molotov`] 		        = nil,
	[`weapon_stickybomb`] 	        = nil,
	[`weapon_proxmine`] 	        = nil,
	[`weapon_snowball`] 	        = nil,
	[`weapon_pipebomb`] 	        = nil,
	[`weapon_ball`] 		        = nil,
	[`weapon_smokegrenade`]         = 'Grenade Pin',
	[`weapon_flare`] 		        = 'Flare Cap',
    [`WEAPON_PRECISIONRIFLE`]       = '.223 Remington',
    [`WEAPON_TACTICALRIFLE`]        = '5.56x45mm NATO',
}

--------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------                      Developer's Note                      -------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
----  This script is a love letter to cops & robbers roleplay that makes a lot of FiveM a unique experience, I appreciate every single one    ----
----  of you who has spent their hard earned money on r14-evidence and will work hard to continue making sure this script is as good of a     ----
----  possible value as it can be for the communities which use it. I hope every police roleplayer who gets to use this script enjoys it and  ----
----  appreciates the thousands of hours of work that have gone into improving the LEO experience on FiveM for them so they can bring the     ----
----  best possible roleplay to their communities!                                                                                            ----
----                                                                                                                                          ----
----  A portion of the proceeds from the sale of this script go to support Campaign Zero, RAICES, and the Anti Police-Terror Project. If      ----
----  you enjoy this script, and FiveM roleplay, but are concerned about the effect of policing on the maginalized and working-class please   ----
----  consider donating a few dollars to help hold real-world law enforcement to the same standards as our LEO roleplayers.                   ----
----                                                                                                                              - r14       ----
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
----                                                                                                                                          ----
----  Campaign Zero // https://campaignzero.org/                                                                                              ----
----  A police reform campaign intended to promote policies ending policing-for-profit, reducing police-civlian contact                       ----
----  for minor crimes, and ending qualified immunity protecting officers who brutalize their communities from legal                          ----
----  consequences.                                                                                                                           ----
----                                                                                                                                          ----
----  RAICES // https://www.raicestexas.org/                                                                                                  ----
----  A non-profit which offers legal aid and support for immigrants and asylum seekers based in San Antonio, TX and which rightfully         ----
----  advocates for the abolition of the US Immigration and Customs Enforcement and other organizations within the federal governemnt         ----
----  which inflict grevious harm on some of the most vulnerable people in the country.                                                       ----
----                                                                                                                                          ----
----  Anti Police-Terror Project // https://www.antipoliceterrorproject.org/                                                                  ----
----  A non-profit which provides support and offers referrals to other services for families and communities                                 ----
----  targeted by acts of police terror through ineffectual and deeply harmful policies such as broken windows                                ----
----  policing, zero-tolerance drug laws, and legal immunities which protect officers who choose to brutalize                                 ----
----  their communities rather than serve them.                                                                                               ----
----                                                                                                                                          ----
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------