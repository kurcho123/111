Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)
Config.PauseMapText = '' -- Text shown above the map when ESC is pressed. If left empty 'FiveM' will appear
Config.HarnessUses = 20
Config.DamageNeeded = 100.0 -- amount of damage till you can push your vehicle. 0-1000

Config.AFK = {
    ignoredGroups = {
        ['mod'] = true,
        ['admin'] = true,
        ['god'] = true
    },
    secondsUntilKick = 1800, -- AFK Kick Time Limit (in seconds)
    kickInCharMenu = false -- Set to true if you want to kick players for being AFK even when they are in the character menu.
}

Config.HandsUp = {
    command = 'hu',
    keybind = 'X',
    controls = {24, 25, 47, 58, 59, 63, 64, 71, 72, 75, 140, 141, 142, 143, 257, 263, 264}
}

Config.Binoculars = {
    zoomSpeed = 10.0, -- camera zoom speed
    storeBinocularsKey = 177 -- backspace by default
}

Config.AIResponse = {
    wantedLevels = false, -- if true, you will recieve wanted levels
    dispatchServices = { -- AI dispatch services
        [1] = false, -- Police Vehicles
        [2] = false, -- Police Helicopters
        [3] = false, -- Fire Department Vehicles
        [4] = false, -- Swat Vehicles
        [5] = false, -- Ambulance Vehicles
        [6] = false, -- Police Motorcycles
        [7] = false, -- Police Backup
        [8] = false, -- Police Roadblocks
        [9] = false, -- PoliceAutomobileWaitPulledOver
        [10] = false, -- PoliceAutomobileWaitCruising
        [11] = false, -- Gang Members
        [12] = false, -- Swat Helicopters
        [13] = false, -- Police Boats
        [14] = false, -- Army Vehicles
        [15] = false -- Biker Backup
    }
}

Config.Options = {
    Vehicle = true, -- Forced First Person when you are aiming inside of a vehicle only.
    ForcedFirst = false, -- Forced First Person when the player is Aiming/Shooting.
    Bike = true, -- Enables forced first person when Aiming/Shooting On a Bike.
}

-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686
Config.Discord = {
    isEnabled = true, -- If set to true, then discord rich presence will be enabled
    applicationId = '981165578079322122', -- The discord application id
    iconLarge = 'head', -- The name of the large icon
    iconLargeHoverText = 'Bulgar OG', -- The hover text of the large icon
    iconSmall = 'head', -- The name of the small icon
    iconSmallHoverText = 'Bulgar OG', -- The hover text of the small icon
    updateRate = 60000, -- How often the player count should be updated
    showPlayerCount = true, -- If set to true the player count will be displayed in the rich presence
    maxPlayers = 128, -- Maximum amount of players
    buttons = {
        {
            text = 'Discord',
            url = 'https://discord.gg/twCPaMdFXC'
        },
        {
            text = 'Website',
            url = 'https://bulgar.live/'
        }
    }
}

Config.Density = {
    parked = 0.9,
    vehicle = 0.4,
    multiplier = 0.4,
    peds = 0.8,
    scenario = 0.8
}

Config.Disable = {
    hudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22}, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    controls = {37}, -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true, -- false disables ammo display
    ambience = false, -- disables distance sirens, distance car alarms, flight music, etc
    idleCamera = true, -- disables the idle cinematic camera
    vestDrawable = false, -- disables the vest equipped when using heavy armor
    pistolWhipping = true, -- disables pistol whipping
}

