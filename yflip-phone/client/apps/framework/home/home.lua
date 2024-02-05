-- -- ? An example of a home object expected in the UI.
-- -- ? If your object differs from this, the UI will not work.
-- {
--     id: 1,
--     citizenid: 'OIE09582',
--     coords: { x: -547.96, y: 1347.91 }, -- Object with x, z
--     house: 'nikola pl1',
--     identifier: 'license:e2310d7d81f0465cc797c2c95bee2cd208958b80',
--     keyholders: ['OIE09582'], -- An array of citizenids
--     label: 'Nikola Pl 1',
--     name: 'nikola pl1',
--     owned: true,
--     price: 1000,
--     tier: 2,
-- },
RegisterNUICallback('home:get', function(_, cb)
    local properties = lib.callback.await('yflip-phone:server:home:get', false)
    properties = MapHomes(properties)

    cb(properties)
end)

-- { -- ? An example for expected data.
-- ['OIE09582', 'PI2AS582']
RegisterNUICallback('home:get-key-holders-details', function(keyHolders, cb)
    local keyHoldersResult = lib.callback.await('yflip-phone:server:home:get-key-holders-details', false, keyHolders)

    keyHoldersResult = MapKeyHolders(keyHoldersResult)

    cb(keyHoldersResult)
end)

RegisterNUICallback('home:remove-key-holder', function(data, cb)
    local keyHoldersResult = lib.callback.await('yflip-phone:server:home:remove-key-holder', false, data)

    cb(keyHoldersResult)
end)

-- { -- ? An example for expected data.
--     targetSource = 7,
--     houseId = 'houseName',
--     currentKeyholders = ['citizenId', 'citizenId'],
-- }
RegisterNUICallback('home:add-key-holder', function(data, cb)
    local addedKeyholder = lib.callback.await('yflip-phone:server:home:add-key-holder', false, data)

    cb(addedKeyholder)
end)
