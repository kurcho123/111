local QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()
local ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()
local ox_inventory = GetResourceState('ox_inventory') == 'started' and exports.ox_inventory
nikon = false -- non local variable, used by evidence script

-------------------------------------------------------------------------------------------
--------------------------            LOCAL VARIABLES            --------------------------
-------------------------------------------------------------------------------------------

local ped, vehicle, inCamAnim, inveh = nil, nil, nil, nil
local camProp = joaat('prop_pap_camera_01')
local nikon_cam = nil
local nikon_fov_max = 70.0
local nikon_fov_min = 1.0 -- max zoom level (smaller fov is more zoom)
local nikon_zoomspeed = 5.0 -- camera zoom speed
local nikon_speed_lr = 8.0 -- speed by which the camera pans left-right
local nikon_speed_ud = 8.0 -- speed by which the camera pans up-down
local nikon_fov = (nikon_fov_max+nikon_fov_min)*0.5
local nikon_keybindEnabled = false -- When enabled, nikons are available by keybind
local nikon_nikonKey = 73
local storeNikonKey = 177
local camdate, camsecond, ostime = '', '', nil
local photos = {} -- 
local up = false
local memopac = 190
local displayUploadPathOpac = nil
local currentCamSecond = nil
local currentCamera = nil
local spawnedCam = nil
local deviceSettings = {}
local noMemory = false
local maxPhotos = 200 -- max photos per SD card, intended to prevent items from becoming to massive
local savedcam = nil -- camera places you into first person to not run the scenario
local usedSD = false
local curPage, curAmount, curImageSpace, curPassword, curPhotos = nil, nil, nil, nil, nil
local inventoryMetadata = Config.Inventory.CustomMetadata.Enabled and Config.Inventory.CustomMetadata.Field or  Config.Inventory.Ox and 'metadata' or 'info'
local cameraErrors = { -- these are error messages in the event the server is unable to supply a webhook to the camera when a photo is taken
    ['missing'] = {notify = 'Unable to save photo due to missing network configuration!', print = 'Nikoff server table is missing webhook for upload path %s, please inform staff.'},
    ['blank'] = {notify = 'Unable to save photo due to a faulty network configuration!', print = 'Nikoff server table contains a blank webhook for upload path %s, please inform staff.'},
    ['nopath'] = {notify = 'Unable to save photo due to corrupted device settings!', print = 'Nikoff device settings does not have a proper upload path set, please inform staff to check their r14-evidence camera configuration.'},
}

-------------------------------------------------------------------------------------------
--------------------------        DEFAULT CAMERA SETTINGS        --------------------------
-------------------------------------------------------------------------------------------

local defaultDeviceSettings = {
    showOverlay = true,
    showTimestamp = true,
    uploadImages = false,
    uploadPath = 1,
    uploadPathPassword = nil,
    uploadPathDisplay = Config.Camera[1].Path,
    autoUpload = false,
    flashEnabled = true,
    memoryCard = true,
    memoryCardName = false,
}

-------------------------------------------------------------------------------------------
--------------------------     BASE GAME/QB EVENT HANDLERS       --------------------------
-------------------------------------------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        UpdateCameraData(currentCamera) -- update our camaera data before restart
        if nikon then TriggerServerEvent('evidence:server:setinvbusy', false) SetFollowPedCamViewMode(savedcam) end -- set inv_busy in state bag to false
        ClearPedTasks(PlayerPedId()) -- cancel our animation if using it
        if not IsPedSittingInAnyVehicle(PlayerPedId()) then ClearPedTasksImmediately(PlayerPedId()) end -- clear ped tasks immediately if not sitting in car
        SetEntityAsMissionEntity(spawnedCam, true, true)
        DeleteObject(spawnedCam)
        DeleteEntity(spawnedCam) -- delete our camera if using it
        for k, v in pairs(GetGamePool('CObject')) do -- backup just in case spawnedCam has somehow been lost
            if IsEntityAttachedToEntity(PlayerPedId(), v) and GetEntityModel(v) == camProp then
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
                DeleteEntity(v)
            end
        end
    end
end)

-------------------------------------------------------------------------------------------
--------------------------          CAMERA FUNCTIONS             --------------------------
-------------------------------------------------------------------------------------------

local function OpenContext(menu, title)
    if Config.Context.Ox then   
        local convertedMenu = {
            id = 'evmenu',
            title = ('**%s**'):format(title),
            canClose = true,
            options = menu,
        }
        lib.registerContext(convertedMenu)
        lib.showContext('evmenu')
    elseif Config.Context.QB then
        exports['qb-ui']:openMenu(menu)
    end
end

local function OpenInput(input, title)
    if Config.Context.Ox then
        local userinput = lib.inputDialog(title, input.inputs)
        if not userinput then return end -- cancel input if closed
        userinput[input.inputs[1].name] = userinput[1]
        userinput[1] = nil
        return userinput
    elseif Config.Context.QB then
        return exports['qb-ui']:ShowInput(input)
    end
end

local function loadAnimDict(name)
    while not HasAnimDictLoaded(name) do
        RequestAnimDict(name)
        Wait(10)
    end
    return name
end

function PlayCamAnim()
    if inCamAnim then return end
    inCamAnim = true
    CreateThread(function()
        local coords = GetEntityCoords(ped)
        if not HasModelLoaded(camProp) then
            while not HasModelLoaded(camProp) do
                RequestModel(camProp)
                Wait(10)
            end
        end
        spawnedCam = CreateObject(camProp, coords.x, coords.y, coords.z + 0.2, true, true, true)
        AttachEntityToEntity(spawnedCam, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, loadAnimDict('amb@world_human_paparazzi@male@enter'), 'enter', 5.0, 0.0, 10000, 50, 0, false, false, false)
        Wait(1000)
        while nikon do
            if not IsEntityPlayingAnim(ped, 'amb@world_human_paparazzi@male@enter', 'enter', 3) and not IsEntityPlayingAnim(ped, 'amb@world_human_paparazzi@male@idle_a', 'idle_b', 3) then               
                TaskPlayAnim(ped, loadAnimDict('amb@world_human_paparazzi@male@idle_a'), 'idle_b', 0.1, 0.0, 10000, 50, 0, false, false, false)
            end
            Wait(500) -- wait for nikon use to end
        end
        TaskPlayAnim(ped, loadAnimDict('amb@world_human_paparazzi@male@exit'), 'exit', 1.0, 5.0, -1, 50, 0, false, false, false) -- play base anim if not
        Wait(1100)
        ClearPedTasks(ped)
        ResetPedMovementClipset(ped, 0.8)
        DeleteEntity(spawnedCam)
        inCamAnim = false
    end)
end

