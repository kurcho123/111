local QBCore = exports['qb-core']:GetCoreObject()

local isJudge = false
local isPolice = false
local isTow = false
local isTaxi = false
local isMedic = false
local isDead = false
local myJob = "Unemployed"
local isHandcuffed = false
local hasOxygenTankOn = false
local bennyscivpoly = false
local onDuty = false
local inGarage = false
local inDepots = false

Config = {}
Config.TrunkClasses = {
    [0] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [1] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sedans
    [2] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- SUVs
    [3] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [4] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Muscle
    [5] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports Classics
    [6] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports
    [7] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Super
    [8] = {allowed = false, x = 0.0, y = -1.0, z = 0.25}, -- Motorcycles
    [9] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Off-road
    [10] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Industrial
    [11] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Utility
    [12] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Vans
    [13] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Cycles
    [14] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Boats
    [15] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Helicopters
    [16] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Planes
    [17] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Service
    [18] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Emergency
    [19] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Military
    [20] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Commercial
    [21] = {allowed = true, x = 0.0, y = -1.0, z = 0.25} -- Trains
}

rootMenuConfig =  {
    {
        id = "blips",
        displayName = "GPS",
        icon = "#blips",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return not isdead
        end,
        subMenus = { "blips:gasstations", "blips:barbershop", "blips:TattoShops", "fk:karakol", "fk:hastane", "fk:galeri"}
    },
    {
        id = "General",
        displayName = "Основни",
        icon = "#globe-europe",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return not isdead and not IsPedInAnyVehicle(PlayerPedId(), true)
        end,
        subMenus = {"general:getintrunk", "general:documents", "general:Emotes", "general:invoices"}
    },
    {
        id = "exclamation",
        displayName = "Интеракций",
        icon = "#Exclamation",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return not isdead and not IsPedInAnyVehicle(PlayerPedId(), true)
        end,
        subMenus = {"exclamation:enter", "exclamation:exit", "exclamation:stealplayer", "exclamation:escort", "exclamation:escort2", "exclamation:take"}
    },
    {
        id = "clothesmenu",
        displayName = "Дрехи",
        icon = "#Shirt",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return not isdead and not IsPedInAnyVehicle(PlayerPedId(), true)
        end,
        subMenus = {
            "shirts:Hair", 
            "shirts:Ear", 
            "shirts:Neck", 
            "shirts:Top", 
            "shirts:Shirt", 
            "shirts:Pants", 
            "shirts:Shoes",
            "shirts:Hat", 
            "shirts:Glasses", 
            "shirts:Visor", 
            "shirts:Mask", 
            "shirts:Vest", 
            "shirts:Bag",
            "shirts:Bracelet",
            "shirts:Watch",
            "shirts:Gloves",
        }
    },
    {
        id = "copDead",
         displayName = "11-A",
         icon = "#police-dead",
         functionName = "sp-radial:coPDead",
         enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return (isPolice or isMedic) and isdead -- and onDuty 
          end,
     },
    {    
        id = "Police",
        displayName = "Полицески действия",
        icon = "#police-action",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return isPolice and not isdead
        end,
        subMenus = {"police:mdt", "police:checkstatus", "police:searchplaye", "police:jailplayer", "police:panick", "police:razbiikola", "police:callsign"}
    },
    {    
        id = "PoliceObjects",
        displayName = "Действия с предмети",
        icon = "#police-action",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return isPolice and not isdead and not IsPedInAnyVehicle(PlayerPedId(), true)
        end,
        subMenus = {"police:spawn1", "police:spawn2", "police:spawn3", "police:spawn4", "police:spawn5", "police:del"}
    },
    {    
        id = "VehExtra",
        displayName = "Ексри с автомобил",
        icon = "#k9-spawn",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]
            local Data = QBCore.Functions.GetPlayerData()
            return (isPolice and not isdead and IsPedInAnyVehicle(PlayerPedId(), false) and Data.job ~= nil and Data.job.name == "police")
        end,
        subMenus = {
            "police:extra1",
            "police:extra2",
            "police:extra3",
            "police:extra4",
            "police:extra5",
            "police:extra6",
            "police:extra7",
            "police:extra8",
            "police:extra9",
            "police:extra10",
            "police:extra11",
            "police:extra12",
            "police:extra13",
        }
    },
    {    
        id = "veh-save",
        displayName = "Запази Автомобил",
        icon = "#k9-vehicle",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]
            return not isdead and IsPedInAnyVehicle(PlayerPedId(), false)
        end,
        functionName = "sp-radialmenu:client:save-vehicle",
        eventType = "client"
    },
    -- {   
    --     id = "Vehicle",
    --     displayName = "Меню за Кола",
    --     icon = "#k9-vehicle",
    --     --functionName = "carmenuOpen",
    --     enableMenu = function()
    --         return (not isDead and IsPedInAnyVehicle(PlayerPedId(), true))
    --     end
    --     subMenus = {
            
    --     }
    -- },
    {    
        id = "PolRadio",
        displayName = "Радио",
        icon = "#k9-spawn",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local isdead = Player.metadata["isdead"]

            return isPolice and not isdead
        end,
        subMenus = {
            "police:radio1",
            "police:radio2",
            "police:radio3",
            "police:radio4",
            "police:radio5",
            "police:radio6",
            "police:radio7",
            "police:radio8",
            "police:radio9",
            "police:radio10",
        }
    },
}

