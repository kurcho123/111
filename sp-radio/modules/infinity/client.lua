function infinity.getPlayerCoords(netId)
    local index = GetPlayerFromServerId(netId)

    if index ~= -1 then
        return GetEntityCoords(GetPlayerPed(index))
    end

    local coords = callback.await('fd_radio:infinity:coords', false, netId)

    return coords
end
