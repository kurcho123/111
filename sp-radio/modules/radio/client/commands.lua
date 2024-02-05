if Config.OpenRadioCommand then
    RegisterCommand(Config.OpenRadioCommand, function()
        toggleRadio()
    end, false)
end

if Config.QuickJoinCommand then
    RegisterCommand(Config.QuickJoinCommand, function(source, args, raw)
        if args[1] then
            local channel = tonumber(args[1])

            if channel then
                connectRadio(channel)
            end
        end
    end, false)
end

if Config.QuickListCommand then
    RegisterCommand(Config.QuickListCommand, function()
        toggleRadioList()
    end, false)
end
