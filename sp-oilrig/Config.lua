-- { 17movement.net } --
Config = {}
Config.UseTarget = false
Config.UseBuiltInNotifications = true

Config.OneGasPercentWorth = 8                    -- How much script should pay for one percent of collected gas.
Config.OneQuestPercentWorth = 1                    -- How much script should pay for one percent of side quests done.

-- Reward is being calculated like that: math.floor(gasProgress * Config.OneGasPercentWorth) + math.floor(questProgress * Config.OneQuestPercentWorth)
-- Please remember about some mulitplers like Config.multiplyRewardWhileWorkingInGroup etc..

Config.RequiredItem = "none"                        -- Set it to anything you want, to require players to have an item in their inventory before they start the job
Config.RequireItemFromWholeTeam = true              -- If it's false, then only the host needs to have the required item, otherwise entire team needs it.
Config.RequiredJob = "none"                         -- Set to "none" if you dont want to use jobs. If you are using target, you have to set "job" parameter inside every export in target.lua
Config.RequireJobAlsoForFriends = true              -- If it's false, then only the host needs to have the job, if it's true, then everybody from the group needs to have the Config.RequiredJob
Config.RequireOneFriendMinimum = false              -- Set to true if you want to force players to create teams
Config.letBossSplitReward = true                    -- If it's true, then boss can manage whole party rewards percent in menu. If set to false, then everybody will get same amount. Avalible only in modern UI
Config.multiplyRewardWhileWorkingInGroup = true     -- If it's false, then reward will stay by default. For example $1000 for completing whole job. If you set it to true, then the payout will depend on how many players is there in the group. For example, if for full job there's $1000, then if player works in a 4 member group, the reward will be $4000. (baseReward * partyCount)

Config.PenaltyAmount = 150                          -- Penalty that is levied when a player finishes work without a company vehicle
Config.DontPayRewardWithoutVehicle = false          -- Set to true if you want to not pay reward to players who want to end without company vehicle (accepting the penalty)
Config.DeleteVehicleWithPenalty = false             -- Delete Vehicle even if its not company vehicle
Config.JobCooldown = 60 * 60 -- 10 * 60              -- 0 minutes cooldown between making jobs (in brackets there's example for 10 minutes)
Config.GiveKeysToAllLobby = true                    -- Set to false if you want to give keys only to group creator while starting job

Config.ProgressBarOffset = "25px"                   -- Value in px of counter offset on screen
Config.ProgressBarAlign = "bottom-center"           -- Align of the progressbar

Config.SoundVolumeMultipler = 1.0                   -- Here you can change sounds volume multipler

Config.ExplodeChance = {
    [110] = 10,
    [120] = 30,
    [130] = 40,
    [140] = 50,
    [150] = 70,
}

Config.RequireWorkClothes = false                   -- Set it to true, to change players clothes everytime they're starting the job.
Config.EnableCloakroom = true                       -- if false, then you can't see the Cloakroom button under Work Menu
Config.Clothes = {
    male = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 63, variation = 0},
        ["pants"] = {clotheId = 36, variation = 0},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 25, variation = 0},
        ["t-shirt"] = {clotheId = 77, variation = 1},
        ["torso"] = {clotheId = 69, variation = 2},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    },
    female = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 75, variation = 0},
        ["pants"] = {clotheId = 35, variation = 0},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 25, variation = 0},
        ["t-shirt"] = {clotheId = 95, variation = 1},
        ["torso"] = {clotheId = 63, variation = 2},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    },
}

Config.RestrictBlipToRequiredJob = false            -- Set to true, to hide job blip for players, who dont have RequiredJob. If requried job is "none", then this option will not have any effect.

Config.MarkerSettings = {   -- used only when Config.UseTarget = false. Colors of the marker. Active = when player stands inside the marker.
    Active = {
        r = 91,
        g = 168,
        b = 255,
        a = 240,
    },
    UnActive = {
        r = 91,
        g = 127,
        b = 255,
        a = 240,
    }
}

Config.Blips = { -- Here you can configure Company blip.
    [1] = {
        Sprite = 356,
        Color = 26,
        Scale = 0.8,
        Pos = vector3(1395.79, -3278.07, 6.23),
        Label = 'Oil Rig Job'
    },
}

Config.BlipsStyles = {

    EndJob = {
        label = "~b~[OILRIG]~s~ End Job",
        sprite = 1,
        scale = 1.0,
        color = 26,
    },

    Boat = {
        label = "~b~[OILRIG]~s~ Boat Location",
        sprite = 1,
        scale = 1.0,
        color = 26,
    },
    Containers = {
        label = "~b~[OILRIG]~s~ Container to load",
        sprite = 1,
        scale = 0.6,
        color = 26,
    },
    Rig = {
        label = "~b~[OILRIG]~s~ Rig",
        sprite = 1,
        scale = 1.0,
        color = 26,
    },
    CarryingProp = {
        label = "~b~[OILRIG]~s~ Delivery Destination",
        sprite = 1,
        scale = 1.0,
        color = 26,
    },
    Drilling = {
        label = "~b~[OILRIG]~s~ Drilling Task",
        sprite = 1,
        scale = 1.0,
        color = 26,
    },
    Welding = {
        label = "~b~[OILRIG]~s~ Welding Task",
        sprite = 1,
        scale = 1.0,
        color = 26,
    },
}

-- Handler configuration
Config.HandlerModel = `17mov_handler`
Config.HandlerSpawnLocations = {
    -- In this place you can add possible spawn locations of handler (if one place is occupied, then handler will be spawned in next one)
    vector4(1403.28, -3299.81, 6.16, 268.75),
    vector4(1390.38, -3256.08, 6.3, 270.15),
    vector4(1380.48, -3301.34, 6.3, 90.34),
    vector4(1382.32, -3315.96, 6.3, 178.37),
}

