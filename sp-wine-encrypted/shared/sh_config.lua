Config = {
    Items = {'wine_fullbucket'},
    BucketModel = 'prop_bucket_02a',
    PluckReset = 60, --Minutes
    PluckTime = 23, --seconds
    FillTime = 3,
    SqueezeTime = 7,
    MekingTime = 50000,
    BerryItem = 'berry',
    GrabAmount = math.random(3,5),
    Invincible = true,
    Frozen = true,
    Stoic = true,
    Fade = true,
    Distance = 10.0,
    MinusOne = true,
    Inv = "ox",
    AmountSell = {
        zinfandel = math.random(800,820),
        malbec = math.random(800,820),
        tempranillo = math.random(800,820),
        sangiovese = math.random(800,820),
        nebbiolo = math.random(800,820),
    }
}

-- Между 120 и 140 


Config.ZonesName = "sp-wine-encrypted"

Config.Items = {
    label = "WineShops",  slots = 5,
    items = {
        { name = "wine_barrel", price = 40, amount = 10, info = {}, type = "item", slot = 1, },
        { name = "wine_emptybucket", price = 40, amount = 50, info = {}, type = "item", slot = 2, },
        { name = "wine_yeast", price = 25, amount = 50, info = {}, type = "item", slot = 3, },
        { name = "farm_regador_cheio", price = 40, amount = 50, info = {}, type = "item", slot = 4, },
        { name = "wine_emptybottle", price = 20, amount = 50, info = {}, type = "item", slot = 5, },
    },
}

Config.BucketItem = {
    empty = 'wine_emptybucket',
    full = 'wine_fullbucket',
}

Config.CallbackItems = {
    FullBucket = 'wine_fullbucket',
    cheio = 'farm_regador_cheio',
    yeast = 'wine_yeast',
    Ammount1 = 1,
    Ammount2 = 5,
    zin = 'zinfandel',
    malbec = 'malbec',
    tempra = 'tempranillo',
    sang = 'sangiovese',
    nebbi = 'nebbiolo',
}

Config.NeededItems = {
    Stage1 = {[1] = {item = 'berry',amount = 10,},},
    Stage2 = {[1] = {item = 'wine_fullbottle',amount = 3,},},
}

WineConfig = {
    WineObjects = {
        {hash = 'sp_props_barrel_001', zOffset = -1.0},
        {hash = 'sp_props_barrel_001', zOffset = -1.0},
        {hash = 'sp_props_barrel_002', zOffset = -1.0},
    },
    WineObjectsName = 'sp_props_barrel_001',
    WineObjectsName03 = 'sp_props_barrel_002',
    GrowthTime = 30,
    LifeTime = 360,
    QueenAdd = {1.3, 0.2},
    QueenFactor = 1.3,
    HarvestPercent = 100.0,
    TimeBetweenHarvest = 80,
    UpdateTimer = 1 * 2 * 10,
    NotificationDurations = 5000,
    NotificationDurationsServer = 5000,
    InstallProgressbar = 25000,
    addBerrybeeProgressbar = 25000,
    RemovingProgressbar =  25000,
    HarvestingProgressbar = 50000,
    IconsArchive = 'fas fa-archive',
    IconHoldingWater = 'fas fa-hand-holding-water',
}

MaterialHashes = {
  ["-461750719"] = true,
  ["930824497"] = true,
  ["-700658213"] = true,
  ["581794674"] = true,
  ["-2041329971"] = true,
  ["-309121453"] = true,
  ["-913351839"] = true,
  ["-1885547121"] = true,
  ["-1915425863"] = true,
  ["-1833527165"] = true,
  ["2128369009"] = true,
  ["-124769592"] = true,
  ["-840216541"] = true,
  ["-2073312001"] = true,
  ["627123000"] = true,
  ["1333033863"] = true,
  ["-1942898710"] = true,
  ["-1595148316"] = true,
  ["435688960"] = true,
  ["223086562"] = true,
  ["1109728704"] = true,
  ["-1286696947"] = true,
}

HiveZones = {
    {vector3(-1870.33, 2093.99, 139.58), 350.5},
}

