local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()

function Notify(msg)
    QBCore.Functions.Notify(msg)
    -- You can trigger your notify
end

function ProgressBar(msg) -- General progressbar
    QBCore.Functions.Progressbar("ProgressBar", msg, Config.Utility.WaitTime, false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false,
            disableCombat = false, }, {}, {}, {}, function() end)
end