function GetCoreSlot(coreid)
    local PlayerData = Config.Functions.PlayerDataClient()
    local coreslot = false
    for k, v in pairs(PlayerData.items) do
        if v.id == coreid then coreslot = k end
    end
    return coreslot
end

function LoadCameraData(slot, inv)
    currentInv = inv
    if slot then
        currentCamera = slot
        local PlayerData = Config.Functions.PlayerDataClient()
        PlayerData.items = inv
        if PlayerData.items[slot][inventoryMetadata] and next(PlayerData.items[slot][inventoryMetadata]) and PlayerData.items[slot][inventoryMetadata].uploadPath then
            deviceSettings = {
                showOverlay = PlayerData.items[slot][inventoryMetadata].showOverlay,
                showTimestamp = PlayerData.items[slot][inventoryMetadata].showTimestamp,
                uploadImages = PlayerData.items[slot][inventoryMetadata].uploadImages,
                uploadPath = PlayerData.items[slot][inventoryMetadata].uploadPath,
                uploadPathPassword = PlayerData.items[slot][inventoryMetadata].uploadPathPassword,
                uploadPathDisplay = PlayerData.items[slot][inventoryMetadata].uploadPathDisplay,
                autoUpload = PlayerData.items[slot][inventoryMetadata].autoUpload,
                flashEnabled = PlayerData.items[slot][inventoryMetadata].flashEnabled,
                memoryCard = PlayerData.items[slot][inventoryMetadata].memoryCard,
                memoryCardName = PlayerData.items[slot][inventoryMetadata].memoryCardName,
            }
            photos = PlayerData.items[slot][inventoryMetadata].photos
        else
            deviceSettings = table.clone(defaultDeviceSettings)
        end
        if PlayerData.items[slot][inventoryMetadata].memoryCard then
            for k, v in pairs(PlayerData.items[slot][inventoryMetadata].photos) do
                photos[k] = v
            end
        else
            photos = {}
        end
        curPhotos = #photos 
    else
        deviceSettings = {}
        photos = {}
    end
end

function UpdateCameraData(slot)
    local info = table.clone(deviceSettings)
    info.photos = photos
    TriggerServerEvent("evidence:server:updatecamerainfo", {slot = slot, info = info})
end

local function VerifyCredentials(uploadPath)
    local PlayerData = Config.Functions.PlayerDataClient() 
    local credentials = false
    if Config.Camera[uploadPath].Auth and Config.AuthorizedJobs[Config.Camera[uploadPath].Auth] and Config.AuthorizedJobs[Config.Camera[uploadPath].Auth].Check() then credentials = true end
    if Config.Camera[uploadPath].Job and PlayerData.job.name == Config.Camera[uploadPath].Job then credentials = true end
    if Config.Camera[uploadPath].Type and PlayerData.job.type == Config.Camera[uploadPath].Type then credentials = true end
    if not Config.Camera[uploadPath].Auth and not Config.Camera[uploadPath].Job and not Config.Camera[uploadPath].Type then credentials = true end
    return credentials
end

function ValidUploadPath(path)
    local upload = path
    if not Config.Camera[path] or deviceSettings.uploadPathDisplay ~= Config.Camera[path].Path then
        Config.Functions.Notify('Опит за качване в пространство за изображения, което не съществува!', 'error')
        upload = false
    end
    if Config.Camera[path].Password and deviceSettings.uploadPathPassword ~= Config.Camera[path].Password then
        Config.Functions.Notify('Опит за качване в пространство за изображения с невалидна парола!', 'error')
        upload = false
    end
    return upload
end

