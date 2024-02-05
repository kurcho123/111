Coke = {}

Coke.PeopleRequired = 1
Coke.CopsRequired = 4

Coke.Reputation = {
    ["Level-1"] = 0,
    ["Level-2"] = 500,
    ["Level-3"] = 1000,
    ["Level-4"] = 1500,
    ["Level-5"] = 2000
}

Coke.PackageInfo = {
    name = `v_ind_cf_chckbox2`,
    placement = {
        x = 0.01,
        y =-0.02,
        z =-0.12,
        xrot = 0.0,
        yrot = 0.0,
        zrot = 0.0,
    }
}

Coke.Locations = {
    ["Level-1"] = {
        CokeRewardMin = 1,
        CokeRewardMax = 15,
        Public = false,
        ReputationGives = 40, -- Groupwise split
        Locations = {
            [1] = {
                -- Instructions are only for the Intructor; Mixing Coca Leaves is only for the Mixer; Mixing the chemical elements is only for the Chemist; Supplier is the other guy in the group that does nothing :D (protects from intruders)
                Roles = { -- Dont touch
                    ["Instructor"] = 0, 
                    ["Mixer"] = 0,
                    ["Chemist"] = 0,
                    ["Supplier"] = 0, 
                },

                -- TentLocation = nil | to be done

                CocaineSupplies = 20,
                CocaineSuppliesAmount = 0,
                CocaineSuppliesLocation = vector3(-94.98, -2466.55, 6.02),

                MixingCocaLeaves = 5, -- Cocaine Supplies will be split by this number and it will give that amount after successfull mixing (must be dividable)
                MixingCocaLeavesAmount = 0, -- Dont touch
                CocaLeavesAmount = 0, -- Dont touch
                CocaLeavesNumber = 0, -- Dont touch
                CocaLeavesNumberAlreadySeen = false, -- Dont touch
                MixingCocaLeavesLocation = vector3(-106.74, -2428.42, 6.00),

                MixturesReady = 0, -- Dont touch
                IngredientsLocation = vector3(-111.03, -2428.91, 6.00),
                Ingredients = {  -- Dont touch
                    ["Coca Extract"] = 0,
                    ["Methanol"] = 0,
                    ["Sulfuric Acid"] = 0,
                    ["Acetone"] = 0,
                },
                IngredientsAlreadySeen = false, -- Dont touch
                MixingChemicalsLocation = vector3(-111.02, -2426.48, 6.00),
            }
        }
    }
}