newSubMenus = { -- NOTE basicly, what will be happen after clicking these buttons and icon of them
    ['general:getintrunk'] = {
        title = "Влез в багажник",
        icon = "#car",
        functionName = "qb-trunk:client:GetIn" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    },
    ['general:Emotes'] = {
        title = "Анимации",
        icon = "#general-emotes",
        functionName = "emotemenu",
        eventType = "command",
    },
    ['general:invoices'] = {
        title = "Фактури",
        icon = "#file-word",
        functionName = "sp-billing:open:menu",
        eventType = "client",
    },
    ['general:documents'] = {
        title = "Документи",
        icon = "#file-word",
        functionName = "documents",
        eventType = "command"
    },
    ---------sadjskaldasd
    ['exclamation:enter'] = {
        title = "Вкарай",
        icon = "#CarSide1", -- Emolt
        functionName = "police:client:PutPlayerInVehicle",
    },
    ['exclamation:exit'] = {
        title = "Изкарай",
        icon = "#CarSide1", -- Emolt
        functionName = "police:client:SetPlayerOutVehicle",
    },
    ['exclamation:stealplayer'] = {
        title = "Обери",
        icon = "#Robbery", -- emolt
        functionName = "police:client:RobPlayer",
    },
    ['exclamation:escort'] = {
        title = "Отвлечи",
        icon = "#Discract", -- emolt
        functionName = "police:client:KidnapPlayer",
    },
    ['exclamation:escort2'] = {
        title = "Ескортирай",
        icon = "#general-escort", -- emolt
        functionName = "police:client:EscortPlayer",
    },
    ['exclamation:take'] = {
        title = "Вземи заложник",
        icon = "#Clid", -- emolt
        functionName = "A5:Client:TakeHostage",
    },
    -----Shirts
    ['shirts:Hair'] = {
        title = "Коса",
        icon = "#hair", -- emolt
        functionName = "hair",
        eventType = "command"
    },
    ['shirts:Ear'] = {
        title = "Обеци",
        icon = "#ear", -- emolt
        functionName = "ear",
        eventType = "command"
    },
    ['shirts:Neck'] = {
        title = "Врат",
        icon = "#neak", -- emolt
        functionName = "neck",
        eventType = "command"
    },
    ['shirts:Top'] = {
        title = "Горнище",
        icon = "#Shirt", -- emolt
        functionName = "top",
        eventType = "command"
    },
    ['shirts:Shirt'] = {
        title = "Тениска",
        icon = "#Shirt", -- emolt
        functionName = "shirt",
        eventType = "command"
    },
    ['shirts:Pants'] = {
        title = "Панталони",
        icon = "#pants", -- emolt
        functionName = "pants",
        eventType = "command"
    },
    ['shirts:Shoes'] = {
        title = "Обувки",
        icon = "#shoes", -- emolt
        functionName = "shoes",
        eventType = "command"
    },
    ------Екстри
    ['shirts:Hat'] = {
        title = "Шапка",
        icon = "#hair", -- emolt
        functionName = "hat",
        eventType = "command"
    },
    ['shirts:Glasses'] = {
        title = "Очила",
        icon = "#arcade-stop-spectating", -- emolt
        functionName = "glasses",
        eventType = "command"
    },
    ['shirts:Visor'] = {
        title = "Визъор",
        icon = "#blindfold", -- emolt
        functionName = "visor",
        eventType = "command"
    },
    ['shirts:Mask'] = {
        title = "Маска",
        icon = "#oxygen-mask", -- emolt
        functionName = "mask",
        eventType = "command"
    },
    ['shirts:Vest'] = {
        title = "Жилетка",
        icon = "#vests", -- emolt
        functionName = "vest",
        eventType = "command"
    },
    ['shirts:Bag'] = {
        title = "Чанта",
        icon = "#bagpack", -- emolt
        functionName = "bag",
        eventType = "command"
    },
    ['shirts:Bracelet'] = {
        title = "Гривна",
        icon = "#cuffs", -- emolt
        functionName = "bracelet",
        eventType = "command"
    },
    ['shirts:Watch'] = {
        title = "Часовник",
        icon = "#watch", -- emolt
        functionName = "watch",
        eventType = "command"
    },
    ['shirts:Gloves'] = {
        title = "Ръкавици",
        icon = "#gloves", -- emolt
        functionName = "gloves",
        eventType = "command"
    },
    ---------
    ['blips:gasstations'] = {
        title = "Газстанция",
        icon = "#blips-gasstations",
        functionName = "sp-radial:togglegas"
    },
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['blips:TattoShops'] = {
        title = "Тато Студио",
        icon = "#tottos",
        functionName = "sp-radial:toggletattos"
    },
    ['blips:barbershop'] = {
        title = "Фризьор",
        icon = "#blips-barbershop",
        functionName = "sp-radial:togglebarber"
    },
    ['fk:galeri'] = {
        title = "PDM",
        icon = "#blips-garages",
        functionName = "fk:galeri"
    },
    ['fk:karakol'] = {
        title = "LSPD",
        icon = "#police-action",
        functionName = "fk:karakol"
    },
    ['fk:hastane'] = {
        title = "Болница",
        icon = "#hospital",
        functionName = "fk:hastane"
    },
    -------------

    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouth Breather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-swagger",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },	
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swag",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Gangster",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Sassy3",
        icon = "#animation-sassy",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "Sassy2",
        icon = "#animation-sassy",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Normal",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['general:rob'] = {
        title = "Rob",
        icon = "#general-contact",
        functionName = "police:client:RobPlayer" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    },
    ['general:playerinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    },
    ['general:playeroutvehicle'] = {
        title = "Unseat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:SetPlayerOutVehicle" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    },
    --  POLICE 
    ['police:mdt'] = {
        title = "MDT",
        icon = "#mdt",
        functionName = "mdt",
        eventType = "command"  
    },
    ['police:checkstatus'] = {
        title = "Провери статус",
        icon = "#weed-cultivation-request-status",
        functionName = "police:client:CheckStatus",
    },
    ['police:searchplaye'] = {
        title = "Претърси",
        icon = "#k9-sniff",
        functionName = "police:client:SearchPlayer",
    },
    ['police:jailplayer'] = {
        title = "Изпрати в затвор",
        icon = "#cuffs-cuff",
        functionName = "police:client:JailPlayer",
    },
    ['police:panick'] = {
        title = "Паник бутон",
        icon = "#police-dead",
        functionName = "sp-radial:PanikButton",
    },
    ['police:razbiikola'] = {
        title = "Разбий кола",
        icon = "#k9-vehicle",
        functionName = "qb-vehiclekeys:client:razbiikola",
    },
    ['police:callsign'] = {
        title = "Баджов номер",
        icon = "#k9-sniff",
        functionName = "sp-police:client:callsign",
    },
    -- POLICE
    ['police:spawn1'] = {
        title = "Конус",
        icon = "#cone",
        functionName = "police:client:spawnCone"     
    },   
    ['police:spawn2'] = {
        title = "Шипове",
        icon = "#cone",
        functionName = "police:client:SpawnSpikeStrip" 
    },
    ['police:spawn3'] = {
        title = "Бариера",
        icon = "#cone",
        functionName = "police:client:spawnBarrier" 
    },
    ['police:spawn4'] = {
        title = "Палатка",
        icon = "#cone",
        functionName = "police:client:spawnTent" 
    },
    ['police:spawn5'] = {
        title = "Лампа",
        icon = "#cone",
        functionName = "police:client:spawnLight" 
    },
    ['police:del'] = {
        title = "Премахни",
        icon = "#obj-trash",
        functionName = "police:client:deleteObject"     
    },
    ------Police Extra ---------
    ['police:extra1'] = {
        title = "Екстра 1",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra2'] = {
        title = "Екстра 2",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra3'] = {
        title = "Екстра 3",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra4'] = {
        title = "Екстра 4",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra5'] = {
        title = "Екстра 5",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra6'] = {
        title = "Екстра 6",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra7'] = {
        title = "Екстра 7",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra8'] = {
        title = "Екстра 8",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra9'] = {
        title = "Екстра 9",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra10'] = {
        title = "Екстра 10",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra11'] = {
        title = "Екстра 11",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra12'] = {
        title = "Екстра 12",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ['police:extra13'] = {
        title = "Екстра 13",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ----Cars Control-----
    ['carmenu:extra13'] = {
        title = "Екстра 13",
        icon = "#vehicle-flight-data",
        functionName = "qb-radialmenu:client:setExtra"     
    },
    ----------------
    -- Radio
    ['police:radio1'] = {
        title = "Станция 1",
        icon = "#vehicle-flight-data",
        functionName = "police:radio1"     
    },
    ['police:radio2'] = {
        title = "Станция 2",
        icon = "#vehicle-flight-data",
        functionName = "police:radio2"     
    },
    ['police:radio3'] = {
        title = "Станция 3",
        icon = "#vehicle-flight-data",
        functionName = "police:radio3"     
    },
    ['police:radio4'] = {
        title = "Станция 4",
        icon = "#vehicle-flight-data",
        functionName = "police:radio4"     
    },
    ['police:radio5'] = {
        title = "Станция 5",
        icon = "#vehicle-flight-data",
        functionName = "police:radio5"     
    },
    ['police:radio6'] = {
        title = "Станция 6",
        icon = "#vehicle-flight-data",
        functionName = "police:radio6"     
    },
    ['police:radio7'] = {
        title = "Станция 7",
        icon = "#vehicle-flight-data",
        functionName = "police:radio7"     
    },
    ['police:radio8'] = {
        title = "Станция 8",
        icon = "#vehicle-flight-data",
        functionName = "police:radio8"     
    },
    ['police:radio9'] = {
        title = "Станция 9",
        icon = "#vehicle-flight-data",
        functionName = "police:radio9"     
    },
    ['police:radio10'] = {
        title = "Станция 10",
        icon = "#vehicle-flight-data",
        functionName = "police:radio10"   
    },
    -- HOSPITAL
    ['medic:status'] = {
        title = "StatusCheck",
        icon = "#general-cuff",
        functionName = "" 
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#hospital-revivep",
        functionName = "hospital:client:RevivePlayer"
    },
    ['medic:treat'] = {
        title = "Heal wounds",
        icon = "#hospital-treat",
        functionName = "hospital:client:TreatWounds"
    },
    ['medic:stretcherspawn'] = {
        title = "Stretcher",
        icon = "#general-cuff",
        functionName = "hospital:client:TakeStretcher" 
    }, 
    ['medic:stretcherremove'] = {
        title = "Stretcher Remove",
        icon = "#general-cuff",
        functionName = "hospital:client:RemoveStretcher" 
    },  --TOW --TOW
    ['tow:togglenpc'] = {
        title = "Toggle Npc",
        icon = "#tow-mission",
        functionName = "jobs:client:ToggleNpc"
    }, 
    ['tow:vehicle'] = {
        title = "Tow vehicle",
        icon = "#tow-tow",
        functionName = "qb-tow:client:TowVehicle"
    },  -- Taxi
    ['taxi-meter'] = {
        title = "Toggle Npc",
        icon = "#tow-mission",
        functionName = "qb-taxi:client:toggleMeter"
    }, 
    ['taxi:npc'] = {
        title = "Taxi mission",
        icon = "#tow-tow",
        functionName = "qb-taxi:client:DoTaxiNpc"
    },  
    ['taxi:startmeter'] = {
        title = "Start/Stop meter",
        icon = "#tow-tow",
        functionName = "qb-taxi:client:enableMeter"
    },
    ['set:extra'] = {
        title = "Exra",
        icon = "#tow-tow",
        functionName = "qb-radialmenu:client:setExtra"
    },

    ['k9:spawn'] = {
        title = "Summon",
        icon = "#k9-spawn",
        functionName = "K9:Create"
    },
    ['k9:delete'] = {
        title = "Dismiss",
        icon = "#k9-dismiss",
        functionName = "K9:Delete"
    },
    ['k9:follow'] = {
        title = "Follow",
        icon = "#k9-follow",
        functionName = "K9:Follow"
    },
    ['k9:vehicle'] = {
        title = "Get in/out",
        icon = "#k9-vehicle",
        functionName = "K9:Vehicle"
    },
    ['k9:sit'] = {
        title = "Sit",
        icon = "#k9-sit",
        functionName = "K9:Sit"
    },
    ['k9:lay'] = {
        title = "Lay",
        icon = "#k9-lay",
        functionName = "K9:Lay"
    },
    ['k9:stand'] = {
        title = "Stand",
        icon = "#k9-stand",
        functionName = "K9:Stand"
    },
    ['k9:sniff'] = {
        title = "Sniff Person",
        icon = "#k9-sniff",
        functionName = "K9:Sniff"
    },
    ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "sniffVehicle"
    },
    ['k9:huntfind'] = {
        title = "Hunt nearest",
        icon = "#k9-huntfind",
        functionName = "K9:Huntfind"
    },
}
    

RegisterNetEvent("isJudge") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff") -- opposite of the above
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("isTow") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTow", function()
    isTow = true
end)

