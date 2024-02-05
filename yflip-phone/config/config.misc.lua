Config = Config or {}

Config.CityName = "Los Santos" -- The name that's being used in the weather app etc.
Config.RealTime = false         -- if true, the time will use real life time depending on where the user lives, if false, the time will be the ingame time.

Config.PhoneModel =
`prop_yflip-phone` -- the prop of the phone, if you want to use a custom phone model, you can change this here

-- The time in ms that a player has to await for a call to be answered
-- Multiplied by Config.CallRepeats - 2000 x 10 = 20 seconds(default)
Config.RepeatTimeout = 2000
Config.CallRepeats = 10
Config.AllowAnonymousCalls = true -- Allow anonymous calls to be made to players.

-- This config will generate number in the format of -- 088 XXXX (default)
-- Refer to `server/custom/functions/misc.lua` if you want to customize the phone number generation.
Config.PhoneNumberPrefix = "213" -- Prefix for phone numbers (default - 088)
Config.PhoneNumberLength = 4     -- Length of phone numbers (excluding prefix, default - 4)

Config.KeepInput = true          -- Keep input when nui is focused (meaning you can walk around etc)

Config.MouseLook = { 1, 2, 3, 4, 5, 6 }

Config.MainControlActions = { 263, 264, 257, 140, 141, 142, 143, 177, 200, 202, 322, 245, 37, 192, 204, 211, 349, 14,
    15, 16, 17, 81, 82, 24, 47, 58 }

Config.CurrencyFormat = "{amount}$" -- (100) Choose the formatting of the currency. {amount} - !!! DO NOT CHANGE !!!
Config.CurrencySymbol = "$"         -- Used as prefix/suffix in some places.
Config.CurrencyLabel = 'usd'        -- Used as prefix/suffix in some places.

Config.GroupMembersLimit = 4 -- The limit of members in a group.

Config.Biometrics = {}
Config.Biometrics.CheckForGloves = true -- Whether to check for gloves when using biometrics. Default *false. - Adjust that in `client\custom\functions\biometrics.lua`

Config.UpdateUserPhoneNumber = false     -- Whether to update the phone number in the users/players(charinfo) table in the database when the phone is setup(won't work for unique phones). Default *false.

Config.Maps = {}
Config.Maps.RealTimeLocation = false   -- Whether to sync the location of the player with the map app in realtime.
Config.Maps.SyncLocationTimeout = 1500 -- The time in ms that the location of the player will be synced with the map app. Default *1500ms == 1.5s.

-- !! Only for QBCore !!
Config.Death = {}
Config.Death.CheckDeathTimeout = 2500 -- Check for death. (default 2500ms == 2.5s). !! Only for QBCore !!
Config.Death.LastStand = true         -- Enable phone usage on last stand. !! Only for QBCore !!

-- !! Only for QBCore !!

Config.YBuy = {}
Config.YBuy.Categories = { -- Categories for the YBuy app when creating a new ad.
    {
        value = "realestate",
        label = "Real Estate"
    },
    {
        value = "vehicles",
        label = "Vehicles"
    },
    {
        value = "electronics",
        label = "Electronics"
    },
    {
        value = "services",
        label = "Services"
    },
    {
        value = "other",
        label = "Other"
    }
}

Config.QuickShare = {}
-- Whether to show the full name of the player when sharing a contact. Default *true.
-- If false, only the ID will be shown.
Config.QuickShare.ShowFullName = false
