Config = {}

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.AutoCamPosition = true -- If true it'll set the camera position automatically

Config.AutoCamRotation = true -- If true it'll set the camera rotation automatically

Config.HideMinimap = true -- If true it'll hide the minimap when interacting with an NPC

Config.UseOkokTextUI = false -- If true it'll use okokTextUI 

Config.CameraAnimationTime = 1000 -- Camera animation time: 1000 = 1 second

Config.TalkToNPC = {
    [1] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Пешо Гангстера', -- Text under the header
        uiText = "Говори с Пешо", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Какво искаш от мен, цървул? Мога да ти предложа някои много хубави неща. Бъди внимателен с избора ти.', -- Text showm on the message bubble 
        coordinates = vector3(-1951.01, -228.02, 29.78 - 1), -- coordinates of NPC
        heading = 143.27, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Как да обера къща?', 1, 'c'}, -- 'c' for client
        {'Какво може да ми предложиш?', 2, 'c'}, -- 's' for server (if you write something else it'll be server by default)
        {"Ще те убия.", 3, 'c'}, {"Дай ми шперц.", 4, 'c'}}
    },

    [2] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Гошо Коката', -- Text under the header
        uiText = "Говори с Гошо", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Какво искаш от мен, цървул? Мога да ти предложа някои много хубави неща. Бъди внимателен с избора ти.', -- Text showm on the message bubble 
        coordinates = vector3(-1914.97, 901.59, 71.31 - 1), -- coordinates of NPC
        heading = 8.03, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Защо ми говориш така? Кой беше ти?', "sp-runs:client:coke:spawn-npc-killers", 'c'}, -- 'c' for client
        {'С какво се занимаваш?', 5, 'c'}, -- 's' for server (if you write something else it'll be server by default)
        {"Да не съм те видял повече тук.", "sp-runs:client:coke:spawn-npc-killers", 'c'},
        {"Може ли малко кока?", 6, 'c'}}
    },

    [3] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Зеленият Магьосник', -- Text under the header
        uiText = "Говори с Магьосника", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, наркоманче. Избери своя шедьовър от менюто', -- Text showm on the message bubble 
        coordinates = vector3(-1961.02, -221.01, 29.78 - 1), -- coordinates of NPC
        heading = 143.30, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Аз не съм наркоман!!', "sp-runs:client:coke:spawn-npc-killers", 'c'}, -- 'c' for client
        {'С какво се занимаваш?', 7, 'c'}, -- 's' for server (if you write something else it'll be server by default)
        {"Искаш ли пакетирана Трева?", 8, 'c'},
        {"Звъня на ушаците", "sp-runs:client:coke:spawn-npc-killers", 'c'}}
    },
    [4] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Питър Търговеца', -- Text under the header
        uiText = "Говори с Питър", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, наркоманче. Какво ще желаеш?', -- Text showm on the message bubble 
        coordinates = vector3(-1970.68, -232.44, 29.78 - 1), -- coordinates of NPC
        heading = 323.79, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Искам да си купя нещо!!', "sp-weedplanting:client:shop", 'c'}, -- 'c' for client
        {'Не желая нищо от теб!!', "sp-weedplanting:client:why", 'c'} -- 'c' for client
        }
    },
    [5] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Пешо Обирджията', -- Text under the header
        uiText = "Говори с Пешо Обирджията", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, гангстерче. Как мога да ти помогна?', -- Text showm on the message bubble 
        coordinates = vector3(-1975.54, -224.63, 29.78 - 1), -- coordinates of NPC
        heading = 230.77, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Искам да работя за теб.', 9, 'c'}, -- 'c' for client
        {'Добре ли си?', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [6] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Иван Хакера', -- Text under the header
        uiText = "Говори с Иван Хакера", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, гангстерче. Как мога да ти помогна?', -- Text showm on the message bubble 
        coordinates = vector3(-1973.28, -221.25, 29.78 - 1), -- coordinates of NPC
        heading = 233.42, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Искам да работя за теб.', 10, 'c'}, -- 'c' for client
        {'Добре ли си?', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [7] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Боби Дилъра', -- Text under the header
        uiText = "Говори с Боби Дилъра", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, гангстерче. Как мога да ти помогна?', -- Text showm on the message bubble 
        coordinates = vector3(-1971.02, -218.01, 29.78 - 1), -- coordinates of NPC
        heading = 231.96, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Искам да работя за теб.', 11, 'c'}, -- 'c' for client
        {'Добре ли си?', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [8] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Джеймс Бургеров', -- Text under the header
        uiText = "Говори с Джеймс Бургеров", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Джеймс Бургеров и съм шеф на Up-n-Atom. Искаш да се присъединиш към нас ли?', -- Text showm on the message bubble 
        coordinates = vector3(88.21, 297.77, 110.21 - 1), -- coordinates of NPC
        heading = 161.84, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Започни/Свърши Работа', 'sp-upnatom:server:toggle-duty', 's'}, -- 'c' for client
            {'Дрехи', 12, 'c'}, -- 'c' for client
        }
    },
    [9] = {
        npc = 'g_m_m_mexboss_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Пенчо Репатраков', -- Text under the header
        uiText = "Говори с Пенчо Репатраков", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Пенчо Репатраков и съм шеф на Репатраците. Искаш да се присъединиш към нас ли?', -- Text showm on the message bubble 
        coordinates = vector3(409.01, -1622.89, 29.29 - 1), -- coordinates of NPC
        heading = 228.82, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Извади/Върни Репатрак', "sp-tow:client:get-flatbed", 'c'}, -- 'c' for client
        {'Искам да работя', 13, 'c'} -- 'c' for client
        }
    },
    [10] = {
        npc = 'mp_m_securoguard_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Данчо Катаджията', -- Text under the header
        uiText = "Говори с Данчо Катаджията", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Данчо Катаджията и съм тук, за да ти помогна с всичките ти полицейски проблеми. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(458.76, -986.73, 26.39 - 1), -- coordinates of NPC
        heading = 90.93, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Извади автомобил', "sp-police:client:vehicle-menu", 'c'}, -- 'c' for client
        {'Лични вещи', "qb-police:client:openStash", 'c'}, -- 'c' for client
        {'Изхвърли ненужни вещи', "qb-police:client:openTrash", 'c'} -- 'c' for client
        }
    },
    [11] = {
        npc = 's_m_m_paramedic_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Гошо Медиков', -- Text under the header
        uiText = "Говори с Гошо Медиков", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Гошо Медиков и съм тук, за да ти помогна с всичките ти медицински нужди. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(349.78, -1403.38, 32.42 - 1), -- coordinates of NPC
        heading = 48.38, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Излекувай се', "qb-ambulancejob:checkin", 'c'}, -- 'c' for client
        {'Здравни осигуровки', "sp-insurance:Client:MenuHealthInsurance", 'c'} -- 'c' for client
        }
    },
    [12] = {
        npc = 's_m_m_security_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Иван Охранителов', -- Text under the header
        uiText = "Говори с Иван Охранителов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Иван Охранителов и съм шеф на Union Depository. Мога да ти оправя финансовите проблеми. Искаш да се присъединиш към нас ли?', -- Text showm on the message bubble 
        coordinates = vector3(-7.16, -653.83, 33.45 - 1), -- coordinates of NPC
        heading = 185.70, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Започни/Свърши Работа', "sp-gruppe:client:try-start-finish-job", 'c'}, -- 'c' for client
            {'Дрехи', 14, 'c'}, -- 'c' for client
        }
    },
    [13] = {
        npc = 'a_m_m_business_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Коцето Василев', -- Text under the header
        uiText = "Говори с Коцето Василев", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Коцето Василев и съм шеф на Дигиталната Ера. Мога да ти оправя финансовите проблеми. Искаш да се присъединиш към нас ли?', -- Text showm on the message bubble 
        coordinates = vector3(1137.46, -470.73, 66.66 - 1), -- coordinates of NPC
        heading = 257.53, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Започни/Свърши Работа', "sp-digitalera:client:try-start-finish-job", 'c'} -- 'c' for client
        }
    },
    [14] = {
        npc = 's_m_m_ups_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Петър Цинцарски', -- Text under the header
        uiText = "Говори с Петър Цинцарски", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Петър Цинцарски и съм шеф на Posp OP Deliveries. Мога да ти оправя финансовите проблеми. Искаш да се присъединиш към нас ли?', -- Text showm on the message bubble 
        coordinates = vector3(-429.53, -2786.3, 6.0 - 1), -- coordinates of NPC
        heading = 44.00, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Започни/Свърши Работа', "sp-deliveries:client:try-start-finish-job", 'c'} -- 'c' for client
        }
    },
    -- Wine
    [15] = {
        npc = 'csb_chef', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Кирил Алкохоликов', -- Text under the header
        uiText = "Говори с Кирил Алкохоликов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Кирил Алкохоликов и съм шеф на Винарната. Мога да ти оправя финансовите проблеми. Започни работа сега или никога!', -- Text showm on the message bubble 
        coordinates = vector3(-1879.29, 2071.80, 141.00 - 1), -- coordinates of NPC
        heading = 349.41, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Магазин', "sp-wine:client:openShop", 'c'}, -- 'c' for client
            --{'Запази неща', "sp-wine:client:OpenStash", 'c'}, -- 'c' for client
            {'Направи си вино', "sp-wine:client:Crafting", 'c'}, -- 'c' for client
            --{'Продай вино', "sp-wine:client:sellmenu", 'c'} -- 'c' for client
        }
    },
    [17] = {
        npc = 'a_m_m_soucent_02', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Пенчо Чопчов', -- Text under the header
        uiText = "Говори с Пенчо Чопчов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Пенчо Чопчов и се крия тук, за да не ме хванат. Ако желаеш, мога да ти предложа някои сочни неща, нооо внимавай в какво се забъркваш. Изборът е твой.', -- Text showm on the message bubble 
        coordinates = vector3(-233.15, -731.24, 16.40 - 1), -- coordinates of NPC
        heading = 25.50, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Искам да работя', 'sp-choshop:server:try-start-job', 's'}, -- 'c' for client
            {'Магазин', 'sp-choshop:client:open-chop-shop', 'c'}, -- 'c' for client
        }
    },
    [18] = {
        npc = 'cs_bankman', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Банкер Банкерчов', -- Text under the header
        uiText = "Говори с Банкер Банкерчов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Банкер Банкерчов и съм тук, за да ти взема паричките. Какво ще желаеш да ти открадна днес? Само не ми взимай парите, моля те!', -- Text showm on the message bubble 
        coordinates = vector3(269.25, 217.15, 106.28 - 1), -- coordinates of NPC
        heading = 69.55, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Предай Чанти', 'sp-gruppe:client:sell-bag', 'c'}, -- 'c' for client
            {'Осребри Чекове', 'sp-upnatom:client:get-payslip-money', 'c'}, -- 'c' for client
        }
    },
    [19] = {
        npc = 'mp_m_securoguard_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Гошо Докторов', -- Text under the header
        uiText = "Говори с Гошо Докторов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Гошо Докторов и съм тук, за да ти помогна с всичките ти медицински проблеми. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(305.95, -1456.93, 29.97 - 1), -- coordinates of NPC
        heading = 305.95, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Извади автомобил', "sp-ajob:client:vehicle-menu", 'c'}, -- 'c' for client
        }
    },
    [20] = {
        npc = 'mp_m_securoguard_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Гошо Докторов', -- Text under the header
        uiText = "Говори с Гошо Докторов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Гошо Докторов и съм тук, за да ти помогна с всичките ти медицински проблеми. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(312.62, -1451.97, 46.51 - 1), -- coordinates of NPC
        heading = 160.11, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Извади Хеликоптер', "sp-ajob:client:heli-menu", 'c'}, -- 'c' for client
        }
    },
    [21] = {
        npc = 'a_m_m_genfat_02', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Шишо Златаров', -- Text under the header
        uiText = "Говори с Шишо Златаров", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Шишо Златаров и съм тук, за да ти изкупя живота. Какво ще ми предложиш днес?', -- Text showm on the message bubble 
        coordinates = vector3(1383.45, 4305.45, 36.66 - 1), -- coordinates of NPC
        heading = 30.68, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Какво ще ми предложиш?', "sp-pawnshop:client:sellmenu", 'c'}, -- 'c' for client
        }
    },
    [22] = {
        npc = 'csb_chef', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Кирил Алкохоликов', -- Text under the header
        uiText = "Говори с Кирил Алкохоликов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Кирил Алкохоликов и съм шеф на Винарната. Мога да ти оправя финансовите проблеми. Започни работа сега или никога!', -- Text showm on the message bubble 
        coordinates = vector3(-1221.14, -907.76, 12.33 - 1), -- coordinates of NPC
        heading = 36.19, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Продай вино', "sp-wine:client:sellmenu", 'c'} -- 'c' for client -- 'c' for client
        }
    },
    [23] = {
        npc = 'mp_m_securoguard_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Данчо Катаджията', -- Text under the header
        uiText = "Говори с Данчо Катаджията", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Данчо Катаджията и съм тук, за да ти помогна с всичките ти полицейски проблеми. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(482.17, -1011.30, 45.91 - 1), -- coordinates of NPC
        heading = 10.98, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Извади Хеликоптер', "sp-policejob:client:policeheli-menu", 'c'}, -- 'c' for client
        }
    },
    [24] = {
        npc = 'mp_m_securoguard_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Данчо Катаджията', -- Text under the header
        uiText = "Говори с Данчо Катаджията", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Данчо Катаджията и съм тук, за да ти помогна с всичките ти полицейски проблеми. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(-832.97, -1412.25, 1.61 - 1), -- coordinates of NPC
        heading = 291.39, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
        {'Извади Лодка', "sp-policejob:client:boats-menu", 'c'}, -- 'c' for client
        }
    },
    [25] = {
        npc = 'mp_m_securoguard_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Робърт Адвокатина', -- Text under the header
        uiText = "Говори с Робърт Адвокатина", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Робърт Адвокатина и съм тук, за да ти помогна с всичките ти адвокатски проблеми. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(259.17, -1573.20, 29.29 - 1), -- coordinates of NPC
        heading = 49.20, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Извади Кола', "sp-policejob:client:lawyer-vehicles-menu", 'c'}, -- 'c' for client
        }
    },
    [26] = {
        npc = 'g_m_y_korlieut_01', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Йоан Диамантов', -- Text under the header
        uiText = "Говори с Йоан Диамантов", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Йоан Диамантов и съм тук, за да те направя един от най-богатите гангстери в града. Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(-1947.82, -230.26, 29.78 - 1), -- coordinates of NPC
        heading = 147.53, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Започни Обир На Vangelico', "sp-heists:client:jewelry:start-job", 'c'}, -- 'c' for client
            {'Започни Обир На Art Gallery', "sp-heists:client:gallery:start-job", 'c'}, -- 'c' for client
        }
    },
    [27] = {
        npc = 'ig_bankman', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Гошко Банкеров', -- Text under the header
        uiText = "Говори с Гошко Банкеров", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Гошко Банкеров и съм тук, за да те направя един от най-богатите гангстери в града, но може би и нещо повече??? Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(-1944.46, -232.61, 29.78 - 1), -- coordinates of NPC
        heading = 144.65, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Започни Обир На Pacific Bank', "sp-heists:client:pacific:start-job", 'c'}, -- 'c' for client
            {'Започни Обир На Paleto Bank', "sp-heists:client:paleto:start-job", 'c'}, -- 'c' for client
            {'Започни Обир На Fleeca Bank', "sp-heists:client:fleeca:start-job", 'c'}, -- 'c' for client
        }
    },
    [28] = {
        npc = 'ig_bankman', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Тошо Амфетата', -- Text under the header
        uiText = "Говори с Тошо Амфетата", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Тошо Амфетата и съм тук, за да те направя един от най-дрогираните гангстери в града, но може би и нещо повече??? Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(27.84, -1905.14, 5.07 - 1), -- coordinates of NPC
        heading = 89.79, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Дай ми амфета', "sp-drugs:client:start-job", 'c'}, -- 'c' for client
        }
    },
    [29] = {
        npc = 'ig_bankman', -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        name = 'Криско Бийтс', -- Text under the header
        uiText = "Говори с Криско Бийтс", -- Name shown on the notification when near the NPC
        icon = "fas fa-person",
        dialog = 'Здравей, приятелче. Аз съм Криско Бийтс и съм тук, за да те направя един от най-дрогираните гангстери в града, но може би и нещо повече??? Какво ще желаеш от мен днес?', -- Text showm on the message bubble 
        coordinates = vector3(242.35, -1833.78, 3.07 - 1), -- coordinates of NPC
        heading = 229.89, -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0), -- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0), -- Camera rotation 					| (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5, -- From how far the player can interact with the NPC
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Дай ми дрогаа', "sp-drugs:client:start-job", 'c'}, -- 'c' for client
        }
    },
} 