function TakePhoto()
    if deviceSettings.flashEnabled then Wait(50) end
    Config.Functions.TriggerCallback('nikon:GetWebhook', function(webhook)
        exports['screenshot-basic']:requestScreenshotUpload(webhook, 'files[]', {encoding = 'jpg'}, function(data)
            local resp = json.decode(data)
            local photodata = {}
            if cameraErrors[webhook] then Config.Functions.Notify('Моля, свържете се с администратора на пространството за изображения или с отдела за поддръжка на клиенти на Nikoff!', 'error') Config.Functions.Notify(cameraErrors[webhook].notify, 'error') print((cameraErrors[webhook].print):format(deviceSettings.uploadPath)) PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", false) return end
            if resp and resp.attachments then
                PlaySoundFrontend(-1, "Camera_Shoot", "Phone_Soundset_Franklin", false)
                photodata = {
                    url = resp.attachments[1].url,
                    id = resp.attachments[1].id,
                    time = ostime,
                    uploadPath = deviceSettings.uploadPath,
                    exif = {
                        [1] = {label = 'Преглед на GPS координатите', value = GetEntityCoords(ped), order = 1},
                        [2] = {label = "Дата на заснемане:", value = displaydate, order = 2},
                        [3] = {label = 'Дата на заснемане: (Unix)', value = ostime, order = 3},
                        [4] = {label = 'Качена на:', value = deviceSettings.uploadPath ~= 1 and displaydate, order = 4},
                        [5] = {label = 'Настройка на увеличението:', value = nikon_fov, order = 5},
                        [6] = {label = "Формат на снимката:", value = "JPEG", order = 6},
                        [7] = {label = "Светкавица:", value = deviceSettings.flashEnabled and 'ВКЛЮЧЕНА' or 'ИЗКЛЮЧЕНА', order = 7},
                    },
                }
                if deviceSettings.memoryCard then
                    if curPhotos < maxPhotos then
                        photos[#photos + 1] = photodata
                    else
                        Config.Functions.Notify('Паметта е пълна! Моля, освободете място или сменете картата памет!', 'error')
                    end
                end
                if deviceSettings.memoryCard and curPhotos < 10 then
                    photos[#photos + 1 ] = photo
                    curPhotos = #photos 
                end
                if deviceSettings.uploadPath > 1 and Config.Camera[deviceSettings.uploadPath] then
                    TriggerServerEvent('evidence:server:updateimagespace', photodata)
                end
            else
                if not resp then print('Did not recieve a response from requestScreenshotUpload(), please check your webhook to see if it is correct', webhook, data) end
                if not resp and not resp.attachments then print('Recieved response that did not contain attachment, please check your webhook to see if it is correct') end
                Config.Functions.Notify('Не можете да запазите снимка, моля, проверете настройките си или се свържете с отдела за поддръжка на клиенти на Nikoff!', 'error')
                PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", false)
            end
        end)
    end, deviceSettings.uploadPath)
end

function RemovePhoto(photoId)
    local count = 0
    local newphotos = table.clone(photos)
    photos = {}
    for k, v in pairs(newphotos) do
        if k ~= photoId then
            count = count + 1
            photos[count] = v
        end
    end
    UpdateCameraData(currentCamera)
    ViewPhotos()
end

local function CheckInputRotation(nikon_cam, nikon_zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(nikon_cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z + rightAxisX*-1.0*(nikon_speed_ud)*(nikon_zoomvalue+0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(nikon_speed_lr)*(nikon_zoomvalue+0.1)), -89.5)
        SetCamRot(nikon_cam, new_x, 0.0, new_z, 2)
        if nikon and not inveh then SetEntityHeading(ped,new_z) end
    end
end

local function HandleZoom(nikon_cam)
    if IsDisabledControlJustPressed(0,241) then -- Scrollup
        nikon_fov = math.max(nikon_fov - nikon_zoomspeed, nikon_fov_min)
    end
    if IsDisabledControlJustPressed(0,242) then
        nikon_fov = math.min(nikon_fov + nikon_zoomspeed, nikon_fov_max) -- ScrollDown
    end
    local nikon_current_fov = GetCamFov(nikon_cam)
    if math.abs(nikon_fov-nikon_current_fov) < 0.1 then
        nikon_fov = nikon_current_fov
    end
    SetCamFov(nikon_cam, nikon_current_fov + (nikon_fov - nikon_current_fov)*0.05)
end

function CheckAuth(space)
    local PlayerData = Config.Functions.PlayerDataClient() 
    local authorized = false
    if space.Auth and Config.AuthorizedJobs[space.Auth] and Config.AuthorizedJobs[space.Auth].Check() then authorized = true end
    if space.Type and PlayerData.job.type == space.Type then authorized = true end
    if space.Job and PlayerData.job.name == space.Job then authorized = true end
    if not space.Auth and not space.Type and not space.Job then authorized = true end
    return authorized
end

-------------------------------------------------------------------------------------------
---------------------          CAMERA MENU FUNCTIONS             --------------------------
-------------------------------------------------------------------------------------------

function SDcard(slot)
    local PlayerData = Config.Functions.PlayerDataClient()
    local name = nil
    PlayerData.items = Config.Functions.SearchInventoryClient('sdcard', true)
    local nikoffMenu = {
        {
            header = ('Управление на картата памет'):format(),
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    for k, v in pairs(PlayerData.items) do
        if v.slot == slot then
            name = v[inventoryMetadata].name
        end
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = ('Преименуване "%s"'):format(name),
        title = ('Преименуване "%s"'):format(name),
        params = {
            isAction = true,
            event = RenameSD,
            args = slot,
        },
        onSelect = RenameSD,
        args = slot,
    }
    OpenContext(nikoffMenu, 'Управление на картата памет')
end

function SelectImageSpace()
    local nikoffMenu = {
        {
            header = 'Изберете пространство за изображения',
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    for k, v in ipairs(Config.Camera) do
        if k ~= 1 then
            if CheckAuth(v) then
                nikoffMenu[#nikoffMenu+1] = {
                    header = v.Path,
                    title = v.Path,
                    params = {
                        isAction = true,
                        event = function()
                            if v.Password then
                                local input = OpenInput({
                                    header = v.Path,
                                    submitText = "Влизане",
                                    inputs = {
                                        {
                                            text = 'Парола',
                                            name = "password",
                                            type = Config.Context.Ox and 'input' or "text",
                                            isRequired = true,
                                            default = preexisting,
                                        },
                                    },
                                }, 'Парола')
                                if input.password == v.Password then
                                    curImageSpace = k
                                    curPage = 1
                                    curPassword = input.password
                                    curAmount = 5
                                    TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = k, page = curPage, amount = curAmount, password = input.password})
                                elseif input.password ~= v.Password then
                                    Config.Functions.Notify('Невалидна парола, моля, опитайте отново', 'error') 
                                    SelectImageSpace() -- return to this function if incorrect for another attempt
                                    return
                                end
                            else
                                curImageSpace = k
                                curPage = 1
                                curAmount = 5
                                TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = k, page = curPage, amount = curAmount})
                            end
                        end,
                    },
                    onSelect = function()
                        if v.Password then
                            local input = OpenInput({
                                header = v.Path,
                                submitText = "Влизане",
                                inputs = {
                                    {
                                        text = 'Парола',
                                        name = "password",
                                        type = Config.Context.Ox and 'input' or "text",
                                        isRequired = true,
                                        default = preexisting,
                                    },
                                },
                            }, 'Парола')
                            if input.password == v.Password then
                                curImageSpace = k
                                curPage = 1
                                curPassword = input.password
                                curAmount = 5
                                TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = k, page = curPage, amount = curAmount, password = input.password})
                            elseif input.password ~= v.Password then
                                Config.Functions.Notify('Невалидна парола, моля, опитайте отново', 'error')
                                SelectImageSpace() -- return to this function if incorrect for another attempt
                                return
                            end
                        else
                            curImageSpace = k
                            curPage = 1
                            curAmount = 5
                            TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = k, page = curPage, amount = curAmount})
                        end
                    end,
                }
            end
        end
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            isAction = true,
            event = DeviceSettings,
        },
        onSelect = DeviceSettings,
    }
    OpenContext(nikoffMenu, 'Изберете пространство за изображения')
end

function RenameSD(slot)
    local PlayerData = Config.Functions.PlayerDataClient()
    local name = nil
    PlayerData.items = Config.Functions.SearchInventoryClient('sdcard', true)
    for k, v in pairs(PlayerData.items) do
        if v.slot == slot then
            name = v[inventoryMetadata].name
        end
    end
    local input = OpenInput({
        header = "Име на картата памет",
        submitText = "Име на картата памет",
        inputs = {
            {
                text = 'Новото име',
                name = "newname",
                type = Config.Context.Ox and 'input' or "text",
                isRequired = true,
                default = name,
            },
        },
    }, "Име на картата памет")
    if input and input.newname then
        TriggerServerEvent('evidence:server:updateSDcard', {slot = slot, name = input.newname})
        Wait(1000)
        SDcard(slot)
    end
end

