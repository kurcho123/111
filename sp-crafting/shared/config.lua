-- Configuration settings for the GPS system.
Config                = {}

-- Debug print setting for displaying debug messages.
Config.DebugPrint     = true

-- Locale setting for language localization.
Config.Locale         = "en"

-- Do not CHANGE !!!
Config.FrameWork      = nil

-- ("esx_notify" | "qb_notify" | "custom_notify") -- > System to be used
Config.NotifyType     = "esx_notify"

-- ("ox_inventory" | "qb-inventory" | "custom") System to be used
Config.InventoryType  = "ox_inventory"

-- ("ox_target" | "qb-target") System to be used
Config.TargetType     = "ox_target"

Config.PistolCrafts = {
    ["weapon_snspistol"] = {                    -- Item name: weapon_assaultrifle, IT SHOULD BE UNIQUE !!!
        name = "weapon_snspistol",              -- Item name: weapon_assaultrifle, PLEASE SET THE SAME !!!
        label = "SNS Pistol",                   -- Item label text
        propModel = "weapon_snspistol",         -- Object prop model to be created, to show
        count = 1,                                 -- Production output
        duration = 60000,                          -- Production time | milliseconds
        image = "weapons/weapon_snspistol.png", -- Item image path
        --[[
            Ingredients images come from the folder ex: "public/images/items/*".
            If the item starts with "weapon_" it comes from the folder ex: "public/images/weapons/*".
        --]]
        ingredients = {          --Things needed to produce: [item_name] = needs
            sns_handle = 1,
            sns_barrel = 1,
            sns_body = 1,
            sns_accessories = 1,
            sns_trigger = 1,
            metalscrap = 50,
            steel = 50,
            copper = 50,
        },
        price = 1500,            -- Price of item crafting (only bank for now)
    },
    ["weapon_pistol"] = {                    -- Item name: weapon_assaultrifle, IT SHOULD BE UNIQUE !!!
        name = "weapon_pistol",              -- Item name: weapon_assaultrifle, PLEASE SET THE SAME !!!
        label = "Pistol",                   -- Item label text
        propModel = "weapon_pistol",         -- Object prop model to be created, to show
        count = 1,                                 -- Production output
        duration = 60000,                          -- Production time | milliseconds
        image = "weapons/weapon_pistol.png", -- Item image path
        --[[
            Ingredients images come from the folder ex: "public/images/items/*".
            If the item starts with "weapon_" it comes from the folder ex: "public/images/weapons/*".
        --]]
        ingredients = {          --Things needed to produce: [item_name] = needs
            pistol_handle = 1,
            pistol_barrel = 1,
            pistol_body = 1,
            pistol_accessories = 1,
            pistol_trigger = 1,
            metalscrap = 150,
            steel = 150,
            copper = 150,
        },
        price = 5000,            -- Price of item crafting (only bank for now)
    },
    ["weapon_appistol"] = {                    -- Item name: weapon_assaultrifle, IT SHOULD BE UNIQUE !!!
        name = "weapon_appistol",              -- Item name: weapon_assaultrifle, PLEASE SET THE SAME !!!
        label = "AP Pistol",                   -- Item label text
        propModel = "weapon_appistol",         -- Object prop model to be created, to show
        count = 1,                                 -- Production output
        duration = 60000,                          -- Production time | milliseconds
        image = "weapons/weapon_appistol.png", -- Item image path
        --[[
            Ingredients images come from the folder ex: "public/images/items/*".
            If the item starts with "weapon_" it comes from the folder ex: "public/images/weapons/*".
        --]]
        ingredients = {          --Things needed to produce: [item_name] = needs
            ap_pistol_handle = 1,
            ap_pistol_barrel = 1,
            ap_pistol_body = 1,
            ap_pistol_accessories = 1,
            ap_pistol_trigger = 1,
            metalscrap = 100,
            steel = 100,
            copper = 100,
        },
        price = 8000,            -- Price of item crafting (only bank for now)
    },
    ["weapon_heavypistol"] = {                    -- Item name: weapon_assaultrifle, IT SHOULD BE UNIQUE !!!
        name = "weapon_heavypistol",              -- Item name: weapon_assaultrifle, PLEASE SET THE SAME !!!
        label = "Heavy Pistol",                   -- Item label text
        propModel = "weapon_heavypistol",         -- Object prop model to be created, to show
        count = 1,                                 -- Production output
        duration = 60000,                          -- Production time | milliseconds
        image = "weapons/weapon_heavypistol.png", -- Item image path
        --[[
            Ingredients images come from the folder ex: "public/images/items/*".
            If the item starts with "weapon_" it comes from the folder ex: "public/images/weapons/*".
        --]]
        ingredients = {          --Things needed to produce: [item_name] = needs
            heavy_pistol_handle = 1,
            heavy_pistol_barrel = 1,
            heavy_pistol_body = 1,
            heavy_pistol_accessories = 1,
            heavy_pistol_trigger = 1,
            metalscrap = 100,
            steel = 100,
            copper = 100,
        },
        price = 16000,            -- Price of item crafting (only bank for now)
    },
}

