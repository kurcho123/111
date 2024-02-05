Config = Config or {}

Config.Voice = "pma"
--[[
    Supported voice systems:
        * pma: pma-voice - RECOMMENDED
        * mumble: mumble-voip - Not recommended, use pma-voice
        * salty: saltychat - Not reFcommended, use pma-voice
        * toko: tokovoip - Not recommended, use pma-voice
]]
Config.Radio = {}

Config.Radio.MaxFrequency = 500

Config.Radio.RestrictedChannels = {
    [1] = { -- [ channel ] = { Allowed jobs }
        police = true,
        ambulance = true
    },
}