Config.Consumables = {
    eat = { -- default food items
        ['sandwich'] = math.random(10, 18),
        ['tosti'] = math.random(10, 18),
    },
    drink = { -- default drink items
        ['water'] = math.random(20, 30),
        ['cola'] = math.random(20, 30),
        ['coffee'] = math.random(10, 15)
    },
    alcohol = { -- default alcohol items
        ['whiskey'] = math.random(20, 30),
        ['beer'] = math.random(30, 40),
        ['vodka'] = math.random(20, 40),
    },
    custom = { -- put any custom items here
        ['upnatom-triple-burger'] = {
            progress = {
                label = 'Ядете троен бургер...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_the_triple_burger",
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02), -- vector 3 format
                rotation = vector3(-50.0, 16.0, 60.0), -- vector 3 format
            },
            replenish = {
                type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(30, 50),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-triple-cheese-burger'] = {
            progress = {
                label = 'Ядете троен бургер с кашкавал...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_the_triple_burger",
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02), -- vector 3 format
                rotation = vector3(-50.0, 16.0, 60.0), -- vector 3 format
            },
            replenish = {
                type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(40, 60),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-bacon-triple-burger'] = {
            progress = {
                label = 'Ядете троен бургер с бекон...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_the_10_slice_of_bacon_triple_cheese_melt_version",
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02), -- vector 3 format
                rotation = vector3(-50.0, 16.0, 60.0), -- vector 3 format
            },
            replenish = {
                type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(50, 70),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-bacon-triple-cheese-burger'] = {
            progress = {
                label = 'Ядете троен чийз бургер с бекон...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_the_10_slice_of_bacon_triple_cheese_melt_version",
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02), -- vector 3 format
                rotation = vector3(-50.0, 16.0, 60.0), -- vector 3 format
            },
            replenish = {
                type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(60, 80),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-chilidog'] = {
            progress = {
                label = 'Ядете чили дог...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_footlong_chili_dog",
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02), -- vector 3 format
                rotation = vector3(-50.0, 56.0, 60.0), -- vector 3 format
            },
            replenish = {
                type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(10, 18),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-fries'] = {
            progress = {
                label = 'Ядете картофки...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_fries",
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02), -- vector 3 format
                rotation = vector3(-50.0, 16.0, 60.0), -- vector 3 format
            },
            replenish = {
                type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(5, 10),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-milkshake'] = {
            progress = {
                label = 'Пиете млечен шейк...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_jumbo_shake",
                bone = 18905,
                coords = vector3(0.12, 0.008, 0.03), -- vector 3 format
                rotation = vector3( 240.0, -60.0, 0.0), -- vector 3 format
            },
            replenish = {
                type = 'Thirst', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(10, 15),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-soda'] = {
            progress = {
                label = 'Пиете сода...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_soda_cup",
                bone = 18905,
                coords = vector3(0.12, 0.008, 0.03), -- vector 3 format
                rotation = vector3( 240.0, -60.0, 0.0), -- vector 3 format
            },
            replenish = {
                type = 'Thirst', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(30, 40),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-coffee'] = {
            progress = {
                label = 'Пиете кафе...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_coffee",
                bone = 18905,
                coords = vector3(0.12, 0.008, 0.03), -- vector 3 format
                rotation = vector3( 240.0, -60.0, 0.0), -- vector 3 format
            },
            replenish = {
                type = 'Thirst', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(10, 15),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
        ['upnatom-orangotang'] = {
            progress = {
                label = 'Пиете Оранг-О-Танг...',
                time = 15000
            },
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49
            },
            prop = {
                model = "gn_upnatom_vw_tray_orangotang",
                bone = 18905,
                coords = vector3(0.12, 0.008, 0.03), -- vector 3 format
                rotation = vector3( 240.0, -60.0, 0.0), -- vector 3 format
            },
            replenish = {
                type = 'Thirst', -- replenish type 'Hunger'/'Thirst' / false
                replenish = math.random(25, 30),
                isAlcohol = false, -- if you want it to add alcohol count
                event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
                server = false -- if the event above is a server event
            }
        },
    }
}

Config.Fireworks = {
    delay = 5, -- time in s till it goes off
    items = { -- firework items
        'firework1',
        'firework2',
        'firework3',
        'firework4'
    }
}

Config.BlacklistedScenarios = {
    types = {
        'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
        'WORLD_VEHICLE_MILITARY_PLANES_BIG',
        'WORLD_VEHICLE_AMBULANCE',
        'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
        'WORLD_VEHICLE_POLICE_CAR',
        'WORLD_VEHICLE_POLICE_BIKE'
    },
    groups = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`
    }
}

Config.BlacklistedVehs = {
    [`shamal`] = true,
    [`luxor`] = true,
    [`luxor2`] = true,
    [`jet`] = true,
    [`lazer`] = true,
    [`buzzard`] = true,
    [`buzzard2`] = true,
    [`annihilator`] = true,
    [`savage`] = true,
    [`titan`] = true,
    [`rhino`] = true,
    [`firetruck`] = true,
    [`mule`] = true,
    [`maverick`] = true,
    [`blimp`] = true,
    [`airtug`] = true,
    [`camper`] = true,
    [`hydra`] = true,
    [`oppressor`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
    [`cargoplane2`] = true,
    [`voltic2`] = true,
    [`bjxl`] = true
}

Config.BlacklistedWeapons = {
    [`WEAPON_RAILGUN`] = true,
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true
}

Config.WeapDraw = {
    variants = {130, 122, 3, 6, 8},
    weapons = {
        --'WEAPON_STUNGUN',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL_MK2',
        'WEAPON_COMBATPISTOL',
        'WEAPON_APPISTOL',
        'WEAPON_PISTOL50',
        'WEAPON_REVOLVER',
        'WEAPON_SNSPISTOL',
        'WEAPON_HEAVYPISTOL',
        'WEAPON_VINTAGEPISTOL'
    }
}

Config.Objects = { -- for object removal
    {coords = vector3(266.09, -349.35, 44.74), heading = 0, length = 200, width = 200, model = 'prop_sec_barier_02b'},
    {coords = vector3(285.28, -355.78, 45.13), heading = 0, length = 200, width = 200, model = 'prop_sec_barier_02a'},
}

-- You may add more than 2 selections and it will bring up a menu for the player to select which floor be sure to label each section though
Config.Teleports = {
    [1] = { -- Elevator @ labs
        [1] = { -- up
            poly = {coords = vector3(3540.74, 3675.59, 20.99), heading = 167.5, length = 2, width = 2},
            allowVeh = false, -- whether or not to allow use in vehicle
            label = false -- set this to a string for a custom label or leave it false to keep the default. if more than 2 options, label all options

        },
        [2] = { -- down
            poly = {coords = vector3(3540.74, 3675.59, 28.11), heading = 172.5, length = 2, width = 2},
            allowVeh = false,
            label = false
        }
    },
    [2] = { --Coke Processing Enter/Exit
        [1] = {
            poly = {coords = vector3(909.49, -1589.22, 30.51), heading = 92.24, length = 2, width = 2},
            allowVeh = false,
            label = '[E] Enter Coke Processing'
        },
        [2] = {
            poly = {coords = vector3(1088.81, -3187.57, -38.99), heading = 181.7, length = 2, width = 2},
            allowVeh = false,
            label = '[E] Leave'
        }
    }
}

--GetRichPlayer
Config.WebHook = "https://discord.com/api/webhooks/1201786850558353428/eeeXQmyBGe356Y-heOVw8xJ0rN0QzJVCL7NgsXkqaLOAs-Eha73Di5zUUXVxX84tJf_v"
--What information do you want the log to include? (Refer to README.md for more information)
Config.LogMessageType = "full" --Only choose 1: "standard", "short" or "full"

--Avater for your log (optional)
Config.AvatarURL = "https://bulgar.live/images/bulgar-logo.png"

--Name for your log (optional)
Config.ServerName = "Bulgar OG Dev Logs"
--Title for your log (optional)
Config.LogTitle = "Top Richest Players"
--Color for your log (optional). Default: green
Config.LogColour = 65352
--Do you want the log to be automatically sent after a certain time?
--By the default, you need to use an admin command to trigger event
Config.SendLogByTime = {
    enable = true, --Enable/disable this feature
    time = 60, --How long do you want the log to be sent (default: 60 minutes)
}
--Do you want only top richest to be sent?
--Or you want to send money log of all players in database?
--I added this because for larger server, you might be over 200 players and it might cause lag when log details of all of them
--So I recommend to leave this as true
Config.OnlyTopRichest = {
    enable = true, --Enable/disable this feature
    top = 50, --How many top players you want to log? (By default: Top 10 richest players)
}