RegisterNetEvent("isTowOff") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTowOff", function()
    isTow = false
end)

RegisterNetEvent("isTaxi") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTaxi", function()
    isTaxi = true
end)

RegisterNetEvent("isTaxiOff") -- opposite of the above
AddEventHandler("isTaxiOff", function()
    isTaxi = false
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate") -- dont edit this unless you don't use qb-core
AddEventHandler("QBCore:Client:OnJobUpdate", function(jobInfo)
    myJob = jobInfo.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if isTow and myJob ~= "tow" then isTow = false end
    if isTaxi and myJob ~= "taxi" then isTaxi = false end
    if myJob == "police" then isPolice = true end
    if myJob == "tow" then isTow = true end
    if myJob == "taxi" then isTaxi = true end
    if myJob == "ambulance" then isMedic = true end
end)

RegisterNetEvent('QBCore:Client:SetDuty') -- dont edit this unless you don't use qb-core
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    myJob = QBCore.Functions.GetPlayerData().job.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if myJob == "police" then isPolice = true onDuty = duty end
    if myJob == "ambulance" then isMedic = true onDuty = duty end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded") -- dont edit this unless you don't use qb-core
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    myJob = PlayerData.job.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if isTow and myJob ~= "tow" then isTow = false end
    if isTaxi and myJob ~= "taxi" then isTaxi = false end
    if myJob == "police" then isPolice = true end
    if myJob == "tow" then isTow = true end
    if myJob == "taxi" then isTaxi = true end
    if myJob == "ambulance" then isMedic = true end
end)

