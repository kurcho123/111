Config = Config or {}

Config.Debug = false -- Run this only when prompted на Sigma Developments ( otherwise leave it false )
Config.prop = "bkr_prop_fakeid_tablet_01a"
Config.aniM = "amb@world_human_seat_wall_tablet@female@base"
Config.desk = "base"
Config.ModelATM = 'prop_atm_02'
Config.item_needed = "fleeca_card"
Config.item_neededHack = "hak_kit"
Config.RopeItemName = "rope"
Config.ATMOBJItemName = "atmobj"
Config.ElectricName = "electronickit"
Config.MinimumPolice = 4 -- minimum police to start heist
Config.Jobs = "police" -- Jobs Cops
Config.Cooldown = 5 -- minutes / reset vault time // check the server side line 77
Config.Cooldownrope = 30

Config.RewardAccount = 'cash'
Config.RewardRope = math.random(5000, 10000)
Config.Reason = 'Обир на банкомат'
Config.CrackIcon = "fas fa-recycle"
Config.TextLength = 2000

Config.Model = {
    'prop_atm_01',
    'prop_atm_03',
    'prop_atm_02',
}

Config.Atm = {
    moneyprop = "bkr_prop_money_unsorted_01"
}

Config.Progresstimes = function(type)
    if type == 'atmstart' then
        return 15000
    elseif type == 'atmrobbery' then
        return 40000
    elseif type == "atmrope" then
        return 7000
    end
end

Config.Thermite = {
    boxes = 7, -- boxes(number)
    time = 15000, -- time(milliseconds)
    rounds = 2, --rounds(number)
    repetitions = math.random(1,1), -- Minigame replays
    showTime = 3000 , -- showTime(milliseconds)
}