--[[
    Here you have the weather tyme configuration, you can modify it or even
    create your own! In case your inventory is not here, you can ask the
    creator to create a file following this example and add it!
]]

if Config.Weather ~= 'vSync' then
    return
end

RegisterNetEvent('advancedgarages:GetWeatherSync')
AddEventHandler('advancedgarages:GetWeatherSync', function(bool, time)
    if bool then
        Wait(150)
        TriggerEvent('vSync:updateWeather', 'EXTRASUNNY', false)
        NetworkOverrideClockTime(time, 0, 0)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist('CLEAR')
        SetWeatherTypeNow('CLEAR')
        SetWeatherTypeNowPersist('CLEAR')
    else
        Wait(150)
        TriggerEvent('vSync:toggle', true)
        TriggerServerEvent('vSync:requestSync')
        Debug('Time was resynchronized to the original')
    end
end)