-- Enable a shop to access the crafting menu
Config.CraftingTables   = {
    [1] = {
        active = true,
        name = "Гошо Пищака",
        coords = vector4(397.51 - 0.3, -1724.84, 3.07 - 1, 232.13),
        cam = {
            coords = vector3(396.50, -1724.17, 4.70 - 1),
            rotation = vector3(0, 0, 235),
        },
        distance = 2.0,
        blip = {
            active = false,
            name = "Crafting Station",
            spriteId = 544,
            color = 2,
            scale = 0.7
        },
        object = {
            name = "gr_prop_gr_bench_02b",
            preview_spawn_coord = vector3(397.43, -1724.74, 3.87 - 0.2)
        },
        -- "target" | "drawtext"
        interact_type = "target",
        -- Bench theme color: red|blue|green|orange
        color = "red",
        -- You can choose different items for each bench.
        craftableItems = Config.PistolCrafts
    },
}

Config.WeaponAttachment = {
    Bones = {
        ["WAPClip"]     = { label = "Magazine", key = "clip", shift_left = -2, shift_top = 13 },
        ["Gun_GripR"]   = { label = "Skin", key = "skin", shift_left = 2, shift_top = 8 },
        ["WAPSupp"]     = { label = "Muzzle", key = "suppressor", shift_left = -5, shift_top = 8 },
        ["WAPFlshLasr"] = { label = "Tactical", key = "flashlight", shift_left = -8, shift_top = -12 },
        ["WAPScop"]     = { label = "Scope", key = "scope", shift_left = -1, shift_top = -10 },
        ["WAPGrip"]     = { label = "Grip", key = "grip", shift_left = -4, shift_top = 5 },
    },
}