-- CreateThread(function()
--     if QBCore == nil then return end
--     local PlayerData = QBCore.Functions.GetPlayerData()

--     if PlayerData ~= nil then
--         myJob = PlayerData.job.name
--         if isMedic and myJob ~= "ambulance" then isMedic = false end
--         if isPolice and myJob ~= "police" then isPolice = false end
--         if isTow and myJob ~= "tow" then isTow = false end
--         if isTaxi and myJob ~= "taxi" then isTaxi = false end
--         if myJob == "police" then isPolice = true end
--         if myJob == "tow" then isTow = true end
--         if myJob == "taxi" then isTaxi = true end
--         if myJob == "ambulance" then isMedic = true end
--     end
-- end)

RegisterNetEvent('deathcheck') -- YOU SHOULD ADD THIS IN YOUR ambulancejob system, basically let the function trigger here when the ped playing anim and add this to
-- your revived function so everytime if person dies, this will be triggered to isDead = true, if he get revived this will be triggered to isDead = false
AddEventHandler('deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)


RegisterNetEvent("police:currentHandCuffedState") -- add this your police:client:GetCuffed @qb-policejob\client\interactions.lua
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed)
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank") -- add this to your oxygentank wear place, idk where is this for qb-inventory so find out please
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)


RegisterNetEvent('police:client:PutInVehicle')
AddEventHandler('police:client:PutInVehicle', function()
    if isEscorted then
    end
end)