RegisterNetEvent('evidence:client:uploadphoto', UploadPhoto)
function UploadPhoto(photo)
    local nikoffMenu = {
        {
            header = 'Изберете пространство за качване на изображения',
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    for k, v in ipairs(Config.Camera) do
        if k ~= 1 then
            if VerifyCredentials(k) then
                nikoffMenu[#nikoffMenu+1] = {
                    header = v.Path,
                    title = v.Path,
                    params = {
                        isAction = true,
                        event = function()
                            if v.Password then
                                local input = OpenInput({
                                    header = v.Path,
                                    submitText = "Влизане",
                                    inputs = {
                                        {
                                            text = 'Парола',
                                            name = "password",
                                            type = Config.Context.Ox and 'input' or "text",
                                            isRequired = true,
                                            default = preexisting,
                                        },
                                    },
                                }, 'Парола')
                                if input.password == v.Password then
                                    photo.uploadPath = k
                                    photos[photo.photoId].exif[4].value = displaydate
                                    photo.exif[4].value = displaydate
                                    TriggerServerEvent('evidence:server:uploadphoto', k, photo)
                                elseif input.password ~= v.Password then
                                    Config.Functions.Notify('Невалидна парола, моля, опитайте отново', 'error')
                                    ManagePhoto(photo)
                                    return
                                end
                            else
                                photos[photo.photoId].exif[4].value = displaydate
                                photo.exif[4].value = displaydate
                                photo.uploadPath = k
                                TriggerServerEvent('evidence:server:uploadphoto', k, photo)
                            end
                            ManagePhoto(photo)
                        end,
                    },
                    onSelect = function()
                        if v.Password then
                            local input = OpenInput({
                                header = v.Path,
                                submitText = "Влизане",
                                inputs = {
                                    {
                                        text = 'Парола',
                                        name = "password",
                                        type = Config.Context.Ox and 'input' or "text",
                                        isRequired = true,
                                        default = preexisting,
                                    },
                                },
                            }, 'Парола')
                            if input.password == v.Password then
                                photo.uploadPath = k
                                photos[photo.photoId].exif[4].value = displaydate
                                photo.exif[4].value = displaydate
                                TriggerServerEvent('evidence:server:uploadphoto', k, photo)
                            elseif input.password ~= v.Password then
                                Config.Functions.Notify('Невалидна парола, моля, опитайте отново', 'error')
                                ManagePhoto(photo)
                                return
                            end
                        else
                            photos[photo.photoId].exif[4].value = displaydate
                            photo.exif[4].value = displaydate
                            photo.uploadPath = k
                            TriggerServerEvent('evidence:server:uploadphoto', k, photo)
                        end
                        ManagePhoto(photo)
                    end,
                }
            end
        end
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            isAction = true,
            event = DeviceSettings,
        },
        onSelect = DeviceSettings,
    }
    OpenContext(nikoffMenu, 'Изберете пространство за качване на изображения')
end

function ManagePhoto(photo)
    local nikoffMenu = {
        {
            header = ('nikoff_%s.jpg'):format(photo.id),
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    nikoffMenu[#nikoffMenu+1] = {
        header = ('<img src="%s" style="max-width: 250px; max-height: 150px;" />'):format(photo.url),
        title = ('![Снимка](%s)'):format(photo.url),
        image = photo.url, 
        params = {
            isAction = true,
            event = function()
                OpenContext({{
                    header = ('<img src="%s" style="max-width: 250px;" />'):format(photo.url),
                    params = {
                        isAction = true,
                        event = ManagePhoto,
                        args = photo,
                    }
                }})
            end,
        },
    }
    for k, v in pairs(photo.exif) do
        local isGPS = false
        if type(v.value) == 'table' or type(v.value) == 'vector3' then isGPS = true end
        local hdr = isGPS and v.label or nil
        local args = isGPS and v.value or nil
        if isGPS then hdr = v.label end
        nikoffMenu[#nikoffMenu+1] = {
            header = hdr or ('%s %s'):format(v.label, v.value),
            title = hdr or ('%s %s'):format(v.label, v.value),
            disabled = not isGPS,
            params = {
                isAction = isGPS and true,
                event = isGPS and function(args)
                    SetNewWaypoint(v.value.x, v.value.y)
                    Config.Functions.Notify(('GPS-а е зададен за (%s, %s)'):format(v.value.x, v.value.y)) 
                    ManagePhoto(photo)
                end,
                args = args,
            },
            onSelect = isGPS and function(args)
                SetNewWaypoint(v.value.x, v.value.y)
                Config.Functions.Notify(('GPS-а е зададен за (%s, %s)'):format(v.value.x, v.value.y)) 
                ManagePhoto(photo)
            end,
            args = args,
        }
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = 'Управление на снимката',
        title = '**Управление на снимката**',
        isMenuHeader = true,
    }
    if photo.exif[4].value then
        nikoffMenu[#nikoffMenu+1] = {
            header = 'Копиране на линка',
            title = 'Копиране на линка',
            params = {
                event = 'evidence:client:CopyEvidence',
                args = {
                    text = photo.url,
                },
            },
            event = 'evidence:client:CopyEvidence',
            args = {
                text = photo.url,
            },
        }
    end
    if not photo.imageSpace then
        nikoffMenu[#nikoffMenu+1] = {
            header = 'Качване на снимката',
            title = 'Качване на снимката',
            params = {
                isAction = true,
                event = UploadPhoto,
                args = photo,
            },
            onSelect = UploadPhoto,
            args = photo,
        }
        nikoffMenu[#nikoffMenu+1] = {
            header = 'Изтриване на снимката',
            title = 'Изтриване на снимката',
            params = {
                isAction = true,
                event = function()
                    RemovePhoto(photo.photoId)
                end,
            },
            onSelect = function()
                RemovePhoto(photo.photoId)
            end,
        }
    end
    if (Config.MDT.PS or Config.MDT.DRX) and Config.AuthorizedJobs.LEO.Check() then
        nikoffMenu[#nikoffMenu+1] = {
            header = ('Качена в %s'):format(Config.MDT.PS and 'MDT' or Config.MDT.DRX and 'MDW'),
            title = ('Качена в %s'):format(Config.MDT.PS and 'MDT' or Config.MDT.DRX and 'MDW'),
            params = {
                isAction = true,
                event = UpdateMDT,
                args = photo,
            },
            onSelect = UpdateMDT,
            args = photo,
        }
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            isServer = photo.imageSpace,
            isAction = not photo.imageSpace,
            event = photo.imageSpace and 'evidence:server:fetchnetphotos' or ViewPhotos,
            args = {imageSpace = curImageSpace, page = curPage, amount = curAmount or 20},
        },
        onSelect = not photo.imageSpace and ViewPhotos,
        serverEvent = photo.imageSpace and 'evidence:server:fetchnetphotos',
        args = {imageSpace = curImageSpace, page = curPage, amount = curAmount or 20},
    }
    OpenContext(nikoffMenu, ('nikoff_%s.jpg'):format(photo.id))
end

function UpdateMDT(data)
    local inputs = {
        {
            text = 'Номер на доклада',
            name = "id",
            type = 'number',
            isRequired = true,
            default = preexisting,
        },
        {
            text = 'Заглавие',
            name = "title",
            type = Config.Context.Ox and 'input' or "text",
            isRequired = true,
            default = preexisting,            
        },
        {
            text = 'Описание',
            name = "description",
            type = Config.Context.Ox and 'input' or "text",
            isRequired = true,
            default = preexisting,            
        },
    }
    if not Config.MDT.DRX then inputs[2] = nil inputs[3] = nil end
    local input = OpenInput({
        header = ('Качена в %s'):format(Config.MDT.PS and 'MDT' or Config.MDT.DRX and 'MDW'),
        submitText = 'Качване',
        inputs = inputs,
    }, ('Качена в %s'):format(Config.MDT.PS and 'MDT' or Config.MDT.DRX and 'MDW'))
    if input then 
        TriggerServerEvent('evidence:server:updatemdt', {url = data.url, description = input.description, title = input.title, id = input.id})   
    else
        Config.Functions.Notify('Нещо се случи..', 'error')
        ManagePhoto(data)
    end   