Config.SubMenus = {
    -- Pesho The Gansta (House)
    [1] = {
        name = 'Пешо Гангстера', -- Text under the header
        dialog = 'Това е сериозно нещо. Сигурен ли си, че искаш да се забъркаш?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, готов съм.', 'sp-houserobbery:server:get-job', 's'}, -- 'c' for client
            {'Не, пу**а съм.', 'sp-talk:client:fuckoff', 'c'} -- 's' for server (if you write something else it'll be server by default)
        }
    },
    [2] = {
        name = 'Пешо Гангстера', -- Text under the header
        dialog = 'Мога дати предложа *** в ******? Искаш ли?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, татенце.', 'sp-houserobbery:server:removemoney-players', 's'}, -- 'c' for client
            {'Не, татенце.', 'sp-houserobbery:server:removemoney-players', 's'} -- 's' for server (if you write something else it'll be server by default)
        }
    },
    [3] = {
        name = 'Пешо Гангстера', -- Text under the header
        dialog = 'Не се връщай тук или аз ще те убия.', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Добре, добре, без нерви.', 'sp-houserobbery:server:cooldown-players', 's'} -- 'c' for client
        }
    },
    [4] = {
        name = 'Пешо Гангстера', -- Text under the header
        dialog = 'Сигурен ли си, че искаш БЕЗПЛАТЕН шперц?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, шефе.', 'sp-houserobbery:server:buy-lockpick', 's'}, -- 'c' for client
            {'Не, шефе.', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [5] = {
        name = 'Гошо Коката', -- Text under the header
        dialog = 'Обирам градините на бабите? Искаш ли да пробваш?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, шефе.', 'sp-runs:server:coke:get-job', 's'}, -- 'c' for client
            {'Не, шефе.', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [6] = {
        name = 'Гошо Коката', -- Text under the header
        dialog = 'Естествено, че може. Колко искаш?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'10 пакета', 'sp-runs:server:coke:removemoney-players-10', 's'}, -- 'c' for client
            {'100 пакета', 'sp-runs:server:coke:removemoney-players-100', 'c'} -- 'c' for client
        }
    },
    --------WeedRun
    [7] = {
        name = 'Зеленият Магьосник', -- Text under the header
        dialog = 'Работя като "професионален разказвач на сънища".', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Не ми е интересно но Разкажи?', 'sp-runs:client:ClockIn', 'c'}, -- 'c' for client
            {'Звучи интересно. Разкажи ми?', 'sp-runs:client:scaming', 'c'} -- 'c' for client
        }
    },
    [8] = {
        name = 'Зеленият Магьосник', -- Text under the header
        dialog = 'Аз мога да я пакетирам само!', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Пакетирай ми 20 пакета!', 'sp-runs:client:Start', 'c'}, -- 'c' for client
            {'Искам си пакетите Наркоман!', 'sp-runs:server:CollectPackageGoods', 's'} -- 'c' for client
        }
    },

    -- Blackmarket
    [9] = {
        name = 'Пешо Обирджията', -- Text under the header
        dialog = 'Сигурен ли си, че искаш да се забъркаш в тези схеми? Няма връщане назад след това...', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, сигурен съм!', 'sp-blackmarket:client:talk-robber', 'c'}, -- 'c' for client
            {'Не, ще си помисля!', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [10] = {
        name = 'Иван Хакера', -- Text under the header
        dialog = 'Сигурен ли си, че искаш да се забъркаш в тези схеми? Няма връщане назад след това...', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, сигурен съм!', 'sp-blackmarket:client:talk-hacker', 'c'}, -- 'c' for client
            {'Не, ще си помисля!', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },
    [11] = {
        name = 'Боби Дилъра', -- Text under the header
        dialog = 'Сигурен ли си, че искаш да се забъркаш в тези схеми? Няма връщане назад след това...', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Да, сигурен съм!', 'sp-blackmarket:client:talk-dealer', 'c'}, -- 'c' for client
            {'Не, ще си помисля!', 'sp-talk:client:fuckoff', 'c'} -- 'c' for client
        }
    },

    -- Up an atom
    [12] = {
        name = 'Джеймс Бургеров', -- Text under the header
        dialog = 'Готов ли си да бачкаш яката?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Работни Дрехи', 'sp-upnatom:client:work-clothes', 'c'}, -- 'c' for client
            {'Цивилни Дрехи', 'sp-upnatom:client:civil-clothes', 'c'} -- 'c' for client
        }
    },

    -- Tow
    [13] = {
        name = 'Пенчо Репатраков', -- Text under the header
        dialog = 'Готов ли си да бачкаш яката?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Започни Работа (Ще бъдеш назначен "Репатрак")', 'sp-tow:client:start-working', 'c'}, -- 'c' for client
            {'Свърши Работа (Ще бъдеш назначен "Безработен")','sp-tow:client:stop-working', 'c'} -- 'c' for client
        }
    },

    -- Gruppe
    [14] = {
        name = 'Иван Охранителов', -- Text under the header
        dialog = 'Готов ли си да бачкаш яката?', -- Text showm on the message bubble 
        options = { -- Options shown when interacting (Maximum 6 options per NPC)
            {'Работни Дрехи', "sp-gruppe:client:work-clothes", 'c'}, -- 'c' for client
            {'Цивилни Дрехи', "sp-gruppe:client:civil-clothes", 'c'}, -- 'c' for client
        }
    }
}