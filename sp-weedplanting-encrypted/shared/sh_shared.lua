Shared = Shared or {}

--- Other
Shared.Debug = false
Shared.CopJob = "police"
Shared.Dispatch = "ps-dispatch"

--- Items
Shared.MaleSeed = 'maleseed'
Shared.FemaleSeed = 'femaleseed'
Shared.PlantTubItem = 'plant_tub'
Shared.EmptyCanItem = 'empty_watering_can'
Shared.FullCanItem = 'full_watering_can'
Shared.FertilizerItem = 'weed_nutrition'
Shared.DrugShears = 'drug_shears'
Shared.BranchItem = 'weed'
Shared.WeedItem = 'weedcbdcrop'
Shared.WeedItemcbd = 'ak47bag'
Shared.WeedemptyBag = 'empty_weed_bag'
Shared.Weedgrinder = 'weedgrinder'
Shared.groundweed = 'ground-weed'
Shared.Weedocb = '420-bar'
Shared.Weedjoint = 'joint'
Shared.PackedWeedItem = 'weedplant_packedweed'
Shared.LabkeyItem = 'weedkey' -- Key required to enter the weed lab

--- Weed Processing | Weed-Lab
Shared.WeedLab = {
    EnableTp = true, -- Set this to false if you do not want to use this teleportation system. 
    RequireKey = true,  -- Set this to false to disable the requirement of a lab key to enter the weed lab (set to true if you want to use the key)
    EnableSound = true, --  Set this to false if you dont want the interact sound while exiting / entering the wee lab.
}

--- Props
Shared.WeedProps = {
    [1] = `bkr_prop_weed_01_small_01b`,
    [2] = `bkr_prop_weed_med_01a`,
    [3] = `bkr_prop_weed_med_01b`,
    [4] = `bkr_prop_weed_lrg_01a`,
    [5] = `bkr_prop_weed_lrg_01b`
}

Shared.ProcessingProps = {
    {model = "bkr_prop_weed_table_01a",    coords = vector4(1045.41, -3197.64, -38.13, 270),},
    {model = "hei_prop_heist_weed_pallet", coords = vector4(1044.89, -3192.6, -37.91, 196.56),},
    {model = "hei_prop_heist_weed_pallet", coords = vector4(1043.07, -3192.55, -37.91, 183.94),},
    {model = "hei_prop_heist_weed_pallet", coords = vector4(1041.27, -3192.61, -37.91, 183.98),},
    {model = "prop_watercrate_01", coords = vector4(1042.64, -3206.14, -37.85, 200.34),},
    {model = "prop_rub_cabinet03", coords = vector4(1038.81, -3198.91, -38.17, 92.51),},
    
}

Shared.PackageProp = `prop_mp_drug_package`

--- Growing Related Settings
Shared.rayCastingDistance = 7.0 -- distance in meters
Shared.ClearOnStartup = true -- Clear dead plants on script start-up
Shared.ObjectZOffset = -0.0 -- Z-coord offset for WeedProps
Shared.FireTime = 10000
Shared.GiveWeed = math.random(1, 5)

Shared.GrowTime = 180 -- Time in minutes for a plant to grow from 0 to 100
Shared.LoopUpdate = 15 -- Time in minutes to perform a loop update for water, nutrition, health, growth, etc.
Shared.WaterDecay = 0.4 -- Percent of water that decays every minute
Shared.FertilizerDecay = 0.4 -- Percent of fertilizers that decays every minute

Shared.FertilizerThreshold = 40
Shared.WaterThreshold = 40
Shared.HealthBaseDecay = {7, 10} 
Shared.PackageAmount = 20

Shared.Inv = "ox"
Shared.Items = {
    label = "Магазина на Питър",  slots = 20,
    items = {
        { name = "femaleseed", price = 40, info = {}, type = "item", slot = 1, },
        { name = "plant_tub", price = 50, info = {}, type = "item", slot = 2, },
        { name = "empty_watering_can",	price = 50, info = {}, type = "item", slot = 3, },
        { name = "weed_nutrition",	price = 50, info = {}, type = "item", slot = 4, },
        { name = "drug_shears",	price = 500, info = {}, type = "item", slot = 5, },
        { name = "empty_weed_bag",	price = 50, info = {}, type = "item", slot = 6, },
        { name = "weedgrinder",	price = 500, info = {}, type = "item", slot = 7, },
        { name = "420-bar",	price = 500, info = {}, type = "item", slot = 8, },
    },
}