end

function ViewPhotos()
    local nikoffMenu = {
        {
            header = 'Nikoff G900 Вградена памет',
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    if next(photos) then
        for i = #photos, 1, -1 do
            if photos[i] then
                local v = table.clone(photos[i])
                v.photoId = i
                nikoffMenu[#nikoffMenu+1] = {
                    header = ('<img src="%s" style="max-width: 150px; max-height: 150px; object-fit: cover;" />'):format(photos[i].url),
                    text = ('Направена на: %s</br> Качена: %s'):format(v.exif[2].value, v.exif[4].value or 'false'),
                    title = ('![Снимка](%s) Taken: %s'):format(photos[i].url, v.exif[2].value),
                    description = ('Качена: %s'):format(v.exif[4].value or 'false'),
                    params = {
                        isAction = true,
                        event = ManagePhoto,
                        args = v,
                    },
                    onSelect = ManagePhoto,
                    args = v,
                }
            end
        end
    else
        nikoffMenu[#nikoffMenu+1] = {
            header = 'Няма налични снимки',
            title = 'Няма налични снимки',
            disabled = true,
        }
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            isAction = true,
            event = DeviceSettings,
        },
        onSelect = DeviceSettings,
    }
    OpenContext(nikoffMenu, 'Nikoff G900 Вградена памет')
end

function ChangeUpload()
    local nikoffMenu = {
        {
            header = 'Nikoff G900 Настройки за качване',
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    for k, v in ipairs(Config.Camera) do
        if VerifyCredentials(k) then
            nikoffMenu[#nikoffMenu+1] = {
                header = ('%s&nbsp%s'):format(v.Path, deviceSettings.uploadPath == k and '<p style="color:Green;"><strong>ВКЛЮЧЕНО<strong></p>' or '<p style="color:Tomato;"><strong>ИЗКЛЮЧЕНО<strong></p>'),
                title = ('%s **%s**'):format(v.Path, deviceSettings.uploadPath == k and 'ВКЛЮЧЕНО' or 'ИЗКЛЮЧЕНО'),
                params = {
                    isAction = true,
                    event = function()
                        if v.Password then
                            local input = OpenInput({
                                header = v.Path,
                                submitText = "Влизане",
                                inputs = {
                                    {
                                        text = 'Парола',
                                        name = "password",
                                        type = Config.Context.Ox and 'input' or "text",
                                        isRequired = true,
                                        default = preexisting,
                                    },
                                },
                            }, 'Парола')
                            if input.password == v.Password then 
                                deviceSettings.uploadPath = k
                                deviceSettings.uploadPathPassword = v.Password
                                deviceSettings.uploadPathDisplay = v.Path 
                                displayUploadPathOpac = 190
                            elseif input.password ~= v.Password then
                                Config.Functions.Notify('Невалидна парола, моля, опитайте отново', 'error')
                                ChangeUpload()
                            end
                        else
                            deviceSettings.uploadPath = k
                            deviceSettings.uploadPathDisplay = v.Path 
                            displayUploadPathOpac = 190
                        end

                        ChangeUpload()
                    end,
                },
                onSelect = function()
                    if v.Password then
                        local input = OpenInput({
                            header = v.Path,
                            submitText = "Влизане",
                            inputs = {
                                {
                                    text = 'Парола',
                                    name = "password",
                                    type = Config.Context.Ox and 'input' or "text",
                                    isRequired = true,
                                    default = preexisting,
                                },
                            },
                        }, "Парола")
                        if input.password == v.Password then 
                            deviceSettings.uploadPath = k
                            deviceSettings.uploadPathPassword = v.Password
                            deviceSettings.uploadPathDisplay = v.Path 
                            displayUploadPathOpac = 190
                        elseif input.password ~= v.Password then
                            Config.Functions.Notify('Невалидна парола, моля, опитайте отново', 'error')
                            ChangeUpload()
                        end
                    else
                        deviceSettings.uploadPath = k
                        deviceSettings.uploadPathDisplay = v.Path 
                        displayUploadPathOpac = 190
                    end
                    ChangeUpload()
                end,
            }
        end
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            isAction = true,
            event = DeviceSettings,
        },
        onSelect = DeviceSettings,
    }
    OpenContext(nikoffMenu, 'Nikoff G900 Настройки за качване')
end

