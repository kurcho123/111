Config = {}

Config.Locations = {
    Counters = {
        [1] = { Coords = vector3(89.30, 288.88, 111.17 - 1), PlayerWorking = nil, Label = "Касов Апарт", Icon = "fa-solid fa-cash-register", Event = "sp-upnatom:client:open-cash-register", Params = 1 },
        [2] = { Coords = vector3(89.67, 287.67, 111.25 - 1), PlayerWorking = nil, Label = "Касов Апарт", Icon = "fa-solid fa-cash-register", Event = "sp-upnatom:client:open-cash-register", Params = 2 },
        [3] = { Coords = vector3(90.24, 286.59, 111.16 - 1), PlayerWorking = nil, Label = "Касов Апарт", Icon = "fa-solid fa-cash-register", Event = "sp-upnatom:client:open-cash-register", Params = 3 },
    },
    Freezers = {
        [1] = { Coords = vector3(89.52, 294.29, 111.12 - 1), Label = "Фризер", Icon = "fa-solid fa-box", Event = "sp-upnatom:client:open-freezer" },
        [2] = { Coords = vector3(88.76, 292.01, 111.15 - 1), Label = "Фризер", Icon = "fa-solid fa-box", Event = "sp-upnatom:client:open-freezer" },
    },
    CuttingBoards = {
        [1] = { Coords = vector3(97.02, 293.93, 111.19 - 1), IsBusy = false, Label = "Дъска за рязане", Icon = "fa-solid fa-utensils", Event = "sp-upnatom:client:open-cutting-board", Params = 1 },
        [2] = { Coords = vector3(96.55, 292.79, 111.15 - 1), IsBusy = false, Label = "Дъска за рязане", Icon = "fa-solid fa-utensils", Event = "sp-upnatom:client:open-cutting-board", Params = 2 },
    },
    PotatoFriers = {
        [1] = { Coords = vector3(93.23, 292.66, 111.16 - 1), IsBusy = false, Label = "Фритюрник", Icon = "fa-solid fa-fire-burner", Event = "sp-upnatom:client:open-potato-frier", Params = 1 },
        [2] = { Coords = vector3(92.80, 291.70, 111.17 - 1), IsBusy = false, Label = "Фритюрник", Icon = "fa-solid fa-fire-burner", Event = "sp-upnatom:client:open-potato-frier", Params = 2 },
    },
    FriesPacking = {
        [1] = { Coords = vector3(92.43, 290.94, 111.24 - 1), IsBusy = false, Label = "Пакетиране на картофки", Icon = "fa-solid fa-box-open", Event = "sp-upnatom:client:open-potato-packer", Params = 1 },
    },
    EverythingElseFriers = {
        [1] = { Coords = vector3(93.77, 291.32, 111.21 - 1), IsBusy = false, Label = "Скара", Icon = "fa-solid fa-fire-burner", Event = "sp-upnatom:client:open-frier", Params = 1 },
        [2] = { Coords = vector3(94.23, 292.27, 111.23 - 1), IsBusy = false, Label = "Скара", Icon = "fa-solid fa-fire-burner", Event = "sp-upnatom:client:open-frier", Params = 2 },
    },
    DrinksMaker = {
        [1] = { Coords = vector3(93.52, 287.24, 111.49 - 1), IsBusy = false, Label = "Машина за напитки", Icon = "fa-solid fa-martini-glass-citrus", Event = "sp-upnatom:client:open-drink-maker", Params = 1 },
    },
    EatingItemAssembler = {
        [1] = { Coords = vector3(93.89, 293.04, 111.10 - 1), IsBusy = false, Label = "Направи Бургер/Чили Дог", Icon = "fa-solid fa-hotdog", Event = "sp-upnatom:client:open-burger-assembly", Params = 1 },
    },
}

Config.Packaging = { Coords = vector3(93.66, 290.58, 111.20 - 1), IsBusy = false }
Config.Tray = { Coords = vector3(92.03, 284.65, 111.17 - 1) }

