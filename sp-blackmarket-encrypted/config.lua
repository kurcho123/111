Blackmarket = {
    Invincible = true,
    Frozen = true,
    Stoic = true,
    Fade = true,
    Distance = 10.0,
    MinusOne = true,
}

Blackmarket.NPCs = {
    -- Enter = {
    --     -- Spawning
    --     Model = "a_m_m_eastsa_02",
    --     Coords = vector3(-1079.21, -856.13, 5.04),
    --     Heading = 218.04, 
    --     Gender = "male",
    --     AnimDict = "amb@world_human_partying@female@partying_cellphone@idle_a",
    --     AnimName = "idle_a",
    --     IsRendered = false,
    --     Ped = nil,

    --     -- Target
    --     Options = {
    --         { targetIcon = "fa-solid fa-user-secret", distance = 2.5 },
    --         {
    --             label = "Влез в Blackmarket",
    --             icon = "fa-solid fa-right-to-bracket",
    --             distance = 2,
    --             canInteract = function()
    --                 local canInteract = CanPlayerInteract("isCrime", false)
    --                 print(canInteract, "config")
    --                 return canInteract
    --             end,
    --             onSelect = function()
    --                 EnterBlackmarket()
    --             end
    --         }
    --     }
    -- },

    DeliveryPoint = {
        -- Spawning
        Model = "a_m_m_fatlatin_01",
        Coords = vector3(-1062.99, -1641.59, 4.49),
        Heading = 311.88, 
        Gender = "male",
        AnimDict = "amb@world_human_partying@female@partying_cellphone@idle_a",
        AnimName = "idle_a",
        IsRendered = false,
        Ped = nil,

        -- Target
        Options = {
            { targetIcon = "fa-solid fa-user-secret", distance = 2.5 },
            {
                label = "Предай продукти",
                icon = "fa-solid fa-box",
                distance = 2,
                onSelect = function()
                    DeliverGoods()
                end
            }
        }
    },
}

Blackmarket.Jobs = {
    Robber = {
        Item = "robber-box",
        Location = vector3(-433.81, -1710.46, 18.99),
        BoxesStolen = 0,
        Boxes = {
            [1] = { Coords = vector3(-421.90, -1673.61, 19.03), IsRobbed = false },
            [2] = { Coords = vector3(-415.16, -1676.33, 19.03), IsRobbed = false },
            [3] = { Coords = vector3(-425.64, -1700.29, 19.09), IsRobbed = false },
            [4] = { Coords = vector3(-427.19, -1723.09, 19.12), IsRobbed = false },
            [5] = { Coords = vector3(-445.62, -1720.89, 18.65), IsRobbed = false },
        },
    },
    Hacker = {
        Item = "hacker-note",
        Location = vector3(549.21, -1614.56, 28.48),
        BoxesStolen = 0,
        Boxes = {
            [1] = { Coords = vector3(526.12, -1650.91, 29.32), IsRobbed = false },
            [2] = { Coords = vector3(517.04, -1652.03, 29.28), IsRobbed = false },
            [3] = { Coords = vector3(556.31, -1622.54, 28.39), IsRobbed = false },
        },
    },
    Dealer = {
        Item = "dealer-box",
        Location = vector3(104.08, -1940.95, 20.80),
        BoxesStolen = 0,
        Boxes = {
            [1] = { Coords = vector3(118.32, -1921.15, 21.32), IsRobbed = false },
            [2] = { Coords = vector3(126.94, -1929.89, 21.38), IsRobbed = false },
            [3] = { Coords = vector3(76.29, -1948.10, 21.17), IsRobbed = false },
        },
    },
}