function DeviceSettings(open)
    UpdateCameraData(currentCamera)

    local nikoffMenu = {
        {
            header = 'Nikoff G900 Настройки',
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    nikoffMenu[#nikoffMenu+1] = {
        header = ('Рамка:&nbsp%s'):format(deviceSettings.showOverlay and '<p style="color:Gold;"><strong>ВКЛЮЧЕНА<strong></p>' or '<p style="color:LightCoral;"><strong>ИЗКЛЮЧЕНА<strong></p>'),
        title = ('Рамка: **%s**'):format(deviceSettings.showOverlay and 'ВКЛЮЧЕНА' or 'ИЗКЛЮЧЕНА'),
        params = {
            isAction = true,
            event = function()
                deviceSettings.showOverlay = not deviceSettings.showOverlay
                DeviceSettings()
            end,
        },
        onSelect = function()
            deviceSettings.showOverlay = not deviceSettings.showOverlay
            DeviceSettings()
        end,
    }
    nikoffMenu[#nikoffMenu+1] = {
        header = ('Дата и час:&nbsp%s'):format(deviceSettings.showTimestamp and '<p style="color:Gold;"><strong>ВКЛЮЧЕНИ<strong></p>' or '<p style="color:LightCoral;"><strong>ИЗКЛЮЧЕНИ<strong></p>'),
        title = ('Показване на дата и час: **%s**'):format(deviceSettings.showTimestamp and 'ВКЛЮЧЕНИ' or 'ИЗКЛЮЧЕНИ'),
        params = {
            isAction = true,
            event = function()
                deviceSettings.showTimestamp = not deviceSettings.showTimestamp
                DeviceSettings()
            end,
        },
        onSelect = function()
            deviceSettings.showTimestamp = not deviceSettings.showTimestamp
            DeviceSettings()
        end,
    }
    nikoffMenu[#nikoffMenu+1] = {
        header = ('Светкавица:&nbsp%s'):format(deviceSettings.flashEnabled and '<p style="color:Gold;"><strong>ВКЛЮЧЕНА<strong></p>' or '<p style="color:LightCoral;"><strong>ИЗКЛЮЧЕНА<strong></p>'),
        title = ('Светкавица: **%s**'):format(deviceSettings.flashEnabled and 'ВКЛЮЧЕНА' or 'ИЗКЛЮЧЕНА'),
        params = {
            isAction = true,
            event = function()
                deviceSettings.flashEnabled = not deviceSettings.flashEnabled
                DeviceSettings()
            end,
        },
        onSelect = function()
                deviceSettings.flashEnabled = not deviceSettings.flashEnabled
                DeviceSettings()
            end,
    }
    nikoffMenu[#nikoffMenu+1] = {
        header = ('Качване на снимките:&nbsp%s'):format(deviceSettings.uploadPath ~= 1 and '<p style="color:Gold;"><strong>ВКЛЮЧЕНО<strong></p>' or '<p style="color:LightCoral;"><strong>ИЗКЛЮЧЕНО<strong></p>'),
        title = ('Качване на снимките: **%s**'):format(deviceSettings.uploadPath ~= 1 and 'ВКЛЮЧЕНО' or 'ИЗКЛЮЧЕНО'),
        params = {
            isAction = true,
            event = ChangeUpload,
        },
        onSelect = ChangeUpload,
    }
    nikoffMenu[#nikoffMenu+1] = {
        header = 'Преглед на пространството',
        title = 'Преглед на пространството',
        params = {
            isAction = true,
            event = SelectImageSpace,
        },
        onSelect = SelectImageSpace,
    }
    nikoffMenu[#nikoffMenu+1] = {
        header = 'Преглед на снимките',
        title = 'Преглед на снимките',
        disabled = not deviceSettings.memoryCard,
        params = {
            isAction = true,
            event = ViewPhotos,
        },
        onSelect = ViewPhotos,
    }
    local hdr = deviceSettings.memoryCard and 'Изкарване на картата памет' or 'Вкарване на картата памет'
    nikoffMenu[#nikoffMenu+1] = {
        header = hdr,
        title = hdr,
        params = {
            isAction = true,
            event = function()
                if deviceSettings.memoryCard then
                    local data = {info = {photos = table.clone(photos), name = deviceSettings.memoryCardName}}
                    TriggerServerEvent('evidence:server:sdcard', data)
                else
                    SelectSDCard()
                end
            end,
        },
        onSelect = function()
            if deviceSettings.memoryCard then
                local data = {info = {photos = table.clone(photos), name = deviceSettings.memoryCardName}}

                TriggerServerEvent('evidence:server:sdcard', data)
            else
                SelectSDCard()
            end
        end,
    }
    OpenContext(nikoffMenu, 'Nikoff G900 Настройки')
end

function SelectSDCard(open)
    if deviceSettings.memoryCard then DeviceSettings() return end

    local nikoffMenu = {
        {
            header = 'Избор на карта памет от джоба',
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    local PlayerData = Config.Functions.PlayerDataClient()
    PlayerData.items = Config.Functions.SearchInventoryClient('sdcard', true)
    for k, v in pairs(PlayerData.items) do
        if v.name == 'sdcard' then
            local cardPhotos = v[inventoryMetadata].photos and #v[inventoryMetadata].photos or 0
            nikoffMenu[#nikoffMenu+1] = {
                header = v[inventoryMetadata].name and ('Карта памет: "%s"'):format(v[inventoryMetadata].name) or 'Неименувана карта памет',
                text = ('Слот %s, Снимки %s'):format(v.slot, cardPhotos < maxPhotos and cardPhotos or cardPhotos >= maxPhotos and 'В момента е пълна'),
                title = v[inventoryMetadata].name and ('Карта памет: "%s"'):format(v[inventoryMetadata].name) or 'Неименувана карта памет',
                description = ('Слот %s, Снимки %s'):format(k, cardPhotos < maxPhotos and cardPhotos or cardPhotos >= maxPhotos and 'В момента е пълна'),
                params = {
                    isAction = true,
                    event = function()
                        if not deviceSettings.memoryCard then
                            local data = {slot = v.slot}
                            TriggerServerEvent('evidence:server:sdcard', data)
                        end
                    end,
                },
                onSelect = function()
                    if not deviceSettings.memoryCard then
                        local data = {slot = v.slot}
                        TriggerServerEvent('evidence:server:sdcard', data)
                    end
                end,
            }
        end
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            event = DeviceSettings,
        },
        event = DeviceSettings,
    }
    OpenContext(nikoffMenu, 'Избор на карта памет от джоба')
end

-------------------------------------------------------------------------------------------
---------------------     CAMERA OVERLAY/GENERAL FUNCTIONS       --------------------------
-------------------------------------------------------------------------------------------

local function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1) -- Wanted Stars
    HideHudComponentThisFrame(2) -- Weapon icon
    HideHudComponentThisFrame(3) -- Cash
    HideHudComponentThisFrame(4) -- MP CASH
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13) -- Cash Change
    HideHudComponentThisFrame(11) -- Floating Help Text
    HideHudComponentThisFrame(12) -- more floating help text
    HideHudComponentThisFrame(15) -- Subtitle Text
    HideHudComponentThisFrame(18) -- Game Stream
    HideHudComponentThisFrame(19) -- weapon wheel
end

local function Overlay()
    SetTextScale(.9, .9)
    SetTextFont(2)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 190)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString('REC')
    EndTextCommandDisplayText(0.91,.08)
    DrawSprite('cameraoverlay', 'corner', 0.1, 0.15, .1, .2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'corner', 0.9, 0.15, -.1, .2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'corner', 0.1, 0.85, .1, -.2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'corner', 0.9, 0.85, -.1, -.2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'battery', 0.095, 0.11, .04, .04, 0, 255, 255, 255, 190)
    if camsecond == '1' or camsecond == '3' or camsecond == '5' or camsecond == '7' or camsecond == '9' then
        DrawSprite('cameraoverlay', 'dot', 0.85, 0.109, .089, .07, 0, 210, 0, 0, 190)
    end
    if deviceSettings.flashEnabled then DrawSprite('cameraoverlay', 'flash', 0.134, 0.11, .029, .04, 0, 255, 255, 255, 190) end
end

local function NoMemoryWarning()
    if memopac == 0 then up = true elseif memopac == 190 then up = false end
    if not up then memopac = memopac - 1 else memopac = memopac + 1 end
    SetTextScale(.7, .7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, memopac)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString('Няма налична памет')
    EndTextCommandDisplayText(0.445, 0.475)
    SetTextScale(.7, .7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, memopac)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString('Моля, изберете място за съхранение или поставете SD карта')
    EndTextCommandDisplayText(0.375, 0.525)
