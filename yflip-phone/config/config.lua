Config = Config or {}

Config.DebugPrint = false -- Print debug messages to console

Config.Framework = 'qb'   -- esx -- standalone
--[[
    Supported frameworks:
        * esx: es_extended, https://github.com/esx-framework/esx-legacy
        * qb: qb-core, https://github.com/qbcore-framework/qb-core
        * standalone: no framework, note that framework specific apps will not work unless you implement the functions in `standalone.lua`
        -- * ox: ox_core, https://github.com/overextended/ox_core - On demand.
]]

Config.Item = {}
Config.Item.Require = true -- If true, an item will be required to use the phone.

Config.Item.Unique = true
Config.Item.Name = 'phone' -- Name of the item that is required to use the phone.
Config.Item.Inventory = 'ox_inventory'
--[[
    The inventory you use, IGNORE IF YOU HAVE Config.Item.Unique DISABLED.
    Supported:
        * ox_inventory - https://github.com/overextended/ox_inventory
        * qb-inventory - https://github.com/qbcore-framework/qb-inventory
        * lj-inventory - https://github.com/loljoshie/lj-inventory
        * ps-inventory - https://github.com/Project-Sloth/ps-inventory
        * codem-inventory - https://codem.tebex.io/package/5900973
        ]]

-- ============================= --
--- RECOMENDED TO LEAVE AS TRUE ---
-- ============================= --
Config.CheckForUpdates = true
