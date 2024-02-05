local Blips = {
    ["ClothingStore1"] = { coords = vector4(1693.2, 4828.11, 42.07, 188.66), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore2"] = { coords = vector4(-705.5, -149.22, 37.42, 122), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore3"] = { coords = vector4(-1192.61, -768.4, 17.32, 216.6), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore4"] = { coords = vector4(425.91, -801.03, 29.49, 177.79), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore5"] = { coords = vector4(-168.73, -301.41, 39.73, 238.67), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore6"] = { coords = vector4(75.39, -1398.28, 29.38, 6.73), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore7"] = { coords = vector4(-827.39, -1075.93, 11.33, 294.31), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore8"] = { coords = vector4(-1445.86, -240.78, 49.82, 36.17), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore9"] = { coords = vector4(9.22, 6515.74, 31.88, 131.27), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore10"] = { coords = vector4(615.35, 2762.72, 42.09, 170.51), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore11"] = { coords = vector4(1191.61, 2710.91, 38.22, 269.96), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore12"] = { coords = vector4(-3171.32, 1043.56, 20.86, 334.3), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore13"] = { coords = vector4(-1105.52, 2707.79, 19.11, 317.19), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore14"] = { coords = vector4(-1119.24, -1440.6, 5.23, 300.5), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},
    ["ClothingStore15"] = { coords = vector4(124.82, -224.36, 54.56, 335.41), sprite = 73, color = 34, scale = 0.55, closeRange = true, label = "Магазин за дрехи"},

    ["BarberStore1"] = { coords = vector4(-814.22, -183.7, 37.57, 116.91), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},
    ["BarberStore2"] = { coords = vector4(136.78, -1708.4, 29.29, 144.19), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},
    ["BarberStore3"] = { coords = vector4(-1282.57, -1116.84, 6.99, 89.25), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},
    ["BarberStore4"] = { coords = vector4(1931.41, 3729.73, 32.84, 212.08), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},
    ["BarberStore5"] = { coords = vector4(1212.8, -472.9, 65.2, 60.94), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},
    ["BarberStore6"] = { coords = vector4(-32.9, -152.3, 56.1, 335.22), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},
    ["BarberStore7"] = { coords = vector4(-278.1, 6228.5, 30.7, 49.32), sprite = 71, color = 35, scale = 0.55, closeRange = true, label = "Фризьор"},

    ["TattooStore1"] = { coords = vector4(1322.6, -1651.9, 51.2, 42.47), sprite = 75, color = 36, scale = 0.55, closeRange = true, label = "Студио за татуси"},
    ["TattooStore2"] = { coords = vector4(-1154.01, -1425.31, 4.95, 23.21), sprite = 75, color = 36, scale = 0.55, closeRange = true, label = "Студио за татуси"},
    ["TattooStore3"] = { coords = vector4(322.62, 180.34, 103.59, 156.2), sprite = 75, color = 36, scale = 0.55, closeRange = true, label = "Студио за татуси"},
    ["TattooStore4"] = { coords = vector4(-3169.52, 1074.86, 20.83, 253.29), sprite = 75, color = 36, scale = 0.55, closeRange = true, label = "Студио за татуси"},
    ["TattooStore5"] = { coords = vector4(1864.1, 3747.91, 33.03, 17.23), sprite = 75, color = 36, scale = 0.55, closeRange = true, label = "Студио за татуси"},
    ["TattooStore6"] = { coords = vector4(-294.24, 6200.12, 31.49, 195.72), sprite = 75, color = 36, scale = 0.55, closeRange = true, label = "Студио за татуси"},

    ["FoodStore1"] = { coords = vector3(25.7, -1347.3, 29.49), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore2"] = { coords = vector3(-3038.71, 585.9, 7.9), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore3"] = { coords = vector3(-3241.47, 1001.14, 12.83), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore4"] = { coords = vector3(1728.66, 6414.16, 35.03), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore5"] = { coords = vector3(1697.99, 4924.4, 42.06), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore6"] = { coords = vector3(1961.48, 3739.96, 32.34), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore7"] = { coords = vector3(547.79, 2671.79, 42.15), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore8"] = { coords = vector3(2679.25, 3280.12, 55.24), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore9"] = { coords = vector3(2557.94, 382.05, 108.62), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},
    ["FoodStore10"] = { coords = vector3(373.55, 325.56, 103.56), sprite = 59, color = 46, scale = 0.55, closeRange = true, label = "Хранителен магазин"},

    ["LiquorStore1"] = { coords = vector3(1135.808, -982.281, 46.415), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},
    ["LiquorStore2"] = { coords = vector3(-1222.915, -906.983, 12.326), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},
    ["LiquorStore3"] = { coords = vector3(-1487.553, -379.107, 40.163), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},
    ["LiquorStore4"] = { coords = vector3(-2968.243, 390.910, 15.043), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},
    ["LiquorStore5"] = { coords = vector3(1166.024, 2708.930, 38.157), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},
    ["LiquorStore6"] = { coords = vector3(1392.562, 3604.684, 34.980), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},
    ["LiquorStore7"] = { coords = vector3(-1393.409, -606.624, 30.319), sprite = 93, color = 52, scale = 0.55, closeRange = true, label = "Магазин за алкохол"},

    ["AmmunationStore1"] = { coords = vector3(-662.180, -934.961, 21.829), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore2"] = { coords = vector3(810.25, -2157.60, 29.62), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore3"] = { coords = vector3(1693.44, 3760.16, 34.71), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore4"] = { coords = vector3(-330.24, 6083.88, 31.45), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore5"] = { coords = vector3(252.63, -50.00, 69.94), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore6"] = { coords = vector3(22.56, -1109.89, 29.80), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore7"] = { coords = vector3(2567.69, 294.38, 108.73), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore8"] = { coords = vector3(-1117.58, 2698.61, 18.55), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},
    ["AmmunationStore9"] = { coords = vector3(842.44, -1033.42, 28.19), sprite = 110, color = 46, scale = 0.55, closeRange = true, label = "Оръжеен магазин"},

    ["Digital Den"] = { coords = vector3(392.98, -832.48, 29.29), sprite = 355, color = 50, scale = 0.55, closeRange = true, label = "Digital Den"},

    ["NormalPDM"] = { coords = vector4(-56.5, -1096.58, 26.42-1, 28.94), sprite = 326, color = 3, scale = 0.55, closeRange = true, label = "Автокъща"},
    ["BoatsPDM"] = { coords = vector4(-736.53, -1327.26, 1.6-1, 9.93), sprite = 410, color = 3, scale = 0.55, closeRange = true, label = "Автокъща за лодки"},
    ["AirPDM"] = { coords = vector4(-1622.43, -3154.02, 13.99-1, 52.81), sprite = 251, color = 3, scale = 0.55, closeRange = true, label = "Автокъща за самолети"},
    ["TruckPDM"] = { coords = vector4(900.45, -1155.58, 25.16-1, 175.08), sprite = 477, color = 3, scale = 0.55, closeRange = true, label = "Автокъща за камиони"},

    ["Bank1"] = { coords = vector3(149.9, -1040.46, 29.37), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank2"] = { coords = vector3(314.23, -278.83, 54.17), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank3"] = { coords = vector3(-350.8, -49.57, 49.04), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank4"] = { coords = vector3(-1213.0, -330.39, 37.79), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank5"] = { coords = vector3(-2962.71, 483.0, 15.7), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank6"] = { coords = vector3(1175.07, 2706.41, 38.09), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank7"] = { coords = vector3(246.64, 223.2, 106.29), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},
    ["Bank8"] = { coords = vector3(-113.22, 6470.03, 31.63), sprite = 108, color = 69, scale = 0.55, closeRange = true, label = "Банка"},

    ["Carwash1"] = { coords = vector3(174.81, -1736.77, 28.87), sprite = 100, color = 3, scale = 0.55, closeRange = true, label = "Автомивка"},
    ["Carwash2"] = { coords = vector3(25.2, -1391.98, 28.91), sprite = 100, color = 3, scale = 0.55, closeRange = true, label = "Автомивка"},
    ["Carwash3"] = { coords = vector3(-74.27, 6427.72, 31.02), sprite = 100, color = 3, scale = 0.55, closeRange = true, label = "Автомивка"},
    ["Carwash4"] = { coords = vector3(1362.69, 3591.81, 34.5), sprite = 100, color = 3, scale = 0.55, closeRange = true, label = "Автомивка"},
    ["Carwash5"] = { coords = vector3(-699.84, -932.68, 18.59), sprite = 100, color = 3, scale = 0.55, closeRange = true, label = "Автомивка"},

    ["Bennys1"] = { coords = vector3(-338.67, -136.94, 38.3), sprite = 72, color = 3, scale = 0.55, closeRange = true, label = "Автомобилен тунинг"},
    ["Bennys2"] = { coords = vector3(-211.97, -1324.18, 30.89), sprite = 72, color = 3, scale = 0.55, closeRange = true, label = "Автомобилен тунинг"},

    ["DigitalEra"] = { coords = vector3(1137.46, -470.73, 66.66), sprite = 521, color = 3, scale = 0.55, closeRange = true, label = "ОП Дигитална Ера"},

    ["PostOpDeliveries"] = { coords = vector3(-429.53, -2786.3, 6.0), sprite = 304, color = 3, scale = 0.55, closeRange = true, label = "Доставчик"},

    ["Gruppe6"] = { coords = vector3(-7.16, -653.83, 33.45), sprite = 616, color = 3, scale = 0.55, closeRange = true, label = "Gruppe 6"},
    
    ["Up-n-Atom"] = { coords = vector3(83.78, 280.91, 110.21), sprite = 76, color = 36, scale = 0.55, closeRange = true, label = "Up-n-Atom"},
    ["Up-n-Atom-Store"] = { coords = vector3(28.77, -1770.41, 29.61), sprite = 59, color = 36, scale = 0.55, closeRange = true, label = "Up-n-Atom Магазин"},

    ["WineBoss"] = { coords = vector3(-1878.56, 2071.56, 141.00), sprite = 280, color = 3, scale = 0.55, closeRange = true, label = "Винарна - Работа"},
    ["WineZone"] = { coords = vector3(-1870.33, 2093.99, 139.58), sprite = 464, color = 3, scale = 0.55, closeRange = true, label = "Винарна - Зона за поставяне на бъчва"},
    ["WinePicking"] = { coords = vector3(-1886.90, 2102.25, 138.14), sprite = 274, color = 3, scale = 0.55, closeRange = true, label = "Винарна - Бране"},
    ["WinePicking2"] = { coords = vector3(-1844.17, 2100.61, 139.29), sprite = 274, color = 3, scale = 0.55, closeRange = true, label = "Винарна - Бране"},
    ["WineBoss"] = { coords = vector3(-1220.61, -907.48, 12.33), sprite = 280, color = 3, scale = 0.55, closeRange = true, label = "Винарна - Продажба"},

    ["Cityhall"] = { coords = vector3(325.25, -1631.16, 32.54), sprite = 487, color = 28, scale = 0.85, closeRange = true, label = "Община"},

    ["GaragesRecovery1"] = { coords = vector3(408.975830, -1622.887939, 29.279907), sprite = 67, color = 3, scale = 0.55, closeRange = true, label = "Наказатален паркинг"},
    ["GaragesRecovery2"] = { coords = vector3(489.22, -1315.10, 29.26), sprite = 67, color = 3, scale = 0.55, closeRange = true, label = "Наказатален паркинг"},
}

local CreatedBlips = {}
local BlipsShown = true

CreateThread(function()
    CreateBlips()
end)

function CreateBlips()
    for k, v in pairs(Blips) do
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.sprite) -- This is where the fuel thing will get changed into the electric bolt instead of the pump.
        SetBlipColour(blip, v.color)
        SetBlipScale(blip, v.scale)
        SetBlipAsShortRange(blip, v.closeRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)

        table.insert(CreatedBlips, blip)
    end
end

function HideBlips()
    for k, v in pairs(CreatedBlips) do
        RemoveBlip(v)
    end
    CreatedBlips = {}
end

function ShowBlips()
    CreateBlips()
end

RegisterCommand("toggleblips", function()
    if BlipsShown == true then
        HideBlips()
        BlipsShown = false
    else
        ShowBlips()
        BlipsShown = true
    end
end)