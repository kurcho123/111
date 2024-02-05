local calledEmployees = {}

local function GetCompany(company)
    for i = 1, #Config.Companies.Services do
        local jobData = Config.Companies.Services[i]
        if jobData.job == company then
            return jobData
        end
    end
end

RegisterNUICallback('companies:get-company', function(_, cb)
    local jobDetails = GetCompanyData()
    cb(jobDetails)
end)

-- * Get all companies with their data.
RegisterNUICallback('companies:get', function(_, cb)
    -- * Get companies along with `open` status.
    local companies = lib.callback.await('yflip-phone:server:companies:get', false)
    cb(companies)
end)

local function EnrichCompanyData(conversations)
    for i = 1, #conversations do
        local conversation = conversations[i]

        local jobData = GetCompany(conversation.company)
        if jobData then
            conversation.company = {
                icon = jobData.icon,
                name = jobData.name,
                job = jobData.job
            }
        end
    end

    return conversations
end

local function shuffleTable(t)
    local n = #t
    while n > 1 do
        local k = math.random(n)
        t[n], t[k] = t[k], t[n]
        n = n - 1
    end
end

function CleanupOnAnsweredCall()
    for i = 1, #calledEmployees do
        local employee = calledEmployees[i]

        if employee.phoneNumber ~= PhoneData.CallData?.TargetData?.number then
            TriggerServerEvent('yflip-phone:server:companies:cancel-call', employee.source)
        end
    end

    calledEmployees = {}
end

RegisterNuiCallback('companies:cancel-call', function(_, cb)
    debugPrint('Companies: Canceling call.')

    cb({})

    CleanupOnAnsweredCall()
end)