Config.Commands = {
    ["top"] = {
        Func = function() ToggleClothing("Top") end,
        Sprite = "top",
        Desc = "Свали/Сложи тениската си", --Take your shirt off/on
        Button = 1,
        Name = "Torso"
    },
    ["gloves"] = {
        Func = function() ToggleClothing("gloves") end,
        Sprite = "gloves",
        Desc = "Свали/Сложи ръкавиците си", --Take your gloves off/on
        Button = 2,
        Name = "Gloves"
    },
    ["visor"] = {
        Func = function() ToggleProps("visor") end,
        Sprite = "visor",
        Desc = "Действия с шапката", --Toggle hat variation
        Button = 3,
        Name = "Visor"
    },
    ["bag"] = {
        Func = function() ToggleClothing("Bag") end,
        Sprite = "bag",
        Desc = "Отвори/Затвори чантата си", --Opens or closes your bag
        Button = 8,
        Name = "Bag"
    },
    ["shoes"] = {
        Func = function() ToggleClothing("Shoes") end,
        Sprite = "shoes",
        Desc = "Свали/Сложи обувките си", --Take your shoes off/on
        Button = 5,
        Name = "Shoes"
    },
    ["vest"] = {
        Func = function() ToggleClothing("Vest") end,
        Sprite = "vest",
        Desc = "Свали/Сложи жилетката си", --Take your vest off/on
        Button = 14,
        Name = "Vest"
    },
    ["hair"] = {
        Func = function() ToggleClothing("hair") end,
        Sprite = "hair",
        Desc = "Отвържи/Вържи си косата", --Put your hair up/down/in a bun/ponytail.
        Button = 7,
        Name = "Hair"
    },
    ["hat"] = {
        Func = function() ToggleProps("Hat") end,
        Sprite = "hat",
        Desc = "Свали/Сложи шапката си", --Take your hat off/on
        Button = 4,
        Name = "Hat"
    },
    ["glasses"] = {
        Func = function() ToggleProps("Glasses") end,
        Sprite = "glasses",
        Desc = "Свали/Сложи очилата си", --Take your glasses off/on
        Button = 9,
        Name = "Glasses"
    },
    ["ear"] = {
        Func = function() ToggleProps("Ear") end,
        Sprite = "ear",
        Desc = "Свали/Сложи обеците си", --Take your ear accessory off/on
        Button = 10,
        Name = "Ear"
    },
    ["neck"] = {
        Func = function() ToggleClothing("Neck") end,
        Sprite = "neck",
        Desc = "Свали/Сложи колието си", --Take your neck accessory off/on
        Button = 11,
        Name = "Neck"
    },
    ["watch"] = {
        Func = function() ToggleProps("Watch") end,
        Sprite = "watch",
        Desc = "Свали/Сложи часоника си", --Take your watch off/on
        Button = 12,
        Name = "Watch",
        Rotation = 5.0
    },
    ["bracelet"] = {
        Func = function() ToggleProps("Bracelet") end,
        Sprite = "bracelet",
        Desc = "Свали/Сложи гривната си", --Take your bracelet off/on
        Button = 13,
        Name = "Bracelet"
    },
    ["mask"] = {
        Func = function() ToggleClothing("Mask") end,
        Sprite = "mask",
        Desc = "Свали/Сложи маската си", --Take your mask off/on
        Button = 6,
        Name = "Mask"
    }
}

