local phoneProp = 0

local function LoadAnimation(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(1)
    end
end

local function CheckAnimLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib ~= nil and PhoneData.AnimationData.anim ~= nil do
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                LoadAnimation(PhoneData.AnimationData.lib)
                TaskPlayAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false,
                    false, false)
            end
            Wait(500)
        end
    end)
end

local function newPhoneProp()
    local player = PlayerPedId()
    local bone = GetPedBoneIndex(player, 28422)
    DeletePhone()

    local hash = Config.PhoneModel

    phoneProp = CreateObject(hash, 1.0, 1.0, 1.0, 1, 1, 0)
    DoPhoneAnimation("cellphone_text_in")
    AttachEntityToEntity(phoneProp, player, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

-- Prop sync
RegisterNetEvent('yflip-phone:client:animation-sync', newPhoneProp)

function DeletePhone()
    if phoneProp ~= 0 then
        DeleteObject(phoneProp)
        phoneProp = 0
    end
end

function DoPhoneAnimation(anim)
    local ped = PlayerPedId()
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim

    if IsPedInAnyVehicle(ped, false) then
        AnimationLib = 'anim@cellphone@in_car@ps'
    end
    LoadAnimation(AnimationLib)
    TaskPlayAnim(ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)
    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus
    CheckAnimLoop()
end
