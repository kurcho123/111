Config = {}

Config.CoreName = {
    ["ESX"] = 'es_extended',
    ["QBCore"] = 'qb-core'
}

Config.CustomTextUI = false -- If you have a TextUI that you use, you can place it in the function below.

Config.CustomTextUIFunc = function(message)
    exports['okokTextUI']:Open(message, 'red', 'top') -- for example
end

Config.CustomTextUIHide = function()
    exports['okokTextUI']:Close()
end

Config.VehicleUpdateSQLESX = {'owned_vehicles', 'owner', 'stored'}
Config.VehicleUpdateSQLQBCore = {'player_vehicles', 'citizenid', 'state'}