Config.PluckZones = {
    [1] = {isbussy = false,loc = vector3(-1875.39, 2099.34, 139.12),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [2] = {isbussy = false,loc = vector3(-1879.6, 2099.3, 139.12),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [3] = {isbussy = false,loc = vector3(-1884.52, 2099.63, 139.12),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [4] = {isbussy = false,loc = vector3(-1891.34, 2100.49, 138.26),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [5] = {isbussy = false,loc = vector3(-1901.35, 2101.38, 135.97),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [6] = {isbussy = false,loc = vector3(-1909.91, 2102.36, 132.85),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [7] = {isbussy = false,loc = vector3(-1873.73, 2103.72, 137.63),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [8] = {isbussy = false,loc = vector3(-1881.94, 2104.26, 137.8),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [9] = {isbussy = false,loc = vector3(-1889.85, 2105.07, 136.51),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [10] = {isbussy = false,loc = vector3(-1896.67, 2105.56, 135.52),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [11] = {isbussy = false,loc = vector3(-1903.37, 2106.01, 133.24),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [12] = {isbussy = false,loc = vector3(-1909.69, 2106.78, 131.25),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [13] = {isbussy = false,loc = vector3(-1860.02, 2098.31, 138.03),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [14] = {isbussy = false,loc = vector3(-1851.57, 2102.05, 137.71),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [15] = {isbussy = false,loc = vector3(-1845.5, 2104.99, 137.6),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [16] = {isbussy = false,loc = vector3(-1834.41, 2110.18, 136.31),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [17] = {isbussy = false,loc = vector3(-1826.99, 2113.77, 134.46),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [18] = {isbussy = false,loc = vector3(-1820.87, 2116.58, 133.2),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [19] = {isbussy = false,loc = vector3(-1811.95, 2120.51, 131.43),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [20] = {isbussy = false,loc = vector3(-1853.15, 2106.55, 135.57),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [21] = {isbussy = false,loc = vector3(-1843.67, 2110.99, 134.68),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [22] = {isbussy = false,loc = vector3(-1836.09, 2114.26, 133.64),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [23] = {isbussy = false,loc = vector3(-1828.48, 2117.94, 132.19),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [24] = {isbussy = false,loc = vector3(-1820.11, 2121.84, 130.47),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [25] = {isbussy = false,loc = vector3(-1811.95, 2125.63, 129.04),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [26] = {isbussy = false,loc = vector3(-1802.04, 2130.38, 127.45),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [27] = {isbussy = false,loc = vector3(-1792.51, 2134.77, 126.87),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [28] = {isbussy = false,loc = vector3(-1850.22, 2089.91, 139.34),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [29] = {isbussy = false,loc = vector3(-1843.2, 2094.21, 138.74),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [30] = {isbussy = false,loc = vector3(-1833.54, 2099.47, 137.66),box = {h = 0,min = 1,max = 1,w = 1,d = 3,}},
    [31] = {isbussy = false,loc = vector3(-1800.87, 2121.91, 131.83),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [32] = {isbussy = false,loc = vector3(-1781.81, 2125.26, 130.09),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [33] = {isbussy = false,loc = vector3(-1807.48, 2105.61, 134.50),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [34] = {isbussy = false,loc = vector3(-1793.53, 2111.69, 132.26),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [35] = {isbussy = false,loc = vector3(-1818.02, 2097.41, 135.85),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [36] = {isbussy = false,loc = vector3(-1830.31, 2089.95, 136.90),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [37] = {isbussy = false,loc = vector3(-1844.56, 2081.70, 138.85),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [38] = {isbussy = false,loc = vector3(-1838.97, 2123.87, 128.34),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [39] = {isbussy = false,loc = vector3(-1831.08, 2127.50, 127.20),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [40] = {isbussy = false,loc = vector3(-1821.88, 2131.93, 125.43),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [41] = {isbussy = false,loc = vector3(-1813.61, 2135.91, 124.07),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [42] = {isbussy = false,loc = vector3(-1806.21, 2139.43, 123.01),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [43] = {isbussy = false,loc = vector3(-1795.00, 2144.69, 121.79),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [44] = {isbussy = false,loc = vector3(-1788.59, 2147.71, 121.00),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [45] = {isbussy = false,loc = vector3(-1811.47, 2146.84, 119.08),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [46] = {isbussy = false,loc = vector3(-1819.62, 2143.08, 120.10),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [47] = {isbussy = false,loc = vector3(-1826.91, 2139.79, 121.16),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [48] = {isbussy = false,loc = vector3(-1833.02, 2136.80, 122.45),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [49] = {isbussy = false,loc = vector3(-1830.93, 2142.68, 119.46),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [50] = {isbussy = false,loc = vector3(-1821.99, 2147.01, 117.92),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [51] = {isbussy = false,loc = vector3(-1866.12, 2112.65, 134.40),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [52] = {isbussy = false,loc = vector3(-1875.54, 2113.57, 134.87),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [53] = {isbussy = false,loc = vector3(-1885.64, 2114.47, 133.79),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [54] = {isbussy = false,loc = vector3(-1894.06, 2115.09, 132.15),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [55] = {isbussy = false,loc = vector3(-1901.45, 2115.70, 130.13),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [56] = {isbussy = false,loc = vector3(-1909.75, 2116.48, 126.70),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [57] = {isbussy = false,loc = vector3(-1907.82, 2125.36, 124.00),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [58] = {isbussy = false,loc = vector3(-1901.34, 2124.74, 126.68),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [59] = {isbussy = false,loc = vector3(-1894.71, 2124.05, 128.59),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [60] = {isbussy = false,loc = vector3(-1888.94, 2123.59, 129.93),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [61] = {isbussy = false,loc = vector3(-1877.95, 2123.12, 131.31),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [62] = {isbussy = false,loc = vector3(-1868.75, 2121.91, 131.49),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [63] = {isbussy = false,loc = vector3(-1860.49, 2121.27, 131.08),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [64] = {isbussy = false,loc = vector3(-1978.60, 1941.76, 171.11),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [65] = {isbussy = false,loc = vector3(-1970.30, 1936.71, 171.44),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [66] = {isbussy = false,loc = vector3(-1962.24, 1932.06, 171.58),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [67] = {isbussy = false,loc = vector3(-1949.61, 1924.97, 172.13),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [68] = {isbussy = false,loc = vector3(-1937.90, 1918.18, 172.22),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [69] = {isbussy = false,loc = vector3(-1933.28, 1905.32, 175.43),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [70] = {isbussy = false,loc = vector3(-1925.22, 1900.55, 174.70),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [71] = {isbussy = false,loc = vector3(-1926.91, 1906.64, 173.33),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [71] = {isbussy = false,loc = vector3(-1929.07, 1913.02, 171.95),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [73] = {isbussy = false,loc = vector3(-1922.23, 1908.89, 171.33),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [74] = {isbussy = false,loc = vector3(-1915.33, 1905.15, 170.31),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [75] = {isbussy = false,loc = vector3(-1906.24, 1910.47, 167.40),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [76] = {isbussy = false,loc = vector3(-1912.57, 1913.97, 167.82),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [77] = {isbussy = false,loc = vector3(-1936.07, 1927.51, 168.48),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [78] = {isbussy = false,loc = vector3(-1946.83, 1933.95, 167.57),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [79] = {isbussy = false,loc = vector3(-1952.13, 1936.85, 167.18),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [80] = {isbussy = false,loc = vector3(-1960.14, 1941.29, 166.67),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [81] = {isbussy = false,loc = vector3(-1967.21, 1945.44, 166.17),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [82] = {isbussy = false,loc = vector3(-1972.02, 1948.28, 165.73),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [83] = {isbussy = false,loc = vector3(-1977.51, 1951.43, 165.17),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [84] = {isbussy = false,loc = vector3(-1975.66, 1957.35, 161.63),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [85] = {isbussy = false,loc = vector3(-1970.00, 1954.17, 162.39),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [86] = {isbussy = false,loc = vector3(-1958.20, 1947.36, 163.32),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [87] = {isbussy = false,loc = vector3(-1933.23, 1932.75, 166.05),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [88] = {isbussy = false,loc = vector3(-1922.90, 1926.86, 165.87),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [89] = {isbussy = false,loc = vector3(-1914.02, 1921.61, 165.67),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
    [90] = {isbussy = false,loc = vector3(-1900.59, 1914.35, 164.97),box = {h = 0,min = 0.5,max = 0.5,w = 0.5,d = 2,}},
}






































