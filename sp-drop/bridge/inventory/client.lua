if GetResourceState('qb-inventory') == 'started' then  
    RegisterNetEvent('inventory:client:UseWeapon', function(weaponData, shootbool)
        TriggerServerEvent("sp-drop:SetCurrentWeapon", weaponData)
    end)
end