Citizen.CreateThread(function()
    while true do
        cache.ped = PlayerPedId()
        cache.player = PlayerId()
        cache.coords = GetEntityCoords(cache.ped)

        Wait(100)
    end
end)