Config.Menu = {
    [1] = { 
        Item = "Троен Бургер", 
        ItemName = "upnatom-triple-burger",
        Price = 20,
        Aditionals = {
            [1] = { Item = "Зеле", ItemName = "upnatom_lettuce" },
            [2] = { Item = "Домат", ItemName = "upnatom-tomato" },
            [3] = { Item = "Лук", ItemName = "upnatom-onion" },
            [4] = { Item = "Бекон", ItemName = "upnatom-bacon" },
            [5] = { Item = "Краставички", ItemName = "upnatom-pickles" },
            [6] = { Item = "Кетчуп", ItemName = "upnatom-ketchup" },
            [7] = { Item = "Майонеза", ItemName = "upnatom-mayonaise" },
            [8] = { Item = "Горчица", ItemName = "upnatom-mustard" },
            [9] = { Item = "Месо", ItemName = "upnatom-meat" },
        },
    },
    [2] = { 
        Item = "Троен Чийз Бургер", 
        ItemName = "upnatom-triple-cheese-burger", 
        Price = 25,
        Aditionals = {
            [1] = { Item = "Зеле", ItemName = "upnatom_lettuce" },
            [2] = { Item = "Домат", ItemName = "upnatom-tomato" },
            [3] = { Item = "Лук", ItemName = "upnatom-onion" },
            [4] = { Item = "Бекон", ItemName = "upnatom-bacon" },
            [5] = { Item = "Краставички", ItemName = "upnatom-pickles" },
            [6] = { Item = "Кетчуп", ItemName = "upnatom-ketchup" },
            [7] = { Item = "Майонеза", ItemName = "upnatom-mayonaise" },
            [8] = { Item = "Горчица", ItemName = "upnatom-mustard" },
            [9] = { Item = "Месо", ItemName = "upnatom-meat" },
        },
    },
    [3] = { 
        Item = "Троен Бургер - 10 Парчета Бекон", 
        ItemName = "upnatom-bacon-triple-burger", 
        Price = 30,
        Aditionals = {
            [1] = { Item = "Зеле", ItemName = "upnatom_lettuce" },
            [2] = { Item = "Домат", ItemName = "upnatom-tomato" },
            [3] = { Item = "Лук", ItemName = "upnatom-onion" },
            [4] = { Item = "Краставички", ItemName = "upnatom-pickles" },
            [5] = { Item = "Кетчуп", ItemName = "upnatom-ketchup" },
            [6] = { Item = "Майонеза", ItemName = "upnatom-mayonaise" },
            [7] = { Item = "Горчица", ItemName = "upnatom-mustard" },
            [8] = { Item = "Месо", ItemName = "upnatom-meat" },
        },
    },
    [4] = { 
        Item = "Троен Чийз Бургер - 10 Парчета Бекон", 
        ItemName = "upnatom-bacon-triple-cheese-burger", 
        Price = 35,
        Aditionals = {
            [1] = { Item = "Зеле", ItemName = "upnatom_lettuce" },
            [2] = { Item = "Домат", ItemName = "upnatom-tomato" },
            [3] = { Item = "Лук", ItemName = "upnatom-onion" },
            [4] = { Item = "Краставички", ItemName = "upnatom-pickles" },
            [5] = { Item = "Кетчуп", ItemName = "upnatom-ketchup" },
            [6] = { Item = "Майонеза", ItemName = "upnatom-mayonaise" },
            [7] = { Item = "Горчица", ItemName = "upnatom-mustard" },
            [8] = { Item = "Месо", ItemName = "upnatom-meat" },
        },
    },
    [5] = { 
        Item = "Чили Дог", 
        ItemName = "upnatom-chilidog", 
        Price = 10,
        Aditionals = {
            [1] = { Item = "Лук", ItemName = "upnatom-onion" },
            [2] = { Item = "Краставички", ItemName = "upnatom-pickles" },
            [3] = { Item = "Кетчуп", ItemName = "upnatom-ketchup" },
            [4] = { Item = "Майонеза", ItemName = "upnatom-mayonaise" },
            [5] = { Item = "Горчица", ItemName = "upnatom-mustard" },
            [6] = { Item = "Месо", ItemName = "upnatom-meat" },
        },
    },
    [6] = { 
        Item = "Картофки", 
        ItemName = "upnatom-fries", 
        Price = 5,
        Aditionals = nil,
    },
    [7] = { 
        Item = "Млечен Шейк", 
        ItemName = "upnatom-milkshake", 
        Price = 5,
        Aditionals = nil,
    },
    [8] = { 
        Item = "Сода", 
        ItemName = "upnatom-soda", 
        Price = 8,
        Aditionals = {
            [1] = { Item = "Лед", ItemName = "upnatom-ice" }
        },
    },
    [9] = { 
        Item = "Кафе", 
        ItemName = "upnatom-coffee", 
        Price = 5,
        Aditionals = {
            [1] = { Item = "Лед", ItemName = "upnatom-ice" }
        },
    },
    [10] = { 
        Item = "Оранг-О-Танг", 
        ItemName = "upnatom-orangotang", 
        Price = 15,
        Aditionals = {
            [1] = { Item = "Лед", ItemName = "upnatom-ice" }
        },
    },
    [11] = { 
        Item = "Вода", 
        ItemName = "water", 
        Price = 5,
        Aditionals = nil,
    },
}

Config.Cuttables = {
    [1] = { Item = "Зеле", ItemName = "upnatom-lettuce-uncut", ItemGives = "upnatom_lettuce" },
    [2] = { Item = "Домат", ItemName = "upnatom-tomato-uncut", ItemGives = "upnatom-tomato" },
    [3] = { Item = "Лук", ItemName = "upnatom-onion-uncut", ItemGives = "upnatom-onion" },
    [4] = { Item = "Бекон", ItemName = "upnatom-bacon-uncut", ItemGives = "upnatom-bacon-unfried" },
    [5] = { Item = "Краставички", ItemName = "upnatom-pickles-uncut", ItemGives = "upnatom-pickles" },
    [6] = { Item = "Картоф", ItemName = "upnatom-potato-uncut", ItemGives = "upnatom-fries-unfried" },
}

Config.Friables = {
    [1] = { Item = "Месо", ItemName = "upnatom-meat-unfried", ItemGives = "upnatom-meat" },
    [2] = { Item = "Бекон", ItemName = "upnatom-bacon-unfried", ItemGives = "upnatom-bacon" },
}

Config.Drinkables = {
    [1] = { 
        Item = "Млечен Шейк", 
        ItemName = "upnatom-cup", 
        ItemGives = "upnatom-milkshake",
        Aditionals = nil,
    },
    [2] = { 
        Item = "Сода", 
        ItemName = "upnatom-cup", 
        ItemGives = "upnatom-soda",
        Aditionals = {
            [1] = { Item = "Лед", ItemName = "upnatom-ice" }
        },
    },
    [3] = { 
        Item = "Кафе", 
        ItemName = "upnatom-cup", 
        ItemGives = "upnatom-coffee",
        Aditionals = {
            [1] = { Item = "Лед", ItemName = "upnatom-ice" }
        },
    },
    [4] = { 
        Item = "Оранг-О-Танг", 
        ItemName = "upnatom-cup", 
        ItemGives = "upnatom-orangotang",
        Aditionals = {
            [1] = { Item = "Лед", ItemName = "upnatom-ice" }
        },
    },
}