Config = Config or {}

Config.JobNeeded = false -- if you need a specific job to do the deliveries true/false
Config.JobName = 'delivery' -- Job needed to do the deliveries if the config above is set to true
Config.JobPed = 's_m_m_ups_01' -- Model of the starting ped
Config.JobPedLocation = vector4(-429.53, -2786.3, 6.0, 53.77) -- Where the starting ped is
Config.JobPedAnimation = 'WORLD_HUMAN_CLIPBOARD'
Config.JobBlipName = 'Road Runner Deliveries' -- Blip of where the starting ped is

--- These should be self explanatory as its labeles as what it is
Config.JobPedBlipSprite = 304
Config.JobPedBlipSpriteColour = 32
Config.JobPedBlipSpriteScale = 0.75

--
Config.FuelScript = 'cdn-fuel' -- ps-fuel/lj-fuel/LegacyFuel Change to the fuel system you use here
Config.VehicleSpawn = vector4(-445.69, -2789.91, 5.39, 43.89) -- Spot the vehicle spawns

Config.PaymentMethod = 'cash' -- cash/bank how the groups gets paid out at the end
--- Different levels of Reputation best to not have it to low, unless you know how to balance it out with pay etc but can be whatever number you like
Config.DeliveryMidReputation = 50
Config.DeliveryHighReputation = 100

Config.DisableInventory = false -- blocks the player from going in the inventory while they have the package
Config.DisableSprintingWithPackages = true
Config.DisableJumpingWithPackages = true
Config.DisableVehicleEnteringWithPackages = true
Config.DisableCrouchWithPackages = true
Config.DisableAttackingWithPackages = true
Config.DisableAimingWithPackages = true

--- THESE LOCATIONS ARE SET TO WORK WITH DEFAULT STORE LOCATIONS
Config.Shops = {
    [1] = { -- Do not add a 4th table unless you know what you are doing, its not as simple as just copy and pasting in here
        Coords= { -- These coords are more to the lower part of the map add as many coords as you like 
            vector3(25.7, -1347.3, 29.49),
            vector3(-3038.71, 585.9, 7.9),
            vector3(-3241.47, 1001.14, 12.83),
            vector3(1728.66, 6414.16, 35.03),
            vector3(1697.99, 4924.4, 42.06),
            vector3(1961.48, 3739.96, 32.34),
            vector3(547.79, 2671.79, 42.15),
            vector3(2679.25, 3280.12, 55.24),
            vector3(2557.94, 382.05, 108.62),
            vector3(373.55, 325.56, 103.56),
        },
        Packages = {-- If you want a random amount of packages to deliver then replace the number with a math.random(10, 13) 
            minamount = 8,
            maxamount = 10,
        },
        Payment = {--If you want a random payments then replace the number with a math.random(350, 420)
            minamount = 90,
            maxamount = 135,
        },
        Reputation = 3, -- Reputation given after a delivery
    },
}

Config.BoxesData = {
    ['small-box'] = { -- name of the items for the inventory 
        name = `smalldelivery_box`, -- prop names for the delivery boxes
        placement = {
            x = 0.01,
            y =-0.02,
            z =-0.14,
            xrot = 0.0,
            yrot = 0.0,
            zrot = 0.0,
        }
    },
    ['medium-box'] = {
        name = `mediumdelivery_box`,
        placement = {
            x = 0.01,
            y =-0.02,
            z =-0.12,
            xrot = 0.0,
            yrot = 0.0,
            zrot = 0.0,
        }
    },
    ['large-box'] = {
        name = `largedelivery_box`,
        placement = {
            x = 0.01,
            y =-0.02,
            z =-0.12,
            xrot = 0.0,
            yrot = 0.0,
            zrot = 0.0,
        }
    },
    ['large-box2'] = {
        name = `largedelivery_box2`,
        placement = {
            x = 5,
            y =-0.02,
            z = -0.17,
            xrot = 0.0,
            yrot = 0.0,
            zrot = -90.0,
        }
    },
}