-- Boat configuration
Config.BoatModel = `17mov_tug` -- Boat vehicle model
Config.BoatSpawnLocations = {
    -- In this place you can add possible spawn locations of boat (if one place is occupied, then boat will be spawned in next one)
    vector4(1473.3, -3186.32, 1.5, 268.0),
    vector4(1473.3, -3232.26, 1.5, 268.0),
    vector4(1473.3, -3278.32, 1.5, 268.0),
    vector4(1473.3, -3318.67, 1.5, 268.0),
    vector4(1513.23, -3155.38, 1.5, 271.02),
    vector4(1514.35, -3105.49, 1.5, 269.37),
}

-- Container configuration
Config.ContainerModel = `oilcontainer1`             -- Container object model
Config.ContainerDoorsL = `prop_container_door_mb_l` -- Container doors left model
Config.ContainerDoorsR = `prop_container_door_mb_r` -- Container doors right model
Config.ContainerSpawnLocations = {
    -- In this place you can add possible spawn locations of container.
    vec4(1425.38184, -3280.47559, 4.92623138, 0.0),
    vec4(1428.13818, -3280.49634, 4.93323946, 0.0),
    vec4(1426.45044, -3266.11475, 4.8950634, 0.0),
    vec4(1426.45044, -3262.03833, 4.8950634, 0.0),
    vec4(1429.65393, -3266.09058, 4.932199, 0.0),
    vec4(1432.00037, -3205.877, 7.74760437, 0.0),
    vec4(1431.979, -3189.78613, 7.74640846, 0.0),
    vec4(1426.77319, -3198.51563, 4.92182446, 0.0),
    vec4(1434.97217, -3098.61157, 7.76363659, 0.0),
    vec4(1434.97217, -3088.35181, 7.76363659, 0.0),
    vec4(1434.97217, -3102.858, 7.76363659, 0.0),
}

Config.AttachOffsets = {
    TemporaryContainer = {
        pos = vec3(0.0, -15.0, 4.0),
        rot = vector3(0.0, 0.0, 90.0),
    },
    PedSpawningOffset = vec3(-0.5, -20.0, 5.0),
    ContainerToBoat = {
        {
            pos = vector3(-1.46, -9.1, 0.5),
            rot = vector3(0.0, 0.0, 0.0),
        },
        {
            pos = vector3(1.31, -9.1, 0.5),
            rot = vector3(0.0, 0.0, 0.0),
        },
        {
            pos = vector3(0.0, -12.4, 0.5),
            rot = vector3(0.0, 0.0, 90.0),
        },
    }
}

Config.Locations = {       -- Here u can change all of the base job locations.
    DutyToggle = {
        Coords = {
            vector3(1395.7, -3278.04, 6.23),
        },
        CurrentAction = 'open_dutyToggle',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~start/finish~s~ work.',
        type = 'duty',
        scale = {x = 1.0, y = 1.0, z = 1.0},
    },
}

Config.WeldingLevels = {
    [1] = {
        lines = {
            {
                from = {
                    x = 0,
                    y = 0.5,
                },
                to = {
                    x = 1,
                    y = 0.5,
                },
            },

        },
        time = 7,
    },
    [2] = {
        lines = {
            {
                from = {
                    x = 0,
                    y = 0.33,
                },
                to = {
                    x = 1,
                    y = 0.33,
                },
            },
            {
                from = {
                    x = 0,
                    y = 0.66,
                },
                to = {
                    x = 1,
                    y = 0.66,
                },
            },
        },
        time = 10,
    },

    [3] = {
        lines = {
            {
                from = {
                    x = 0.33,
                    y = 1,
                },
                to = {
                    x = 0.33,
                    y = 0,
                },
            },
            {
                from = {
                    x = 0.66,
                    y = 1,
                },
                to = {
                    x = 0.66,
                    y = 0,
                },
            },
        },
        time = 10,
    },

    [4] = {
        lines = {
            {
                from = {
                    x = 1,
                    y = 0,
                },
                to = {
                    x = 0,
                    y = 1,
                },
            },
            {
                from = {
                    x = 0.75,
                    y = 0,
                },
                to = {
                    x = 0.0,
                    y = 0.75,
                },
            },

            {
                from = {
                    x = 1,
                    y = 0.25,
                },
                to = {
                    x = 0.25,
                    y = 1,
                },
            },
        },
        time = 20,
    },

    [5] = {
        lines = {
            {
                from = {
                    x = 0.33,
                    y = 1,
                },
                to = {
                    x = 0.33,
                    y = 0,
                },
            },
            {
                from = {
                    x = 0.66,
                    y = 1,
                },
                to = {
                    x = 0.66,
                    y = 0,
                },
            },

            {
                from = {
                    x = 0,
                    y = 0.33,
                },
                to = {
                    x = 1,
                    y = 0.33,
                },
            },
            {
                from = {
                    x = 0,
                    y = 0.66,
                },
                to = {
                    x = 1,
                    y = 0.66,
                },
            },
        },
        time = 25,
    }
}