Config.Weapons          = {
    ["weapon_pistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_PISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_PISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP_02" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_PISTOL_VARMOD_LUXE" }
        }
    },
    ["weapon_combatpistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_COMBATPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_COMBATPISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_appistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_APPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_APPISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_APPISTOL_VARMOD_LUXE" }
        }
    },
    ["weapon_pistol50"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_PISTOL50_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_PISTOL50_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_heavy",     type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_PISTOL50_VARMOD_LUXE" }
        }
    },
    ["weapon_snspistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip", hash = "COMPONENT_SNSPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip", hash = "COMPONENT_SNSPISTOL_CLIP_02" },
            { item = "at_skin_luxe",            type = "skin", hash = "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_heavypistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_HEAVYPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_HEAVYPISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_HEAVYPISTOL_VARMOD_LUXE" }
        }
    },
    ["weapon_vintagepistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_VINTAGEPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_VINTAGEPISTOL_CLIP_02" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" }
        }
    },
    ["weapon_machinepistol"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_MACHINEPISTOL_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_MACHINEPISTOL_CLIP_02" },
            { item = "at_clip_drum_smg",     type = "clip",       hash = "COMPONENT_MACHINEPISTOL_CLIP_03" },
            { item = "at_suppressor_light",  type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" }
        }
    },
    ["weapon_smg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_SMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_SMG_CLIP_02" },
            { item = "at_clip_drum_smg",     type = "clip",       hash = "COMPONENT_SMG_CLIP_03" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_macro",       type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO_02" },
            { item = "at_suppressor_light",  type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",         type = "skin",       hash = "COMPONENT_SMG_VARMOD_LUXE" }
        }
    },
    ["weapon_assaultsmg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_ASSAULTSMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_ASSAULTSMG_CLIP_02" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_macro",       type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO" },
            { item = "at_suppressor_heavy",  type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",         type = "skin",       hash = "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_microsmg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_MICROSMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_MICROSMG_CLIP_02" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_scope_macro",       type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO" },
            { item = "at_suppressor_heavy",  type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",         type = "skin",       hash = "COMPONENT_MICROSMG_VARMOD_LUXE" }
        }
    },
    ["weapon_minismg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip", hash = "COMPONENT_MINISMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip", hash = "COMPONENT_MINISMG_CLIP_02" }
        }
    },
    ["weapon_combatpdw"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_COMBATPDW_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_COMBATPDW_CLIP_02" },
            { item = "at_clip_drum_smg",     type = "clip",       hash = "COMPONENT_COMBATPDW_CLIP_03" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_grip",              type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_scope_small",       type = "scope",      hash = "COMPONENT_AT_SCOPE_SMALL" }
        }
    },
    ["weapon_pumpshotgun"] = {
        components = {
            { item = "at_flashlight",       type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_light", type = "suppressor", hash = "COMPONENT_AT_SR_SUPP" },
            { item = "at_skin_luxe",        type = "skin",       hash = "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_sawnoffshotgun"] = {
        components = {
            { item = "at_skin_luxe", type = "skin", hash = "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE" }
        }
    },
    ["weapon_assaultshotgun"] = {
        components = {
            { item = "at_clip_shotgun",          type = "clip",       hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_01" },
            { item = "at_clip_extended_shotgun", type = "clip",       hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_02" },
            { item = "at_flashlight",            type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_heavy",      type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                  type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" }
        }
    },
    ["weapon_bullpupshotgun"] = {
        components = {
            { item = "at_flashlight",       type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_heavy", type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",             type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" }
        }
    },
    ["weapon_heavyshotgun"] = {
        components = {
            { item = "at_clip_shotgun",          type = "clip",       hash = "COMPONENT_HEAVYSHOTGUN_CLIP_01" },
            { item = "at_clip_extended_shotgun", type = "clip",       hash = "COMPONENT_HEAVYSHOTGUN_CLIP_02" },
            { item = "at_clip_drum_shotgun",     type = "clip",       hash = "COMPONENT_HEAVYSHOTGUN_CLIP_03" },
            { item = "at_flashlight",            type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_heavy",      type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",                  type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" }
        }
    },
    ["weapon_assaultrifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_ASSAULTRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_ASSAULTRIFLE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip",       hash = "COMPONENT_ASSAULTRIFLE_CLIP_03" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_macro",         type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_carbinerifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_CARBINERIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_CARBINERIFLE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip",       hash = "COMPONENT_CARBINERIFLE_CLIP_03" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_medium",        type = "scope",      hash = "COMPONENT_AT_SCOPE_MEDIUM" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_CARBINERIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_advancedrifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_ADVANCEDRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_ADVANCEDRIFLE_CLIP_02" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_small",         type = "scope",      hash = "COMPONENT_AT_SCOPE_SMALL" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_specialcarbine"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_SPECIALCARBINE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_SPECIALCARBINE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip",       hash = "COMPONENT_SPECIALCARBINE_CLIP_03" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_medium",        type = "scope",      hash = "COMPONENT_AT_SCOPE_MEDIUM" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_bullpuprifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_BULLPUPRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_BULLPUPRIFLE_CLIP_02" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_small",         type = "scope",      hash = "COMPONENT_AT_SCOPE_SMALL" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_BULLPUPRIFLE_VARMOD_LOW" }
        }
    },
    ["weapon_compactrifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip", hash = "COMPONENT_COMPACTRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip", hash = "COMPONENT_COMPACTRIFLE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip", hash = "COMPONENT_COMPACTRIFLE_CLIP_03" }
        }
    },
    ["weapon_mg"] = {
        components = {
            { item = "at_clip_extended_mg", type = "clip",  hash = "COMPONENT_MG_CLIP_02" },
            { item = "at_scope_small",      type = "scope", hash = "COMPONENT_AT_SCOPE_SMALL_02" },
            { item = "at_skin_luxe",        type = "skin",  hash = "COMPONENT_MG_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_combatmg"] = {
        components = {
            { item = "at_clip_extended_mg", type = "clip",  hash = "COMPONENT_COMBATMG_CLIP_01" },
            { item = "at_clip_extended_mg", type = "clip",  hash = "COMPONENT_COMBATMG_CLIP_02" },
            { item = "at_scope_medium",     type = "scope", hash = "COMPONENT_AT_SCOPE_MEDIUM" },
            { item = "at_grip",             type = "grip",  hash = "COMPONENT_AT_AR_AFGRIP" },
        }
    },
    ["weapon_gusenberg"] = {
        components = {
            { item = "at_clip_extended_mg", type = "clip", hash = "COMPONENT_GUSENBERG_CLIP_01" },
            { item = "at_clip_extended_mg", type = "clip", hash = "COMPONENT_GUSENBERG_CLIP_02" },
        }
    },
    ["weapon_sniperrifle"] = {
        components = {
            { item = "at_scope_large",      type = "scope",      hash = "COMPONENT_AT_SCOPE_LARGE" },
            { item = "at_scope_advanced",   type = "scope",      hash = "COMPONENT_AT_SCOPE_MAX" },
            { item = "at_suppressor_heavy", type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",        type = "skin",       hash = "COMPONENT_SNIPERRIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_heavysniper"] = {
        components = {
            { item = "at_scope_large",    type = "scope", hash = "COMPONENT_AT_SCOPE_LARGE" },
            { item = "at_scope_advanced", type = "scope", hash = "COMPONENT_AT_SCOPE_MAX" }
        }
    },
    ["weapon_marksmanrifle"] = {
        components = {
            { item = "at_clip_sniper",          type = "clip",       hash = "COMPONENT_MARKSMANRIFLE_CLIP_01" },
            { item = "at_clip_extended_sniper", type = "clip",       hash = "COMPONENT_MARKSMANRIFLE_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_large",          type = "scope",      hash = "COMPONENT_AT_SCOPE_LARGE_MK2" },
            { item = "at_suppressor_heavy",     type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                 type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_MARKSMANRIFLE_VARMOD_LUXE" }
        }
    }
}