end

local function MemoryFullWarning()
    if memopac == 0 then up = true elseif memopac == 190 then up = false end
    if not up then memopac = memopac - 1 else memopac = memopac + 1 end
    SetTextScale(.7, .7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, memopac)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString('Паметта е пълна')
    EndTextCommandDisplayText(0.072, 0.145)
end

local function Timestamp()
    SetTextScale(.7, .7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 190)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString(camdate)
    EndTextCommandDisplayText(0.07, 0.87)
end

local function DisplaySettingsKey(opac)
    SetTextScale(.6, .6)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, opac or 190)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString('КАРТА ПАМЕТ [E]')
    EndTextCommandDisplayText(0.85, 0.88)
end

local function DisplayUploadPath(opac)
    SetTextScale(.7, .7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, opac or 190)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString(('Запазване в: %s'):format(deviceSettings.uploadPathDisplay))
    EndTextCommandDisplayText(0.07, 0.82)
end

local function CloseCam()
    SetStreamedTextureDictAsNoLongerNeeded('cameraoverlay')
    ClearTimecycleModifier()
    nikon_fov = (nikon_fov_max+nikon_fov_min)*0.5
    if not inveh then
        SetFollowPedCamViewMode(savedcam)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(nikon_cam, false)
    else
        CellCamActivate(false, false)
        DestroyMobilePhone()

        inveh = false
    end
    UpdateCameraData(currentCamera)
    LoadCameraData(false)
    currentCamera = false
    currentCamSecond = false
    nikon = false
    TriggerServerEvent('nikon:server:CancelTime')
end

local function CamLoop()
    currentCamSecond = camsecond
    local displaySettingsOpac = 190
    displayUploadPathOpac = 190
    TriggerServerEvent('evidence:server:setinvbusy', true)
    while nikon and (inCamAnim or (inveh and vehicle)) do
        DisableControlAction(0, 200) -- escape/map
        DisableControlAction(1, 200) -- escape/map
        DisableControlAction(2, 200) -- escape/map
        DisableControlAction(0, 241)
        DisableControlAction(1, 241)
        DisableControlAction(0, 242)
        DisableControlAction(1, 242)
        DisableControlAction(2, 241)
        DisableControlAction(2, 242)
        DisableControlAction(0, 83)
        DisableControlAction(1, 83)
        DisableControlAction(2, 83)
        DisableControlAction(0, 84)
        DisableControlAction(1, 84)
        DisableControlAction(2, 84)
        DisableControlAction(0, 24)
        DisableControlAction(1, 24)
        DisableControlAction(2, 24)
        DisableControlAction(0, 25)
        DisableControlAction(1, 25)
        DisableControlAction(2, 25)
        DisableControlAction(0, 51)
        DisableControlAction(1, 51)
        DisableControlAction(2, 51)
        DisableControlAction(0, 30, true)  -- disable movement
        DisableControlAction(0, 36, true)  -- disable movement
        DisableControlAction(0, 31, true)  -- disable movement
        DisableControlAction(0, 36, true)  -- disable movement
        DisableControlAction(0, 21, true)  -- disable movement
        DisableControlAction(0, 75, true)  -- disable movement
        DisableControlAction(27, 75, true) -- disable movement
        if displaySettingsOpac > 0 or displayUploadPathOpac > 0 then
            if displaySettingsOpac > 0 then displaySettingsOpac = displaySettingsOpac - 1 end
            if displayUploadPathOpac > 0 then displayUploadPathOpac = displayUploadPathOpac - 1 end
            DisplaySettingsKey(displaySettingsOpac)
            DisplayUploadPath(displayUploadPathOpac)
        end
        HideHUDThisFrame() -- hide gta hud
        if deviceSettings.showOverlay then Overlay() end -- display cam frame and battery
        if deviceSettings.showTimestamp then Timestamp() end -- display cam timestamp
        if deviceSettings.uploadImages and deviceSettings.uploadPath then DisplayUpload() end
        if not deviceSettings.memoryCard and deviceSettings.uploadPath == 1 then noMemory = true NoMemoryWarning() else noMemory = false end
        if deviceSettings.memoryCard and curPhotos >= maxPhotos then MemoryFullWarning() noMemory = true end
        if IsControlJustReleased(0, storeNikonKey) or (not IsNuiFocused() and IsDisabledControlJustReleased(0, 200)) then -- escape loop
            break
        end
        if IsControlJustReleased(0, 177) or IsControlJustReleased(0, 157) or IsControlJustReleased(0, 158) or IsControlJustReleased(0, 160) or IsControlJustReleased(0, 164) or IsControlJustReleased(0, 165) or IsControlJustReleased(0, 159) then
            break
        end
        if IsControlJustReleased(0, 23) then
            deviceSettings.flashEnabled = not deviceSettings.flashEnabled
        end
        if IsDisabledControlJustReleased(0, 24) and not noMemory and ValidUploadPath(deviceSettings.uploadPath) then -- take photo
            if deviceSettings.flashEnabled then
                RequestNamedPtfxAsset("scr_bike_business")
                UseParticleFxAssetNextCall("scr_bike_business")
                Ptfx = StartParticleFxLoopedOnEntityBone("scr_bike_cfid_camera_flash", spawnedCam, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName("scr_bike_cfid_camera_flash", "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
            end
            CreateThread(TakePhoto)
        elseif IsDisabledControlJustReleased(0, 24) then
            PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", false)
        end
        if IsDisabledControlJustReleased(0, 51) then -- open camera settings
            DeviceSettings()
        end
        if not inveh then -- handles camera when on foot, cell phone camera covers these functions otherwise
            local nikon_zoomvalue = (1.0/(nikon_fov_max-nikon_fov_min))*(nikon_fov-nikon_fov_min)
            CheckInputRotation(nikon_cam, nikon_zoomvalue)
            HandleZoom(nikon_cam)
        end
        Wait(0)
    end
    TriggerServerEvent('evidence:server:setinvbusy', false)
    CloseCam() -- when loop breaks close camera
end

-------------------------------------------------------------------------------------------
---------------------          CAMERA EVENT HANDLERS             --------------------------
-------------------------------------------------------------------------------------------

RegisterNetEvent("evidence:client:receivenetphotos", function(photopackage, nextpage)
    local nikoffMenu = {
        {
            header = ('Преглед %s'):format(Config.Camera[curImageSpace].Path or 'Дискоро пространство'),
            isMenuHeader = true,
        }
    }
    if Config.Context.Ox then nikoffMenu = {} end
    if photopackage and next(photopackage) then
        if curPage > 1 then
            nikoffMenu[#nikoffMenu+1] = {
                header = '<-- Предходна страница',
                title = '<-- Предходна страница',
                params = {
                    isAction = true,
                    event = function()
                        curPage = curPage - 1
                        TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = curImageSpace, page = curPage, amount = curAmount or 20, password = curPassword})
                    end,
                },
                onSelect = function()
                    curPage = curPage - 1
                    TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = curImageSpace, page = curPage, amount = curAmount or 20, password = curPassword})
                end,
            }
        end
        for i = 1, #photopackage, 1 do     
            if photopackage[i] then
                local v = table.clone(photopackage[i])
                v.photoId = i
                v.imageSpace = true
                nikoffMenu[#nikoffMenu+1] = {
                    header = ('<img src="%s" style="max-width: 150px; max-height: 150px; object-fit: cover;" />'):format(v.url),
                    text = ('Направена на: %s</br> Качена: %s'):format(v.exif[2].value, v.exif[4].value or 'false'),
                    title = ('![Снимка](%s)'):format(v.url),
                    description = ('Направена на: %s Качена: %s'):format(v.exif[2].value, v.exif[4].value or 'false'),
                    params = {
                        isAction = true,
                        event = ManagePhoto,
                        args = v,
                    },
                    onSelect = ManagePhoto,
                    args = v,
                }
            end
        end
        if nextpage then
            nikoffMenu[#nikoffMenu+1] = {
                header = 'Следваща страница -->',
                params = {
                    isAction = true,
                    event = function()
                        curPage = curPage + 1
                        TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = curImageSpace, page = curPage, amount = curAmount or 20, password = curPassword})                
                    end,
                },
                onSelect = function()
                    curPage = curPage + 1
                    TriggerServerEvent('evidence:server:fetchnetphotos', {imageSpace = curImageSpace, page = curPage, amount = curAmount or 20, password = curPassword})                
                end,
            }
        end
    else
        nikoffMenu[#nikoffMenu+1] = {
            header = 'Няма налични снимки',
            title = 'Няма налични снимки',
            disabled = true,
        }
    end
    nikoffMenu[#nikoffMenu+1] = {
        header = "<- Връщане",
        title = "<- Връщане",
        params = {
            isAction = true,
            event = DeviceSettings,
        },
        onSelect = DeviceSettings,
    }
    OpenContext(nikoffMenu, ('Преглед на %s'):format(Config.Camera[curImageSpace].Path or 'Дисково пространство'))