-- Here you can configure your language
Config.Lang = {
    -- Client
    ["no_permission"] = "Only the party owner can do that!",
    ["keybind"] = 'Oil Rig Job Marker Interaction',
    ["too_far"] = "Your party has started work, but you are too far from headquarters",
    ["kicked"] = "You kicked %s out of the party",
    ["alreadyWorking"] = "First, complete the previous order",
    ["quit"] = "You have left the Team",
    ["nobodyNearby"] = "There is no one around",
    ["cantInvite"] = "To be able to invite more people, you must first finish the job",
    ["inviteSent"] = "Invite Sent!",
    ["spawnpointOccupied"] = "The car or ship spawn site is occupied",
    ["notADriver"] = "You need to be a driver of the vehicle to end the job",
    ["partyIsFull"] = "Failed to send an invite, your group is full",
    ["wrongReward1"] = "The payout percentage should be between 0 and 100",
    ["wrongReward2"] = "The total percentage of all payouts exceeded 100%",
    ["cantLeaveLobby"] = "You can't leave the lobby while you're working. First, end the job.",
    ["lobby_joined"] = "You have joined the lobby.",
    ["attach_prop"] = "Press ~INPUT_CONTEXT~ to attach container",
    ["detach_prop"] = "Press ~INPUT_CONTEXT~ to detach container",
    ["crane_usage"] = "Use ~INPUT_MOVE_UP_ONLY~ ~INPUT_MOVE_DOWN_ONLY~ to move crane.~n~Use ~INPUT_MOVE_LEFT_ONLY~ ~INPUT_MOVE_RIGHT_ONLY~ to move cabin.~n~Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to move spreader.~n~Use ~INPUT_NEXT_CAMERA~ to change view.~n~Press ~INPUT_FRONTEND_PAUSE_ALTERNATE~ to exit.",
    ["crane_attach"] = "Press ~INPUT_PICKUP~ to pick up containers.",
    ["crane_detach"] = "Press ~INPUT_PICKUP~ to release containers.",
    ["press_to_pickup"] = "Press ~INPUT_CONTEXT~ to pick up.",
    ["open_container"] = "Press ~INPUT_CONTEXT~ to open container.",
    ["put_down"] = "Press ~INPUT_CONTEXT~ to put down.",
    ["load_container_on_boat"] = "Load container on boat",
    ["startingTutorial"] = "Welcome to your gig on the oil rig platform. Your mission is to extract as much gas as possible, along with completing several side tasks. Start by loading containers onto your ship. Using the loading vehicle, lift a container, and place it on the ship. Further instructions will be displayed during your shift. Let's get drilling!",
    ["loaded_tutorial"] = "It looks like all the containers have been loaded. We've marked your drilling platform on the map. Have the whole crew board the ship and head to the rig. Once you arrive, dock your ship at the designated spot",
    ["rig_tutorial"] = "Head to the top of the platform using the stairs. Once you're up, you can start tackling the tasks, but don't forget about unloading the containers. Use the designated crane for this. Hop into the crane, and further instructions will pop up. Let's get to work and make this rig run like clockwork",
    ["craneTutorial"] = "Take the lift down to the level where the boat is parked. Lift a container and place it in the designated spot. Repeat this process with all the containers",
    ["afterLoadTutorial"] = "Looks like all the containers have been loaded. Your task now is to unload them. Approach the doors to open them, and distribute all the items to the designated spot",
    ["drill_tutorial"] = "You've approached the gas extraction machine. Let's quickly explain your task. You need to keep drilling pipes deeper and deeper until you reach 100% extraction. Be aware: You can push it up to 150% gas extraction, but each additional drilling increases the risk of an explosion. If the gas explodes, you'll lose all the collected gas, and it won't be possible to continue the job. Handle with care and make strategic choices!",
    ["props_tutorial"] = "Now, you need to distribute the entire contents of the container to the designated spots. Pick up an item and its destination location will highlight",
    ["rig_exploded"] = "Machine has exploded, resulting in the loss of all progress. You cannot continue drilling",
    ["not_in_boat"] = "You are not in the boat!",
    ["drill_busy"] = "Drill is busy at this moment. Try again later",
    ["endJobHint"] = "Press ~INPUT_CONTEXT~ to ~y~end ~s~working.",
    ["noBoatLocation"] = "There's no free boat locations",
    ["noHandlerLocation"] = "There's no free handler locations",
    ["noContainerLocation"] = "There's no free container locations",
    ["noRig"] = "There's no avalible work to do",
    ["endJob"] = "Press ~INPUT_CONTEXT~ to ~y~end ~s~working.",

    -- Server
    ["isAlreadyHost"] = "This player leads his team.",
    ["isBusy"] = "This player already belongs to another team.",
    ["hasActiveInvite"] = "This Player already has an active invitation from someone.",
    ["HaveActiveInvite"] = "You already have an active invitation to join the team.",
    ["InviteDeclined"] = "Your invitation has been declined.",
    ["InviteAccepted"] = "Your invitation has been accepted!",
    ["error"] = "There was a Problem joining a team. Please try again later.",
    ["kickedOut"] = "You've been kicked out of the team!",
    ["reward"] = "You have received a payout of $",
    ["RequireOneFriend"] = "This job requires at least one team member",
    ["penalty"] = "You paid a fine in the amount of ",
    ["clientsPenalty"] = "The team's host accepted the punishment. You have not received the payment",
    ["dontHaveReqItem"] = "You or someone from your team does not have the required item to start work",
    ["notEverybodyHasRequiredJob"] = "Not all of your friends have the required job",
    ["someoneIsOnCooldown"] = "%s can't start the job now (cooldown: %s)", 
    ["hours"] = "h",
    ["minutes"] = "m",
    ["seconds"] = "s",
    ["newBoss"] = "The previous lobby boss has left the server. You are now the team leader",
    ["wait"] = "Please wait few seconds and try again later",
    ["craneBusy"] = "Crane is busy. Please try again later",

    -- NUI
    ["NUI_weldingJobTitle"] = "Welding",
    ["NUI_weldingJobTitlePlaceholder"] = "MINIGAMES",
    ["NUI_instructionWeldingContent"] = "Your task is to perform a welding job on the indicated line. Execute this with the utmost precision, as the success of the weld depends entirely on your accuracy. Remember, there is a time limit to complete this task. To begin, press the spacebar or the button located at the bottom of the interface.",
    ["NUI_pipesJobTitle"] = "Drilling",
    ["NUI_pipesJobPlaceholder"] = "MINIGAMES",
    ["NUI_instructionPipesContent"] = "Your task is to connect the previous pipe with the next one. To attempt to attach the pipe, press the spacebar. If the pipes are positioned too far apart from each other, the mini-game will not be counted as successful. You need to do it until you reach 100% extraction. Be aware: You can push it up to 150% gas extraction, but each additional drilling increases the risk of an explosion. If the gas explodes, you'll lose all the collected gas, and it won't be possible to continue the job. To begin, press the spacebar or the button located at the bottom of the interface.",
    ["NUI_instructionTitle"] = "Instruction",
    ["NUI_timeTitle"] = "Time",
    ["NUI_timeContentPrimary"] = "Time to end...",
    ["NUI_tasksTitle2"] = "Number of tasks",
    ["NUI_tasksContentPrimary2"] = "Tasks to end...",
    ["NUI_tasksContentSecondary2"] = "%s/%s tasks",
    ["NUI_tasksTitle"] = "Current Gas Progress",
    ["NUI_tasksContentPrimary"] = "Collected Gas...",
    ["NUI_tasksContentSecondary"] = "%s%",
    ["NUI_progress"] = "Progress: %s%",
    ["NUI_gasProgress"] = "Collected Gas: %s%",
    ["NUI_startTitle"] = "Start",
    ["NUI_buttonStart"] = "Start",
    ["NUI_buttonFinish"] = "Finish",
    ["NUI_buttonAgain"] = "Try again",
    ["NUI_buttonExit"] = "Exit",
    ["NUI_notifySuccess"] = "Task complete",
    ["NUI_notifyFailed"] = "Task failed",
    ["NUI_signatureTitle"] = "OIL RIG JOB",
    ["NUI_signatureTitlePlaceholder"] = "OIL RIG JOB",
    ["NUI_signatureSubtitle"] = "Signature Document",
    ["NUI_signatureText"] = "In order to put object down, first signature this document ",
    ["NUI_signatureError"] = "You need to sign!",
    ["NUI_signatureAccept"] = "Sign",
    ["NUI_signatureRetry"] = "Clear",
    ["NUI_tutorial"] = "Tutorial",
    ["NUI_notification"] = "Notification",
    ["NUI_invitation"] = "Invitation",
    ["NUI_warning"] = "Warning",
    ["NUI_bossName"] = "Boss Name",
    ["NUI_memberName"] = "Member Name",
    ["NUI_kickPlayerNotify"] = "The owner of the team can not leave it!",
    ["NUI_startJobNotify"] = "Only owner of the party can start job!",
    ["NUI_oilRigLobby"] = "OIL RIG LOBBY",
}

