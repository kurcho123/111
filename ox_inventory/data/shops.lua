return {
	General = {
		name = 'Магазин',
		inventory = {
			{ name = 'sandwich', price = 10, count = 100 },
			{ name = 'water', price = 5, count = 100 },
			{ name = 'cola', price = 7, count = 100 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
			vec3(344.26, -1431.25, 33.44 - 2)
		}, targets = {
			{ loc = vec3(25.7, -1347.3, 29.49), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
			{ loc = vec3(-3038.71, 585.9, 7.9), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 1.5 },
			{ loc = vec3(-3241.47, 1001.14, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 1.5 },
			{ loc = vec3(1728.66, 6414.16, 35.03), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 1.5 },
			{ loc = vec3(1697.99, 4924.4, 42.06), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
			{ loc = vec3(1961.48, 3739.96, 32.34), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 1.5 },
			{ loc = vec3(547.79, 2671.79, 42.15), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 1.5 },
			{ loc = vec3(2679.25, 3280.12, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 1.5 },
			{ loc = vec3(2557.94, 382.05, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 1.5 },
			{ loc = vec3(373.55, 325.56, 103.56), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
			{ loc = vec3(343.94, -1431.40, 33.37 -1), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
		}
	},

	Liquor = {
		name = 'Liquor Store',
		inventory = {
			{ name = 'sandwich', price = 10, count = 100 },
			{ name = 'water', price = 5, count = 100 },
			{ name = 'cola', price = 7, count = 100 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 }
		}
	},

	Ammunation = {
		name = 'Ammunation',
		inventory = {
			{ name = 'ammo-9', price = 15, },
			{ name = 'WEAPON_KNIFE', price = 500 },
			{ name = 'WEAPON_BAT', price = 100 }
			-- { name = 'WEAPON_PISTOL', price = 15000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-659.82, -939.64, 22.97),
			vec3(813.64, -2154.40, 30.73),
			vec3(1697.36, 3756.95, 35.84),
			vec3(-330.24, 6083.88, 31.45),
			vec3(247.48, -50.74, 71.08),
			vec3(17.63, -1108.52, 30.91),
			vec3(2565.57, 298.67, 109.87),
			vec3(-1113.15, 2697.07, 19.69),
			vec3(842.04, -1028.65, 29.33)
		}, targets = {
			{ loc = vec3(-659.82, -939.64, 22.97 -1), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(813.64, -2154.40, 30.73 -1), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1697.36, 3756.95, 35.84 -1), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.24, 6083.88, 31.45 -1), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(247.48, -50.74, 71.08 -1), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(17.63, -1108.52, 30.91 -1), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2565.57, 298.67, 109.87 -1), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1113.15, 2697.07, 19.69 -1), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(842.04, -1028.65, 29.33 -1), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	},

	PoliceArmoury = {
		name = 'Оръжейна',
		groups = shared.police,
		inventory = {
			{ name = 'ammo-9', price = 0, },
			{ name = 'ammo-rifle', price = 0, },
			{ name = 'ifak', price = 0, },
			{ name = 'police_armor', price = 0 },
			{ name = 'police_heavyarmor', price = 0 },
			{ name = 'empty_evidence_bag', price = 0 },
			{ name = 'nikon', price = 0 },
			{ name = 'sdcard', price = 0 },
			{ name = 'gsrtestkit', price = 0 },
			{ name = 'dnatestkit', price = 0 },
			{ name = 'drugtestkit', price = 0 },
			{ name = 'breathalyzer', price = 0 },
			{ name = 'accesstool', price = 0 },
			{ name = 'fingerprintreader', price = 0 },
			{ name = 'fingerprintkit', price = 0 },
			{ name = 'mikrosil', price = 0 },
			{ name = 'fingerprinttape', price = 0 },
			{ name = 'blox', price = 0 },
			{ name = 'microfibercloth', price = 0 },
			{ name = 'handcuffs', price = 0 },
			{ name = 'handcuffs_keys', price = 0 },
			{ name = 'radio', price = 0 },
			{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			{ name = 'WEAPON_NIGHTSTICK', price = 0 },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'WEAPON_COMBATPISTOL', price = 0, metadata = { registered = true, serial = 'POL' }, license = "police_pistol", grade = 1 },
			{ name = 'WEAPON_PISTOL_MK2', price = 0, metadata = { registered = true, serial = 'POL' }, license = "police_pistol", grade = 1 },
			{ name = 'WEAPON_COMBATPDW', price = 1000, metadata = { registered = true, serial = 'POL' }, license = "police_auto", grade = 5 },
			{ name = 'WEAPON_HEAVYRIFLE', price = 1000, metadata = { registered = true, serial = 'POL' }, license = "police_auto", grade = 5 },
			{ name = 'WEAPON_TACTICALRIFLE', price = 1000, metadata = { registered = true, serial = 'POL' }, license = "police_auto", grade = 5 },
		}, locations = {
			vec3(461.63, -1002.90, 31.59 - 1)
		}, targets = {
			{ loc = vec3(461.63, -1002.90, 31.59 - 1), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }
		}
	},

	PoliceHrana = {
		name = 'Данчо Хранителов',
		inventory = {
			{ name = 'sandwich', price = 5 },
			{ name = 'water', price = 3 },
			{ name = 'cola', price = 5 },
		}, locations = {
			vec3(446.12, -995.70, 30.69 - 1), 
		}, targets = {
			{
                ped = `mp_m_shopkeep_01`,
                scenario = 'WORLD_HUMAN_AA_COFFEE',
                loc = vec3(446.12, -995.70, 30.69 - 1),
                heading = 87.61,
            },
		}
	},

	DigitalDen = {
		name = 'Digital Den',
		inventory = {
			{ name = 'phone', price = 500 },
			{ name = 'laptop', price = 1000 },
			{ name = 'radio', price = 100 },
			{ name = 'screwdriver', price = 30 },
			{ name = 'lockpick', price = 200 },
		}, locations = {
			vec3(392.74, -831.77, 29.29 - 1)
		}, targets = {
			-- { loc = vec3(392.74, -831.77, 29.29 - 1), length = 0.5, width = 3.0, heading = 228.04, minZ = 29.29 - 2, maxZ = 29.29 + 1, distance = 2 },
			{
                ped = `mp_m_shopkeep_01`,
                scenario = 'WORLD_HUMAN_AA_COFFEE',
                loc = vec3(392.74, -831.77, 29.29 - 1),
                heading = 228.04,
            },
		}
	},

	Upnatom = {
		name = 'Up-n-Atom Магазин',
		inventory = {
			{ name = 'upnatom-lettuce-uncut', price = 1 },
			{ name = 'upnatom-tomato-uncut', price = 1 },
			{ name = 'upnatom-onion-uncut', price = 1 },
			{ name = 'upnatom-bacon-uncut', price = 1 },
			{ name = 'upnatom-pickles-uncut', price = 1 },
			{ name = 'upnatom-ketchup', price = 1 },
			{ name = 'upnatom-mayonaise', price = 1 },
			{ name = 'upnatom-mustard', price = 1 },
			{ name = 'upnatom-ice', price = 1 },
			{ name = 'upnatom-cup', price = 1 },
			{ name = 'upnatom-meat-unfried', price = 1 },
			{ name = 'upnatom-potato-uncut', price = 1 },
		}, locations = {
			vec3(29.35, -1770.43, 29.61 - 1)
		}, targets = {
			-- { loc = vec3(392.74, -831.77, 29.29 - 1), length = 0.5, width = 3.0, heading = 228.04, minZ = 29.29 - 2, maxZ = 29.29 + 1, distance = 2 },
			{
                ped = `mp_m_shopkeep_01`,
                scenario = 'WORLD_HUMAN_AA_COFFEE',
                loc = vec3(29.35, -1770.43, 29.61 - 1),
                heading = 46.41,
            },
		}
	},

	Ambulance = {
		name = 'Медицински Магазин',
		groups = "ambulance",
		inventory = {
			{ name = 'bandageg', price = 10 },
			{ name = 'painkillers', price = 10 },
			{ name = 'gauze', price = 10 },
			{ name = 'tape', price = 10 },
			{ name = 'surgical_tray', price = 10 },
			{ name = 'iodine', price = 10 },
			{ name = 'syringe', price = 10 },
			{ name = 'forceps', price = 10 },
			{ name = 'pill', price = 10 },
			{ name = 'surgical_gloves', price = 10 },
			{ name = 'surgical_staple', price = 10 },
		}, locations = {
			vec3(354.35, -1386.69, 32.94 - 1)
		}, targets = {
			-- { loc = vec3(392.74, -831.77, 29.29 - 1), length = 0.5, width = 3.0, heading = 228.04, minZ = 29.29 - 2, maxZ = 29.29 + 1, distance = 2 },
			{
                ped = `mp_m_shopkeep_01`,
                scenario = 'WORLD_HUMAN_AA_COFFEE',
                loc = vec3(354.35, -1386.69, 32.94 - 1),
                heading = 317.39,
            },
		}
	},
}