local bags = {[40] = true, [41] = true, [44] = true, [45] = true}
Config.ExtrasEnabled = true
Config.ExtraCommands = {
    ["pants"] = {
        Func = function() ToggleClothing("Pants", true) end,
        Sprite = "pants",
        Desc = "Свали/Сложи долнището си", --Take your pants off/on
        Name = "Pants",
        OffsetX = -0.04,
        OffsetY = 0.0
    },
    ["shirt"] = {
        Func = function() ToggleClothing("Shirt", true) end,
        Sprite = "shirt",
        Desc = "Свали/Сложи тениската си", --Take your shirt off/on
        Name = "shirt",
        OffsetX = 0.04,
        OffsetY = 0.0
    },
    ["reset"] = {
        Func = function()
            if not ResetClothing(true) then
                Notify('Nothing To Reset', 'error')
            end
        end,
        Sprite = "reset",
        Desc = "Върни всичко обратно", --Revert everything back to normal
        Name = "reset",
        OffsetX = 0.12,
        OffsetY = 0.2,
        Rotate = true
    },
    ["bagoff"] = {
        Func = function() ToggleClothing("Bagoff", true) end,
        Sprite = "bagoff",
        SpriteFunc = function()
            local Bag = GetPedDrawableVariation(PlayerPedId(), 5)
            local BagOff = LastEquipped["Bagoff"]
            if LastEquipped["Bagoff"] then
                if bags[BagOff.Drawable] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            end
            if Bag ~= 0 then
                if bags[Bag] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            else
                return false
            end
        end,
        Desc = "Свали/Вземи чантата си", --Take your bag off/on
        Name = "bagoff",
        OffsetX = -0.12,
        OffsetY = 0.2
    }
}
