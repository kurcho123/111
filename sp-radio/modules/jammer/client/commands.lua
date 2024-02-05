if Config.AllowJammers and Config.Framework == 'none' then
    RegisterCommand(Config.PlaceJammerCommand, function(source, args, raw)
        placeJammer()
    end, false)
end
