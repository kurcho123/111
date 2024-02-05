if Config.UseRadioKey then
    RegisterKeyMapping(Config.OpenRadioCommand, Locale.open_radio, 'keyboard', Config.UseRadioKey)
end

if Config.QuickListKeyBind then
    RegisterKeyMapping(Config.QuickListCommand, Locale.open_radio_list, 'keyboard', Config.QuickListKeyBind)
end
