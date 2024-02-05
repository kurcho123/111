Shared = Shared or {}

--- Other
Shared.Debug = false
Shared.CopJob = "police"
Shared.Dispatch = "ps-dispatch"

--- Items
Shared.PackedWeedItem = 'weedplant_packedweed'
Shared.SusPackageItem = 'weed_brick'
Shared.PackageProp = `prop_mp_drug_package`

--- Weedrun Related Settings
Shared.WeedRunStart = vector4(-1171.97, -501.55, 35.28,39.24)
Shared.DeliveryWaitTime = {8, 12} -- Time in seconds (min, max) the player has to wait to receive a new delivery location
Shared.CallCopsChance = 20 -- 20%
Shared.PayOut = {400, 700} -- Min/max payout for delivering a suspicious package
Shared.SetTimeout = {1, 10}
Shared.MaxDrop = 10
Shared.MaxPackedWeed = 20
Shared.MaxAddPacked = 10
Shared.PackageTime = 2

Shared.DropOffLocations = { -- Drop-off locations
vector4(-1187.0, -488.23, 35.78, 202.62),
vector4(-1191.89, -507.36, 35.57, 307.87),
vector4(-1179.27, -508.62, 35.57, 347.43),
vector4(-1182.87, -498.6, 35.58, 285.13),
vector4(-1173.53, -489.13, 35.57, 133.49)
    -- vector4(74.5, -762.17, 31.68, 160.98),
    -- vector4(100.58, -644.11, 44.23, 69.11),
    -- vector4(175.45, -445.95, 41.1, 92.72),
    -- vector4(130.3, -246.26, 51.45, 219.63),
    -- vector4(198.1, -162.11, 56.35, 340.09),
    -- vector4(341.0, -184.71, 58.07, 159.33),
    -- vector4(-26.96, -368.45, 39.69, 251.12),
    -- vector4(-155.88, -751.76, 33.76, 251.82),
    -- vector4(-305.02, -226.17, 36.29, 306.04),
    -- vector4(-347.19, -791.04, 33.97, 3.06),
    -- vector4(-703.75, -932.93, 19.22, 87.86),
    -- vector4(-659.35, -256.83, 36.23, 118.92),
    -- vector4(-934.18, -124.28, 37.77, 205.79),
    -- vector4(-1214.3, -317.57, 37.75, 18.39),
    -- vector4(-822.83, -636.97, 27.9, 160.23),
    -- vector4(308.04, -1386.09, 31.79, 47.23),
    -- vector4(-1041.13, -392.04, 37.81, 25.98),
    -- vector4(-731.69, -291.67, 36.95, 330.53),
    -- vector4(-835.17, -353.65, 38.68, 265.05),
    -- vector4(-1062.43, -436.19, 36.63, 121.55),
    -- vector4(-1147.18, -520.47, 32.73, 215.39),
    -- vector4(-1174.68, -863.63, 14.11, 34.24),
    -- vector4(-1688.04, -1040.9, 13.02, 232.85),
    -- vector4(-1353.48, -621.09, 28.24, 300.64),
    -- vector4(-1029.98, -814.03, 16.86, 335.74),
    -- vector4(-893.09, -723.17, 19.78, 91.08),
    -- vector4(-789.23, -565.2, 30.28, 178.86),
    -- vector4(-345.48, -1022.54, 30.53, 341.03),
    -- vector4(218.9, -916.12, 30.69, 6.56),
    -- vector4(57.66, -1072.3, 29.45, 245.38)
}

Shared.DropOffPeds = { -- Drop-off ped models
	'a_m_y_stwhi_02',
}