RegisterNUICallback('companies:call', function(job, cb)
    debugPrint('Companies: Trying to call company - ', job)

    local employees = GetCompanyEmployees(job)

    if not employees or #employees == 0 then
        debugPrint('Companies: No employees found for job - ', job)
        cb({ success = false })
        return
    end

    shuffleTable(employees)

    local numEmployeesToSelect = math.min(#employees, Config.Companies.MaxEmployeesToCall)
    local selectedEmployees = {}
    for i = 1, numEmployeesToSelect do
        table.insert(selectedEmployees, employees[i])
    end

    cb({ success = true })

    for _, emp in pairs(selectedEmployees) do
        local phoneNumber = lib.callback.await('yflip-phone:server:get-phone-number-by-citizen-id', false, emp.playerId)
        if not phoneNumber then
            goto continue
        end

        local isCalled = lib.callback.await('yflip-phone:server:companies:call-employee', false, phoneNumber, emp.source,
            Device.number)
        if isCalled then
            debugPrint('Companies: Employee called with phone number', phoneNumber, 'and source', emp.source)
            calledEmployees[#calledEmployees + 1] = {
                phoneNumber = phoneNumber,
                source = emp.source
            }
        end

        ::continue::
    end
end)

RegisterNUICallback('companies:has-company-messages', function(_, cb)
    local job = PlayerData.job?.name
    local jobData = {}
    for i = 1, #Config.Companies.Services do
        local service = Config.Companies.Services[i]
        if service.job == job then
            jobData = service
            goto continue
        end
    end

    ::continue::

    cb(jobData?.canMessage)
end)

RegisterNUICallback('companies:send-message', function(messageData, cb)
    local result = lib.callback.await('yflip-phone:server:companies:send-message', false, messageData,
        CurrentPhoneImei)

    if result then
        cb({ messageId = result?.messageId, channelId = result?.channelId, success = true })
    else
        cb({ success = false })
    end
end)

-- * Get recent conversations.
RegisterNUICallback('companies:get-company-conversations', function(page, cb)
    local conversationsResult = lib.callback.await('yflip-phone:server:companies:get-company-conversations', false,
        PlayerData.job?.name, page)

    conversationsResult.job = PlayerData.job?.name

    cb(conversationsResult)
end)

-- * Get recent conversations.
RegisterNUICallback('companies:get-user-conversations', function(page, cb)
    local conversationsResult = lib.callback.await('yflip-phone:server:companies:get-user-conversations', false,
        CurrentPhoneImei, page)

    local enhancedData = EnrichCompanyData(conversationsResult.conversations)

    conversationsResult.job = PlayerData.job?.name
    conversationsResult.conversations = enhancedData

    cb(conversationsResult)
end)

-- * Get conversation between user and company.
RegisterNUICallback('companies:get-conversation', function(company, cb)
    local result = lib.callback.await('yflip-phone:server:companies:get-conversation', false, company, CurrentPhoneImei)

    cb(result)
end)

-- * Get conversation by channel id.
RegisterNUICallback('companies:get-conversation-by-channelId', function(data, cb)
    local result = lib.callback.await('yflip-phone:server:companies:get-conversation-by-channelId', false, data)

    cb(result)
end)

RegisterNUICallback('companies:employee:toggle-duty', function(_, cb)
    local company = GetCompany(PlayerData.job.name)

    if ToggleDuty and company.management.duty then
        local dutyStatus = ToggleDuty()

        cb({
            duty = dutyStatus
        })
    end
end)

RegisterNUICallback('companies:employee:get-duty-status', function(_, cb)
    cb(GetDutyStatus())
end)

RegisterNUICallback('companies:boss:deposit', function(amount, cb)
    local company = GetCompany(PlayerData.job.name)
    local currentbalance = 0
    local transactionStatus = false

    if DepositMoney and company.management.deposit then
        
        transactionStatus = DepositMoney(amount, cb)

        if Config.Framework == "qb" and Config.Companies.Banking == "qb-banking" then
            currentbalance = lib.callback.await('yflip-phone:server:banking:get-balance')
        elseif Config.Companies.Banking == "legacy" then
            currentbalance = GetLegacyAccountFunds()
        end

        if Config.Framework == "qb" then
            local timer = GetGameTimer() + 1500
            while GetGameTimer() < timer do
                Wait(100)
                exports["qb-menu"]:closeMenu()
            end
        end
    end

    if transactionStatus then
        cb(currentbalance + amount)
    else
        cb(currentbalance)
    end
end)

RegisterNUICallback('companies:boss:withdraw', function(amount, cb)
    local company = GetCompany(PlayerData.job.name)
    local currentbalance = 0
    local transactionStatus = false

    if WithdrawMoney and company.management.withdraw then
        transactionStatus = WithdrawMoney(amount, cb)

        if Config.Framework == "qb" and Config.Companies.Banking == "qb-banking" then
            currentbalance = lib.callback.await('yflip-phone:server:banking:get-balance')
        elseif Config.Companies.Banking == "legacy" then
            currentbalance = GetLegacyAccountFunds()
        end

        if Config.Framework == "qb" then
            local timer = GetGameTimer() + 1500
            while GetGameTimer() < timer do
                Wait(100)
                exports["qb-menu"]:closeMenu()
            end
        end
    end

    if transactionStatus then
        cb(currentbalance - amount)
    else
        cb(currentbalance)
    end
end)

RegisterNUICallback('companies:boss:hire', function(data, cb)
    local company = GetCompany(PlayerData.job.name)

    if HireEmployee and company.management.hire then
        HireEmployee(data.player, cb)

        if Config.Framework == "qb" then
            local timer = GetGameTimer() + 250
            while GetGameTimer() < timer do
                Wait(100)
                exports["qb-menu"]:closeMenu()
            end
        end
    end
end)

RegisterNUICallback('companies:boss:get-closest-players', function(_, cb)
    local Candidates = {}

    local Ped = PlayerPedId()
    local location = GetEntityCoords(Ped)

    local players = lib.getNearbyPlayers(location, 5)
    for i = 1, #players do
        local player = players[i]

        if player then
            local playerId = GetPlayerServerId(player.id)

            local playerData = lib.callback.await('yflip-phone:server:companies:get-player-data', false, playerId)

            Candidates[#Candidates + 1] = playerData
        end
    end

    cb(Candidates)
end)

RegisterNUICallback('companies:boss:fire', function(id, cb)
    local company = GetCompany(PlayerData.job.name)

    if FireEmployee and company.management.fire then
        FireEmployee(id, cb)

        if Config.Framework == "qb" then
            local timer = GetGameTimer() + 250
            while GetGameTimer() < timer do
                Wait(100)
                exports["qb-menu"]:closeMenu()
            end
        end
    end
end)

RegisterNUICallback('companies:boss:set-grade', function(data, cb)
    local company = GetCompany(PlayerData.job.name)

    if SetGrade and company.management.promote then
        SetGrade(data.employeeId, data.grade, cb)

        if Config.Framework == "qb" then
            local timer = GetGameTimer() + 250
            while GetGameTimer() < timer do
                Wait(100)
                exports["qb-menu"]:closeMenu()
            end
        end
    end
end)

RegisterNetEvent('yflip-phone:client:companies:update-conversation', function(message)
    SendUIAction('companies:update-conversation', message)
end)

RegisterNetEvent('yflip-phone:client:companies:get-employee-called', function(callerNumber)
    SendUIAction('companies:get-employee-called', { callerNumber = callerNumber })
end)

RegisterNetEvent('yflip-phone:client:companies:cancel-call', function()
    SendUIAction('s-cancel-call')
end)