end)

RegisterNetEvent("evidence:client:confirmeject", function(data)
    photos = {}
    deviceSettings.memoryCard = false
    deviceSettings.memoryCardName = nil
    DeviceSettings()
end)

RegisterNetEvent("evidence:client:confirminsert", function(data)
    photos = data.photos or {}
    deviceSettings.memoryCard = true
    deviceSettings.memoryCardName = data.name
    curPhotos = #photos
    if not usedSD then DeviceSettings() else Config.Functions.Notify('SD Card has been inserted!') usedSD = false end
end)

RegisterNetEvent('nikon:client:time', function(printdate, time, date)
    ostime = time
    camdate = date
    displaydate = printdate
    camsecond = string.sub(camdate, 27, 27)
end)

RegisterNetEvent("nikon:useSDCard", function(slot, inv)
    currentInv = inv
    if nikon and currentCamSecond and not deviceSettings.memoryCard then
        local data = {slot = slot}
        usedSD = true
        TriggerServerEvent('evidence:server:sdcard', data)
    elseif nikon and currentCamSecond and deviceSettings.memoryCard then
        Config.Functions.Notify('В този фотоапарат вече е поставена карта памет!', 'error')
        return
    else
        local PlayerData = Config.Functions.PlayerDataClient()
        local name = nil
        PlayerData.items = Config.Functions.SearchInventoryClient('sdcard', true)
        for k, v in pairs(PlayerData.items) do
            if v.slot == slot then
                name = v[inventoryMetadata].name
            end
        end
        if name then
            SDcard(slot)
        else
            RenameSD(slot)
        end
    end
end)

RegisterNetEvent('evidence:client:setnikon', function(bool)
    nikon = bool
end)

RegisterNetEvent('nikon:Toggle', function(slot, inv, coreid)
    if nikon and not currentCamSecond then return end
    if coreid then slot = GetCoreSlot(coreid) end
    if not slot and coreid then print('You are using core inventory and script is unable to find the item slot for the camera you used. Please consider a different inventory.') return end
    if nikon and IsControlPressed(0, 21) or IsControlPressed(1, 21) or IsControlPressed(2, 21) then
        local PlayerData = Config.Functions.PlayerDataClient()
        PlayerData.items = Config.Functions.SearchInventoryClient('nikon', true)
        photos = PlayerData.items[slot] and PlayerData.items[slot][inventoryMetadata].photos
        LoadCameraData(slot, inv, coreid)
        DeviceSettings()
    elseif not nikon then
        nikon = true
        LoadCameraData(slot, inv, coreid)
        if GetPedConfigFlag(ped, 194) then
            prevCoords = GetEntityCoords(ped)
            ClearPedTasks(ped)
            SetEntityCoords(ped, prevCoords.x, prevCoords.y, prevCoords.z - 1.0)
            Wait(2000) -- wait for the previous scenario to end, ped will not recieve the papparazi scenario until it has fully ended
        else
            ClearPedTasks(ped)
        end
        if IsPedArmed(ped, -1) then
            SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
            TriggerEvent('weapons:client:SetCurrentWeapon', nil, false)
            Wait(100)
            while IsPedArmed(ped, -1) do
                Wait(200)
            end
        end
        Wait(200)
  	    PlayCamAnim()
        RequestStreamedTextureDict('cameraoverlay')
        Wait(1500)
        SetTimecycleModifier("default")
        SetTimecycleModifierStrength(0.3)
        if not vehicle then
            inveh = false
            savedcam = GetFollowPedCamViewMode()
            SetFollowPedCamViewMode(4)
            nikon_cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
            AttachCamToEntity(nikon_cam, ped, 0.0, 0.68, 0.68, true)
            SetCamRot(nikon_cam, 0.0,0.0,GetEntityHeading(ped))
            SetCamFov(nikon_cam, nikon_fov)
            RenderScriptCams(true, false, 0, 1, 0)
        else
            inveh = true
            CreateMobilePhone(0)
            CellCamActivate(true, true)
        end
        CamLoop()
    else
        CloseCam()
    end
end)

-------------------------------------------------------------------------------------------
---------------------                    THREADS                 --------------------------
-------------------------------------------------------------------------------------------

CreateThread(function() -- main thread
	while true do
        if LocalPlayer.state.isLoggedIn then
	        ped = PlayerPedId()   
            vehicle = IsPedSittingInAnyVehicle(ped)
            if Config.Functions.CheckDead() then
                nikon = false
            end
        end
        Wait(1000)
	end
end)