IsDead = false

function OnRevive()
    -- * Enable phone usage.
    ToggleDisabled(false)
end

function OnDeath()
    -- * Close phone if open.
    if PhoneOpen then
        ToggleOpen(false)
    end

    -- * Leave radio channel if on one.
    if OnRadio then
        debugPrint('Player is dead, leaving radio channel')

        SendUIAction('radio:drop-channel', {})

        LeaveRadioChannel()
    end

    if PhoneData.CallData.CallId then
        debugPrint('Player is dead, hanging up phone')

        SendUIAction('kb-cancel-call')
    end

    -- * ========================== * --
    -- * ... do other stuff here ...* --
    -- * ========================== * --

    -- * Disable phone usage.
    ToggleDisabled(true)
end

AddEventHandler("CEventDeath", function(entities, entity, data)
    if entities[1] == PlayerPedId() then
        -- OnRevive() -- ! Handle revive depending on your framework.
        -- OnDeath()  -- ! Handle death depending on your framework.
    end
end)

AddEventHandler("CEventEntityDamaged", function()
    if IsPedDeadOrDying(PlayerPedId(), false) then
        -- OnRevive() -- ! Handle revive depending on your framework.
        -- OnDeath()  -- ! Handle death depending on your framework.
    end
end)

if Config.Framework == 'qb' then
    local Framework = exports['qb-core']:GetCoreObject()

    CreateThread(function()
        while true do
            Wait(Config.Death.CheckDeathTimeout)
            if LocalPlayer.state.isLoggedIn then
                Framework.Functions.GetPlayerData(function(playerData)
                    if (Config.Death.LastStand and playerData.metadata.inlaststand) or playerData.metadata.isdead then
                        OnDeath()
                        IsDead = true
                    else
                        OnRevive()
                        IsDead = false
                    end
                end)
            end
        end
    end)
elseif Config.Framework == 'esx' then
    AddEventHandler('esx:onPlayerDeath', function()
        OnDeath()
        IsDead = true
    end)
    
    RegisterNetEvent('esx_ambulancejob:revive', function()
        OnRevive()
        IsDead = false
    end)
end
