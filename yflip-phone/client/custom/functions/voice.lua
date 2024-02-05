local pma = exports["pma-voice"]
local mumble = exports["mumble-voip"]
local toko = exports["tokovoip_script"]

function AddPlayerToCall(callId)
    debugPrint("Add player to call with call id: ", callId)

    if Config.Voice == "pma" then
        pma:addPlayerToCall(callId)
    elseif Config.Voice == "mumble" then
        mumble:addPlayerToCall(callId)
    elseif Config.Voice == "salty" then
        TriggerServerEvent("voice:add-to-call", callId)
    elseif Config.Voice == "toko" then
        toko:addPlayerToRadio(callId)
    end
end

function RemovePlayerFromCall(callId)
    debugPrint("Remove player from call with call id: ", callId)

    if Config.Voice == "pma" then
        pma:removePlayerFromCall()
    elseif Config.Voice == "mumble" then
        mumble:removePlayerFromCall()
    elseif Config.Voice == "salty" then
        TriggerServerEvent("voice:remove-from-call", callId)
    elseif Config.Voice == "toko" then
        toko:removePlayerFromRadio(callId)
    end
end

function ToggleSpeaker(enabled)
    if Config.Voice == "salty" then
        TriggerServerEvent("voice:toggle-speaker", enabled)
    end
end