Config.RigsLocations = {
    -- Rig: 1
    [1] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(4026.6, -1947.5, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(4022.0, -1915.0, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4027.0, -1915.0, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4032.0, -1915.0, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(4026.07, -1926.02, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(4035.55, -1937.85, 2.21, 268.45),
                vector4(4035.55, -1961.25, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vec3(3990.42041, -1973.20325, 58.6110344), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3983.37329, -1973.05371, 57.69816),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3987.29541, -1920.203, 57.21369),     rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vec3(3986.87134, -1921.80835, 57.21733),   rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vec3(3986.87378, -1920.94836, 57.3877945), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vec3(3993.041, -1925.65344, 57.2261238), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3993.81982, -1925.62964, 57.20464), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vec3(3985.336, -1925.60608, 57.19266),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3987.02417, -1925.62683, 57.21418), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vec3(3986.17529, -1925.61133, 57.19628),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3993.46558, -1947.64368, 57.1917648), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vec3(3986.28076, -1947.6106, 57.2132225), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vec3(3994.482, -1956.33044, 57.8626022),  rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vec3(3992.34937, -1956.46265, 58.5781746), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3984.18237, -1973.1272, 59.23725),    rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3992.76318, -1920.45361, 57.76666),   rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vec3(3987.47778, -1920.35693, 59.3276367), rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vec3(4050.72437, -1952.76868, 61.2961464), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4051.79858, -1952.7677, 61.2837677),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4060.583, -1943.62207, 61.28274),     rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vec3(4062.57983, -1939.93677, 64.11262),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4068.72778, -1976.12366, 56.8798065), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4069.73242, -1976.12366, 56.8798065), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vec3(4072.24121, -1976.12366, 56.8798065), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4002.48242, -1986.94482, 65.65311),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4009.99072, -1986.94482, 65.65311),   rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vec3(4002.48242, -1953.76489, 65.65311),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4012.174, -1953.76489, 65.65311),     rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(4011.04468, -1949.03687, 61.3099632), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vec3(3995.464, -1907.71191, 56.8573837), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3995.464, -1903.12585, 56.8573837), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vec3(3995.464, -1905.08752, 56.8573837), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4072.37769, -1966.908, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4072.37769, -1966.2926, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4072.37769, -1967.52356, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4072.37769, -1965.68359, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4072.37769, -1965.08069, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4072.37769, -1964.47534, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4071.74878, -1966.908, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4071.74878, -1966.2926, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4071.74878, -1967.52356, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4071.74878, -1965.68359, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4071.74878, -1965.08069, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vec3(4071.74878, -1964.47534, 57.3690529), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4004.63354, -1952.199, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4005.36133, -1952.199, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4006.08521, -1952.199, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4004.63354, -1952.93152, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4005.36133, -1952.93152, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4006.08521, -1952.93152, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4004.63354, -1953.64709, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4005.36133, -1953.64709, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vec3(4006.08521, -1953.64709, 57.7073631), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(4004.49, -1928.18, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(4007.99854, -1928.9801, 59.0749969),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(4007.97949, -1928.98132, 55.31035),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(4007.56, -1912.27, 57.89), busy = false },
                { coords = vector3(3993.65, -1944.46, 58.01), busy = false },
                { coords = vector3(3987.29, -1950.8, 57.99),  busy = false },
                { coords = vector3(3985.27, -1970.27, 58.47), busy = false },
                { coords = vector3(3984.36, -1985.64, 62.28), busy = false },
                { coords = vector3(3993.53, -1985.6, 57.9),   busy = false },
                { coords = vector3(4057.06, -1973.42, 62.3),  busy = false },
                { coords = vector3(4057.18, -1943.42, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 2
    [2] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(4352.82, -2627.32, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(4348.22, -2594.82, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4353.22, -2594.82, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4358.22, -2594.82, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(4352.29, -2605.84, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(4361.77, -2617.67, 2.21, 268.45),
                vector4(4361.77, -2641.07, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4316.64, -2653.03, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4309.59, -2652.88, 57.7),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4313.52, -2600.03, 57.21), rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4313.09, -2601.63, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(4313.09, -2600.77, 57.39), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4319.26, -2605.48, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4320.04, -2605.46, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4311.56, -2605.43, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4313.24, -2605.45, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4312.4, -2605.44, 57.2),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4319.69, -2627.47, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4312.5, -2627.44, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(4320.7, -2636.16, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(4318.57, -2636.29, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4310.4, -2652.95, 59.24),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4318.98, -2600.28, 57.77), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(4313.7, -2600.18, 59.33),  rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4376.95, -2632.6, 61.3),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4378.02, -2632.59, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4386.8, -2623.45, 61.28),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4388.8, -2619.76, 64.11),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4394.95, -2655.95, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4395.95, -2655.95, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4398.46, -2655.95, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4328.7, -2666.77, 65.65),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4336.21, -2666.77, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4328.7, -2633.59, 65.65),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4338.39, -2633.59, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4337.27, -2628.86, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4321.68, -2587.54, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4321.68, -2582.95, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4321.68, -2584.91, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4398.6, -2646.73, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4398.6, -2646.12, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4398.6, -2647.35, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4398.6, -2645.51, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4398.6, -2644.91, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4398.6, -2644.3, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4397.97, -2646.73, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4397.97, -2646.12, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4397.97, -2647.35, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4397.97, -2645.51, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4397.97, -2644.91, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4397.97, -2644.3, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4330.85, -2632.03, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4331.58, -2632.03, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4332.31, -2632.03, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4330.85, -2632.76, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4331.58, -2632.76, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4332.31, -2632.76, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4330.85, -2633.47, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4331.58, -2633.47, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4332.31, -2633.47, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(4330.71, -2608.01, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(4334.22, -2608.81, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(4334.2, -2608.81, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(4333.78, -2592.1, 57.89),  busy = false },
                { coords = vector3(4319.87, -2624.29, 58.01), busy = false },
                { coords = vector3(4313.51, -2630.63, 57.99), busy = false },
                { coords = vector3(4311.49, -2650.1, 58.47),  busy = false },
                { coords = vector3(4310.58, -2665.47, 62.28), busy = false },
                { coords = vector3(4319.75, -2665.43, 57.9),  busy = false },
                { coords = vector3(4383.28, -2653.25, 62.3),  busy = false },
                { coords = vector3(4383.06, -2623.3, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 3
    [3] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(4026.6, -3134.73, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(4022, -3102.23, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4027, -3102.23, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4032, -3102.23, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(4026.07, -1926.02, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(4035.55, -3125.08, 2.21, 268.45),
                vector4(4035.55, -3148.48, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3990.42, -3160.43, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3983.37, -3160.28, 57.7),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3987.3, -3107.43, 57.21),  rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3986.87, -3109.04, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(3986.87, -3108.18, 57.39), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3993.04, -3112.88, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3993.82, -3112.86, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3985.34, -3112.84, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3987.02, -3112.86, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3986.18, -3112.84, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3993.47, -3134.87, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3986.28, -3134.84, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3994.48, -3143.56, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(3992.35, -3143.69, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3984.18, -3160.36, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3992.76, -3107.68, 57.77), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3987.48, -3107.59, 59.33), rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4050.72, -3140, 61.3),     rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4051.8, -3140, 61.28),     rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4060.58, -3130.85, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4062.58, -3127.17, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4068.73, -3163.35, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4069.73, -3163.35, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4072.24, -3163.35, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4002.48, -3174.18, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4009.99, -3174.18, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4002.48, -3141, 65.65),    rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4012.17, -3141, 65.65),    rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4011.04, -3136.27, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3995.46, -3094.94, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3995.46, -3090.36, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3995.46, -3092.32, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4072.38, -3154.14, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4072.38, -3153.52, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4072.38, -3154.75, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4072.38, -3152.91, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4072.38, -3152.31, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4072.38, -3151.71, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4071.75, -3154.14, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4071.75, -3153.52, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4071.75, -3154.75, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4071.75, -3152.91, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4071.75, -3152.31, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4071.75, -3151.71, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4004.63, -3139.43, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4005.36, -3139.43, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4006.09, -3139.43, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4004.63, -3140.16, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4005.36, -3140.16, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4006.09, -3140.16, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4004.63, -3140.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4005.36, -3140.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4006.09, -3140.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(4004.49, -3115.41, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(4008, -3116.21, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(4007.98, -3116.21, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(4007.56, -3099.5, 57.89),  busy = false },
                { coords = vector3(3993.65, -3131.69, 58.01), busy = false },
                { coords = vector3(3987.29, -3138.03, 57.99), busy = false },
                { coords = vector3(3985.27, -3157.5, 58.47),  busy = false },
                { coords = vector3(3984.36, -3172.87, 62.28), busy = false },
                { coords = vector3(3993.53, -3172.83, 57.9),  busy = false },
                { coords = vector3(4057.06, -3160.65, 62.3),  busy = false },
                { coords = vector3(4057.18, -3130.65, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 4
    [4] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(4214.27, -3742.24, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(4209.67, -3709.74, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4214.67, -3709.74, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(4219.67, -3709.74, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(4213.74, -3720.76, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(4223.22, -3732.59, 2.21, 268.45),
                vector4(4223.22, -3755.99, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4178.09, -3767.94, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4171.05, -3767.79, 57.7),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4174.97, -3714.94, 57.21), rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4174.54, -3716.54, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(4174.55, -3715.68, 57.39), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4180.71, -3720.39, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4181.49, -3720.36, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4173.01, -3720.34, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4174.7, -3720.36, 57.21),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4173.85, -3720.35, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4181.14, -3742.38, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(4173.95, -3742.35, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(4182.15, -3751.07, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(4180.02, -3751.2, 58.58),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4171.86, -3767.86, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4180.44, -3715.19, 57.77), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(4175.15, -3715.09, 59.33), rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4238.4, -3747.5, 61.3),    rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4239.47, -3747.5, 61.28),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4248.26, -3738.36, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4250.25, -3734.67, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4256.4, -3770.86, 56.88),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4257.41, -3770.86, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4259.91, -3770.86, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4190.16, -3781.68, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4197.66, -3781.68, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4190.16, -3748.5, 65.65),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4199.85, -3748.5, 65.65),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4198.72, -3743.77, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(4183.14, -3702.45, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4183.14, -3697.86, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(4183.14, -3699.82, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4260.05, -3761.64, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4260.05, -3761.03, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4260.05, -3762.26, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4260.05, -3760.42, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4260.05, -3759.82, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4260.05, -3759.21, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4259.42, -3761.64, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4259.42, -3761.03, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4259.42, -3762.26, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4259.42, -3760.42, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4259.42, -3759.82, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(4259.42, -3759.21, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4192.31, -3746.93, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4193.03, -3746.93, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4193.76, -3746.93, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4192.31, -3747.67, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4193.03, -3747.67, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4193.76, -3747.67, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4192.31, -3748.38, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4193.03, -3748.38, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(4193.76, -3748.38, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(4192.16, -3722.92, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(4195.67, -3723.72, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(4195.65, -3723.72, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(4195.23, -3707.01, 57.89), busy = false },
                { coords = vector3(4181.32, -3739.2, 58.01),  busy = false },
                { coords = vector3(4174.96, -3745.54, 57.99), busy = false },
                { coords = vector3(4172.94, -3765.01, 58.47), busy = false },
                { coords = vector3(4172.03, -3780.38, 62.28), busy = false },
                { coords = vector3(4181.2, -3780.34, 57.9),   busy = false },
                { coords = vector3(4244.73, -3768.16, 62.3),  busy = false },
                { coords = vector3(4244.85, -3738.16, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 5
    [5] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(3591.36, -2456.18, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(3586.76, -2423.68, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3591.76, -2423.68, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3596.76, -2423.68, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(3590.83, -2434.7, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(3600.31, -2446.53, 2.21, 268.45),
                vector4(3600.31, -2469.93, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3555.18, -2481.89, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3548.14, -2481.74, 57.7),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3552.06, -2428.89, 57.21), rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3551.63, -2430.49, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(3551.64, -2429.63, 57.39), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3557.8, -2434.34, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3558.58, -2434.31, 57.2), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3550.1, -2434.29, 57.19),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3551.79, -2434.31, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3550.94, -2434.3, 57.2),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3558.23, -2456.33, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3551.04, -2456.29, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3559.25, -2465.01, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(3557.11, -2465.15, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3548.95, -2481.81, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3557.53, -2429.14, 57.77), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3552.24, -2429.04, 59.33), rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3615.49, -2461.45, 61.3),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3616.56, -2461.45, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3625.35, -2452.31, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3627.34, -2448.62, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3633.49, -2484.81, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3634.5, -2484.81, 56.88),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3637, -2484.81, 56.88),    rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3567.25, -2495.63, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3574.75, -2495.63, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3567.25, -2462.45, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3576.94, -2462.45, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3575.81, -2457.72, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3560.23, -2416.4, 56.86),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3560.23, -2411.81, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3560.23, -2413.77, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3637.14, -2475.59, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3637.14, -2474.98, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3637.14, -2476.21, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3637.14, -2474.37, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3637.14, -2473.76, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3637.14, -2473.16, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3636.51, -2475.59, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3636.51, -2474.98, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3636.51, -2476.21, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3636.51, -2474.37, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3636.51, -2473.76, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3636.51, -2473.16, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3569.4, -2460.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3570.12, -2460.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3570.85, -2460.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3569.4, -2461.62, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3570.12, -2461.62, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3570.85, -2461.62, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3569.4, -2462.33, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3570.12, -2462.33, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3570.85, -2462.33, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(3569.25, -2436.86, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(3572.76, -2437.66, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(3572.74, -2437.67, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(3572.32, -2420.95, 57.89), busy = false },
                { coords = vector3(3558.41, -2453.14, 58.01), busy = false },
                { coords = vector3(3552.05, -2459.48, 57.99), busy = false },
                { coords = vector3(3550.03, -2478.95, 58.47), busy = false },
                { coords = vector3(3549.12, -2494.32, 62.28), busy = false },
                { coords = vector3(3558.29, -2494.28, 57.9),  busy = false },
                { coords = vector3(3621.82, -2482.1, 62.3),   busy = false },
                { coords = vector3(3621.94, -2452.1, 62.3),   busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 6
    [6] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(3113.63, -3017.61, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(3109.03, -2985.11, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3114.03, -2985.11, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3119.03, -2985.11, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(3113.1, -2996.13, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(3122.58, -3007.96, 2.21, 268.45),
                vector4(3122.58, -3031.36, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3077.45, -3043.32, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3070.41, -3043.17, 57.7),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3074.33, -2990.32, 57.21), rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3073.9, -2991.92, 57.22),  rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(3073.91, -2991.06, 57.39), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3080.07, -2995.77, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3080.85, -2995.74, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3072.37, -2995.72, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3074.06, -2995.74, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3073.21, -2995.72, 57.2), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3080.5, -3017.76, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3073.31, -3017.72, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3081.51, -3026.44, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(3079.38, -3026.58, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3071.21, -3043.24, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3079.8, -2990.57, 57.77),  rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3074.51, -2990.47, 59.33), rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3137.76, -3022.88, 61.3),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3138.83, -3022.88, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3147.62, -3013.74, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3149.61, -3010.05, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3155.76, -3046.24, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3156.76, -3046.24, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3159.27, -3046.24, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3089.51, -3057.06, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3097.02, -3057.06, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3089.51, -3023.88, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3099.21, -3023.88, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3098.08, -3019.15, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3082.5, -2977.83, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3082.5, -2973.24, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3082.5, -2975.2, 56.86),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3159.41, -3037.02, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3159.41, -3036.41, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3159.41, -3037.64, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3159.41, -3035.8, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3159.41, -3035.19, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3159.41, -3034.59, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3158.78, -3037.02, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3158.78, -3036.41, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3158.78, -3037.64, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3158.78, -3035.8, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3158.78, -3035.19, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3158.78, -3034.59, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3091.67, -3022.31, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3092.39, -3022.31, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3093.12, -3022.31, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3091.67, -3023.05, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3092.39, -3023.05, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3093.12, -3023.05, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3091.67, -3023.76, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3092.39, -3023.76, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3093.12, -3023.76, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(3091.52, -2998.29, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(3095.03, -2999.09, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(3095.01, -2999.09, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(3094.59, -2982.38, 57.89), busy = false },
                { coords = vector3(3080.68, -3014.57, 58.01), busy = false },
                { coords = vector3(3074.32, -3020.91, 57.99), busy = false },
                { coords = vector3(3072.3, -3040.38, 58.47),  busy = false },
                { coords = vector3(3071.39, -3055.75, 62.28), busy = false },
                { coords = vector3(3080.56, -3055.71, 57.9),  busy = false },
                { coords = vector3(3144.09, -3043.53, 62.3),  busy = false },
                { coords = vector3(3144.21, -3013.53, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 7
    [7] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(3708.99, -3473.25, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(3704.39, -3440.75, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3709.39, -3440.75, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3714.39, -3440.75, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(3708.46, -3451.77, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(3717.94, -3463.6, 2.21, 268.45),
                vector4(3717.94, -3487, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3672.81, -3498.95, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3665.77, -3498.8, 57.7),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3669.69, -3445.95, 57.21), rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3669.26, -3447.56, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(3669.27, -3446.7, 57.39),  rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3675.43, -3451.4, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3676.21, -3451.38, 57.2), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3667.73, -3451.35, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3669.42, -3451.37, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3668.57, -3451.36, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3675.86, -3473.39, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3668.67, -3473.36, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3676.87, -3482.08, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(3674.74, -3482.21, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3666.57, -3498.87, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3675.16, -3446.2, 57.77),  rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3669.87, -3446.1, 59.33),  rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3733.12, -3478.52, 61.3),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3734.19, -3478.52, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3742.98, -3469.37, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3744.97, -3465.68, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3751.12, -3501.87, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3752.12, -3501.87, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3754.63, -3501.87, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3684.87, -3512.69, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3692.38, -3512.69, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3684.87, -3479.51, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3694.57, -3479.51, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3693.44, -3474.78, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3677.86, -3433.46, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3677.86, -3428.87, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3677.86, -3430.84, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.77, -3492.66, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.77, -3492.04, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.77, -3493.27, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.77, -3491.43, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.77, -3490.83, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.77, -3490.22, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.14, -3492.66, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.14, -3492.04, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.14, -3493.27, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.14, -3491.43, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.14, -3490.83, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3754.14, -3490.22, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3687.03, -3477.95, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3687.75, -3477.95, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3688.48, -3477.95, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3687.03, -3478.68, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3687.75, -3478.68, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3688.48, -3478.68, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3687.03, -3479.39, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3687.75, -3479.39, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3688.48, -3479.39, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(3686.88, -3453.93, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(3690.39, -3454.73, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(3690.37, -3454.73, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(3689.95, -3438.02, 57.89), busy = false },
                { coords = vector3(3676.04, -3470.21, 58.01), busy = false },
                { coords = vector3(3669.68, -3476.55, 57.99), busy = false },
                { coords = vector3(3667.66, -3496.02, 58.47), busy = false },
                { coords = vector3(3666.75, -3511.39, 62.28), busy = false },
                { coords = vector3(3675.92, -3511.35, 57.9),  busy = false },
                { coords = vector3(3739.45, -3499.17, 62.3),  busy = false },
                { coords = vector3(3739.57, -3469.17, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 8
    [8] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(3114.93, -3793.03, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(3110.33, -3760.53, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3115.33, -3760.53, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(3120.33, -3760.53, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(3114.4, -3771.55, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(3123.88, -3783.38, 2.21, 268.45),
                vector4(3123.88, -3806.78, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3078.75, -3818.74, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3071.7, -3818.59, 57.7),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3075.62, -3765.74, 57.21), rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3075.2, -3767.34, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(3075.2, -3766.48, 57.39), rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3081.37, -3771.19, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3082.15, -3771.16, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3073.66, -3771.14, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3075.35, -3771.16, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3074.5, -3771.14, 57.2),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3081.79, -3793.18, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(3074.61, -3793.14, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3082.81, -3801.86, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(3080.68, -3801.99, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3072.51, -3818.66, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3081.09, -3765.99, 57.77), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(3075.8, -3765.89, 59.33),  rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3139.05, -3798.3, 61.3),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3140.13, -3798.3, 61.28),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3148.91, -3789.15, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3150.91, -3785.47, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3157.05, -3821.66, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3158.06, -3821.66, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3160.57, -3821.66, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3090.81, -3832.48, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3098.32, -3832.48, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3090.81, -3799.3, 65.65),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3100.5, -3799.3, 65.65),   rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3099.37, -3794.57, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(3083.79, -3753.24, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3083.79, -3748.66, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(3083.79, -3750.62, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.7, -3812.44, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.7, -3811.82, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.7, -3813.06, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.7, -3811.22, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.7, -3810.61, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.7, -3810.01, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.08, -3812.44, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.08, -3811.82, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.08, -3813.06, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.08, -3811.22, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.08, -3810.61, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(3160.08, -3810.01, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3092.96, -3797.73, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3093.69, -3797.73, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3094.41, -3797.73, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3092.96, -3798.46, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3093.69, -3798.46, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3094.41, -3798.46, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3092.96, -3799.18, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3093.69, -3799.18, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(3094.41, -3799.18, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(3092.82, -3773.71, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(3096.33, -3774.51, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(3096.31, -3774.51, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(3095.89, -3757.8, 57.89),  busy = false },
                { coords = vector3(3081.98, -3789.99, 58.01), busy = false },
                { coords = vector3(3075.62, -3796.33, 57.99), busy = false },
                { coords = vector3(3073.6, -3815.8, 58.47),   busy = false },
                { coords = vector3(3072.69, -3831.17, 62.28), busy = false },
                { coords = vector3(3081.86, -3831.13, 57.9),  busy = false },
                { coords = vector3(3145.39, -3818.95, 62.3),  busy = false },
                { coords = vector3(3145.51, -3788.95, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
    -- Rig: 9
    [9] = {
        Crane = {
            Coords = {},
            SpawnCoords = vector3(2465.81, -3590.45, 56.89),
            MinY = -14,
            MaxY = 22,
            MinZ = -53.0,
            MaxZ = 13.0,
            type = "text",
            textMessage = "~r~[E] | ~s~Enter Crane",
        },
        Containers = {
            ContainerCoords = {
                { coords = vector4(2461.21, -3557.95, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(2466.21, -3557.95, 56.89, 180.0), percentReward = 6.5},
                { coords = vector4(2471.21, -3557.95, 56.89, 180.0), percentReward = 6.5},
            },
            Destination = vector4(2465.28, -3568.97, 56.89, 180.0)
        },
        BoatParking = {
            Coords = {
                vector4(2474.76, -3580.8, 2.21, 268.45),
                vector4(2474.76, -3604.2, 2.91, 268.45),
            },

            BusyParkings = {
                [1] = false, [2] = false,
            },
            scale = { x = 5.0, y = 5.0, z = 5.0 },
            HelpNotification = "Press ~INPUT_CONTEXT~ to park boat.",
            type = "marker",
        },
        ContainerContent = {
            [1] = {
                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(2429.63, -3616.16, 58.61), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2422.58, -3616.01, 57.7),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2426.5, -3563.16, 57.21),  rotation = vec3(0.0, 0.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },

                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(2426.08, -3564.76, 57.22), rotation = vec3(0.0, 0.0, 90.0) },
                        { coords = vector3(2426.08, -3563.9, 57.39),  rotation = vec3(0.0, -90.0, 90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.47),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(2432.25, -3568.61, 57.23), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2433.03, -3568.58, 57.2),  rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.92, 1.4, 0.63),
                        rot = vector3(0.0, -90.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(2424.54, -3568.56, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2426.23, -3568.58, 57.21), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(2425.38, -3568.56, 57.2), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2432.67, -3590.6, 57.19), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.4, 1.26),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_ind_cs_box02",
                    destinations = {
                        { coords = vector3(2425.49, -3590.56, 57.21), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(2433.69, -3599.28, 57.86), rotation = vec3(0.0, -90.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.1, 1.4, 0.86),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.0, 0.85, 0.25),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "v_res_filebox01",
                    destinations = {
                        { coords = vector3(2431.55, -3599.41, 58.58), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2423.39, -3616.08, 59.24), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2431.97, -3563.41, 57.77), rotation = vec3(0.0, 0.0, -90.0) },
                        { coords = vector3(2426.68, -3563.31, 59.33), rotation = vec3(0.0, 0.0, -90.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.05, 1.36, 1.22),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.10, -0.1, -0.3),
                        rot = vector3(0.0, -82.0, -70.0),
                    },
                    percentReward = 4.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(2489.93, -3595.72, 61.3),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2491, -3595.72, 61.28),    rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2499.79, -3586.57, 61.28), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(2501.79, -3582.89, 64.11), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2507.93, -3619.08, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2508.94, -3619.08, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, 0.1, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(2511.45, -3619.08, 56.88), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2441.69, -3629.9, 65.65),  rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2449.2, -3629.9, 65.65),   rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(2441.69, -3596.72, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2451.38, -3596.72, 65.65), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2450.25, -3591.99, 61.31), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, -1.0, 0.2),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },


                {
                    model = "prop_box_wood01a",
                    destinations = {
                        { coords = vector3(2434.67, -3550.66, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2434.67, -3546.08, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                        { coords = vector3(2434.67, -3548.04, 56.86), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.5, 0.1, 1.0),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.41, 0.68, 0.47),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [2] = {
                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2511.58, -3609.86, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2511.58, -3609.24, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2511.58, -3610.48, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.9, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2511.58, -3608.64, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2511.58, -3608.03, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, 0.9, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2511.58, -3607.43, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.9, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2510.95, -3609.86, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2510.95, -3609.24, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2510.95, -3610.48, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.1, 0.54),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2510.95, -3608.64, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.35, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2510.95, -3608.03, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.36, -0.1, 1.01),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "prop_barrel_exp_01b",
                    destinations = {
                        { coords = vector3(2510.95, -3607.43, 57.37), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.1, 1.47),
                        rot = vector3(-90.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(-0.0, 0.9, 0.4),
                        rot = vector3(0.0, 0.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            },

            [3] = {
                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2443.84, -3595.15, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2444.57, -3595.15, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2445.29, -3595.15, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 1.13, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2443.84, -3595.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2444.57, -3595.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2445.29, -3595.88, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, 0.33, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2443.84, -3596.6, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(-0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2444.57, -3596.6, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.0, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },

                {
                    model = "17mov_oilrig_smallpipe",
                    destinations = {
                        { coords = vector3(2445.29, -3596.6, 57.71), rotation = vec3(0.0, 0.0, 0.0) },
                    },
                    spawnOffsets = {
                        pos = vector3(0.7, -0.47, 1.03),
                        rot = vector3(180.0, 180.0, 0.0),
                    },
                    attachOffsets = {
                        pos = vector3(0.3, 1.00, 0.32),
                        rot = vector3(0.0, 90.0, 0.0),
                    },
                    percentReward = 1.5,
                },
            }
        },
        Drill = {
            Coords = {
                vector3(2443.7, -3571.13, 58.11),
            },
            PropModel = `drill2a`,
            PropCoords = vector3(2447.2, -3571.93, 59.07),
            PropRotation = vec3(0.0, 0.0, -180.0),
            hintPropModel = `17mov_oilrig_pipe`,
            hintPropCoords = vector3(2447.18, -3571.93, 55.31),
            addonPropAttachoffset = vec3(0.0, 0.0, -1.73),
            type = "text",
            textMessage = "~r~[E] | ~s~Start Drilling",
        },
        Welding = {
            Coords = {
                { coords = vector3(2446.77, -3555.22, 57.89), busy = false },
                { coords = vector3(2432.86, -3587.41, 58.01), busy = false },
                { coords = vector3(2426.5, -3593.75, 57.99),  busy = false },
                { coords = vector3(2424.48, -3613.22, 58.47), busy = false },
                { coords = vector3(2423.57, -3628.59, 62.28), busy = false },
                { coords = vector3(2432.74, -3628.55, 57.9),  busy = false },
                { coords = vector3(2496.27, -3616.37, 62.3),  busy = false },
                { coords = vector3(2496.39, -3586.37, 62.3),  busy = false },
            },
            percentReward = 3.5,
            type = "text",
            textMessage = "~r~[E] | ~s~Start Welding",
        }
    },
}

-- { 17movement.net } --