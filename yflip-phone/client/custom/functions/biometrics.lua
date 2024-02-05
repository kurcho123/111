local obstructingHelmets = {
    female = {
        [16] = true,
        [17] = true,
        [18] = true,
        [19] = true,
        [37] = true,
        [46] = true,
        [47] = true,
        [48] = true,
        [49] = true,
        [50] = true,
        [51] = true,
        [52] = true,
        [59] = true,
        [62] = true,
        [66] = true,
        [67] = true,
        [68] = true,
        [69] = true,
        [70] = true,
        [71] = true,
        [72] = true,
        [73] = true,
        [77] = true,
        [78] = true,
        [79] = true,
        [80] = true,
        [81] = true,
        [90] = true,
        [91] = true,
        [110] = true,
        [114] = true,
        [115] = true,
        [116] = true,
        [117] = true,
        [118] = true,
        [122] = true,
        [123] = true,
        [124] = true,
        [126] = true,
        [127] = true,
        [128] = true,
        [132] = true,
        [133] = true,
        [143] = true,
    },
    male = {
        [16] = true,
        [17] = true,
        [18] = true,
        [19] = true,
        [38] = true,
        [47] = true,
        [48] = true,
        [49] = true,
        [50] = true,
        [51] = true,
        [52] = true,
        [53] = true,
        [57] = true,
        [62] = true,
        [67] = true,
        [68] = true,
        [69] = true,
        [70] = true,
        [71] = true,
        [72] = true,
        [73] = true,
        [74] = true,
        [78] = true,
        [79] = true,
        [80] = true,
        [81] = true,
        [82] = true,
        [91] = true,
        [92] = true,
        [111] = true,
        [115] = true,
        [116] = true,
        [117] = true,
        [118] = true,
        [119] = true,
        [123] = true,
        [124] = true,
        [125] = true,
        [126] = true,
        [127] = true,
        [128] = true,
        [129] = true,
        [133] = true,
        [134] = true,
        [144] = true,
    }
}

---Check if the player is wearing a helmet or mask that would obstruct the face id
---@return boolean
function IsFaceObstructed()
    if GetPedDrawableVariation(PlayerPedId(), 1) > 0 then
        return true
    end

    local gender = GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` and "male" or "female"
    return obstructingHelmets[gender][GetPedPropIndex(PlayerPedId(), 0)] == true
end

RegisterNuiCallback('biometrics:is-fingerprint-obstructed', function(_, cb)
    cb({ hasGloves = IsFingerprintObstructed() })
end)

function IsFingerprintObstructed()
    if not Config.Biometrics.CheckForGloves then
        return false
    end

    if GetPedDrawableVariation(PlayerPedId(), 5) > 0 then
        return true
    end
end

RegisterNuiCallback('biometrics:setup-fingerprint', function(_, cb)
    local success = lib.callback.await('yflip-phone:server:biometrics:setup-fingerprint')

    if success then
        PhoneData.Settings.fingerprint = true
        PhoneData.Settings.citizenId = Device.currentOwnerCitizenId

        cb({ success = true, citizenId = Device.currentOwnerCitizenId })
        return
    else
        cb({ success = false })
    end
end)

RegisterNuiCallback('biometrics:remove-fingerprint', function(_, cb)
    local success = lib.callback.await('yflip-phone:server:biometrics:remove-fingerprint')

    if success then
        PhoneData.Settings.fingerprint = false
        PhoneData.Settings.citizenId = nil

        cb({ success = true })
        return
    else
        cb({ success = false })
    end
end)
