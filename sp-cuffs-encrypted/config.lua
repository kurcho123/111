Config = {}

Config.CuffItem = 'handcuffs'
Config.CuffKeysItem = 'handcuffs_keys'
Config.RopeItem = 'rope'
Config.BagToHeadItem = 'head_bag'
Config.ElectronicCuffItem = 'electrocuff'
Config.ElectronicCuffTrackerItem = 'electrocufftracker'

Config.OpenMenuKey = 167  --f6
Config.InventoryOpenKey = 289 -- Disables this input when user is cuffed
Config.DisableWhenUserCuffed = {289, 37, 192, 204, 211, 349} -- Disables these input when user is cuffed

Config.HandcuffIMG = 'https://raw.githubusercontent.com/0resmon/db/main/img/black.png'
Config.HandcuffDefaultIMG = 'https://raw.githubusercontent.com/0resmon/db/main/img/prop_chrome_03.png'
Config.HandcuffSound = 'https://raw.githubusercontent.com/0resmon/db/main/sound/handcuff.mp3'

Config.RealtimeGPS = true -- WARNING: Enabling this option will enable realtime gps isntead of just marking gps location on tablet but it may cause a lot of cps/ram usage on both client and server side.
Config.RealtimeGPSRefreshMS = 5000 -- WARNING: This option directly affect cpu/ram usage, so be carefull when changing it! It controls how fast the gps will refresh itself

Config.TestMode = false

Config.GetClosestPlayer = function()
   return ESX.Game.GetClosestPlayer()
end

Config.Lang = {
    ["no_one_nearby"] = "There is no one around.",
    ["no_one_nearby_cuff"] = "There is no one nearby who can handcuff.",
    ["no_one_nearby_cuff2"] = "The person must raise their hands.",
    ["menu_title"] = "Action Menu",
    ["put_bag"] = "Remove the bag from the head",
    ["arac_bin"] = "Put the player in the car",
    ["arac_in"] = "Get the player out of the car",
    ["bacak_coz"] = "Untie the rope from the legs",
    ["bant_cikar"] = "Tape/untape the mouth",
    ["tasi"] = "Move the player",
    ["birak"] = "Release the player",
    ["tape_type"] = "Select tape type",
    ["bant"] = "Black Tape",
    ["money"] = "Cash",
}

Config.MenuElements = {
  
    { value = "arac_bin", label = Config.Lang["arac_bin"] },
    { value = "arac_in", label = Config.Lang["arac_in"] },
    { value = "bacak_coz", label = Config.Lang["bacak_coz"] },
    { value = "bant_cikar", label = Config.Lang["bant_cikar"] },
    { value = "tasi", label = Config.Lang["tasi"] },
    { value = "birak", label = Config.Lang["birak"] }
}
