CreateThread(function()
    if Config.Framework ~= 'qb' then return end

    debugPrint("Phone:QB:Loading Framework")

    local Framework = exports['qb-core']:GetCoreObject()

    while not LocalPlayer.state.isLoggedIn do
        Wait(500)
    end

    debugPrint("Phone:QB:Framework loaded")

    local QBPlayerData = Framework.Functions.GetPlayerData()

    PlayerData = {
        identifier = QBPlayerData.citizenid,
        job = QBPlayerData.job,
        money = QBPlayerData.money
    }

    if LocalPlayer.state.isLoggedIn then
        QBPlayerData = Framework.Functions.GetPlayerData()

        -- * Query yphone_holders to find if there are any phones for the player.
        -- * If there are, set the current phone imei to the first one and load the phone data.
        local phoneImei = lib.callback.await('yflip-phone:server:get-primary-phone', false, PlayerData.identifier)
        if phoneImei then
            debugPrint('Found phone for player: ', PlayerData.identifier, ' with imei: ', phoneImei)

            DataLoaded = false
            LoadPhoneData(phoneImei)

            while not DataLoaded do
                Wait(100)
            end
        else
            debugPrint('No phone found for player: ', PlayerData.identifier)
        end

        if GroupId ~= nil then
            TriggerServerEvent("yflip-phone:server:groups:leave", GroupId)

            CurrentJobStage = "WAITING"
            GroupId = 0

            IsGroupLeader = false

            for i = 1, #GroupBlips do
                RemoveBlip(GroupBlips[i]["blip"])
                GroupBlips[i] = nil
            end
        end
    end

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
        PlayerData.job = jobInfo
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBPlayerData = Framework.Functions.GetPlayerData()

        PlayerData = {
            identifier = QBPlayerData.citizenid,
            job = QBPlayerData.job
        }
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData.identifier = nil
        PlayerData.job = nil
    end)

    -- * Check if a player has a phone item.
    function HasPhoneItem(phoneImei)
        if not Config.Item.Require then
            return true
        end

        if GetResourceState("ox_inventory") == "started" then
            return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
        end

        if Config.Item.Unique and phoneImei then
            return HasImeiIdentifier(phoneImei)
        else
            if Config.Item.Inventory == 'qs-inventory' then
                local result = exports['qs-inventory']:Search(Config.Item.Name)
                return result ~= nil
            end

            return Framework.Functions.HasItem(Config.Item.Name)
        end
    end

    function GetCompanyEmployees(job)
        return lib.callback.await('yflip-phone:server:companies:get-employees-ids', false, job)
    end

    -- * Get company data based on the player's job and grade.
    function GetCompanyData()
        if not PlayerData?.job then
            return nil
        end

        local jobData = {
            job = PlayerData.job.name,
            jobLabel = PlayerData.job.label,
            gradeLevel = PlayerData.job.grade.level,
            gradeLabel = PlayerData.job.grade.name,
            isBoss = PlayerData.job.isboss,
            payment = PlayerData.job.payment,
            duty = PlayerData.job.onduty
        }

        if jobData.isBoss then
            local employeesPromise = promise.new()
            Framework.Functions.TriggerCallback("qb-bossmenu:server:GetEmployees", function(employees)
                for i = 1, #employees do
                    local employee = employees[i]
                    employees[i] = {
                        name = employee.name,
                        id = employee.empSource,

                        gradeLabel = employee.grade.name,
                        grade = employee.grade.level,

                        canInteract = not employee.isboss
                    }
                end
                employeesPromise:resolve(employees)
            end, jobData.job)

            jobData.employees = Citizen.Await(employeesPromise)

            if Config.Companies.Banking == "qb-banking" then
                jobData.balance = lib.callback.await('yflip-phone:server:banking:get-balance')
            elseif Config.Companies.Banking == "legacy" then
                local moneyPromise = promise.new()
                Framework.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(money)
                    moneyPromise:resolve(money)
                end, jobData.job)

                jobData.balance = Citizen.Await(moneyPromise)
            end

            jobData.grades = {}
            for k, v in pairs(Framework.Shared.Jobs[jobData.job].grades) do
                jobData.grades[#jobData.grades + 1] = {
                    label = v.name,
                    grade = tonumber(k)
                }
            end

            table.sort(jobData.grades, function(a, b)
                return a.grade < b.grade
            end)
        end

        return jobData
    end

    -- * Deposit money into the company account.
    function DepositMoney(amount, cb)
        if PlayerData.money["cash"] >= amount then
            SetTimeout(1500, function()
                local data = {
                    accountName = PlayerData.job.name,
                    amount = amount
                }

                if Config.Companies.Banking == "qb-banking" then
                    debugPrint('Using qb-banking')
                    Framework.Functions.TriggerCallback("qb-banking:server:deposit", function(status)

                    end, data)
                elseif Config.Companies.Banking == "legacy" then
                    debugPrint('Using legacy banking')
                    TriggerServerEvent("qb-bossmenu:server:depositMoney", amount)
                end
            end)
            debugPrint('Deposited ' .. amount)
            return true
        else
            debugPrint('Not enough money!')
            return false
        end
    end

    -- * Withdraw money from the company account.
    function WithdrawMoney(amount, cb)
        if amount > 0 then
            SetTimeout(1500, function()
                local data = {
                    accountName = PlayerData.job.name,
                    amount = amount
                }

                if Config.Companies.Banking == "qb-banking" then
                    local currentbalanceQBanking = lib.callback.await('yflip-phone:server:banking:get-balance')

                    if currentbalanceQBanking >= amount then
                        Framework.Functions.TriggerCallback("qb-banking:server:withdraw", function(status)

                        end, data)
                        debugPrint("You got " .. amount .. " cash")
                        return true
                    else
                        debugPrint("The company doesn't have this amount of cash!")
                        return false
                    end
                elseif Config.Companies.Banking == "legacy" then
                    local currentbalanceLegacy = GetLegacyAccountFunds()

                    if currentbalanceLegacy >= amount then
                        TriggerServerEvent("qb-bossmenu:server:withdrawMoney", amount)
                        debugPrint("You got " .. amount .. " cash")
                        return true
                    else
                        debugPrint("The company doesn't have this amount of cash!")
                        return false
                    end
                end
            end)
        else
            debugPrint("Value must be > 0!")
            return false
        end
    end

    -- * Get the company funds.
    function GetLegacyAccountFunds()
        local balancePromise = promise.new()

        Framework.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(money)
            balancePromise:resolve(money)
        end, PlayerData.job)

        local balance = Citizen.Await(balancePromise)

        return balance or 0
    end

    -- * Hire an employee.
    function HireEmployee(source, cb)
        TriggerServerEvent("qb-bossmenu:server:HireEmployee", source)

        cb({ success = true })
    end

    -- * Fire an employee.
    function FireEmployee(source, cb)
        TriggerServerEvent("qb-bossmenu:server:FireEmployee", source)

        cb(true)
    end

    -- * Promote/demote an employee.
    function SetGrade(identifier, newGrade, cb)
        local maxGrade = 0
        for grade, _ in pairs(Framework.Shared.Jobs[PlayerData.job.name].grades) do
            grade = tonumber(grade)

            if grade and grade > maxGrade then
                maxGrade = grade
            end
        end

        if newGrade > maxGrade then
            return cb(false)
        end

        TriggerServerEvent("qb-bossmenu:server:GradeUpdate", {
            cid = identifier,
            grade = newGrade,
            gradename = Framework.Shared.Jobs[PlayerData.job.name].grades[tostring(newGrade)].name
        })
        cb(true)
    end

    -- * Toggle duty status.
    function ToggleDuty()
        local _source = source
        local dutyStatus = lib.callback.await('yflip-phone:server:companies:toggle-duty', false, _source)

        PlayerData.job.onduty = dutyStatus
        return dutyStatus
    end

    -- * Get the player's on duty status.
    function GetDutyStatus()
        return PlayerData.job.onduty
    end

    function CreateFrameworkVehicle(vehicleData, coords)
        vehicleData.mods = json.decode(vehicleData.mods)

        local model = tonumber(vehicleData.hash)

        if not model then
            model = GetHashKey(vehicleData.vehicle)
        end

        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(500)
        end

        local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, 0.0, true, false)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleNumberPlateText(vehicle, vehicleData.plate)

        Framework.Functions.SetVehicleProperties(vehicle, vehicleData.mods)
        TriggerEvent("vehiclekeys:client:SetOwner", Framework.Functions.GetPlate(vehicle))

        if GetResourceState("LegacyFuel") == "started" and vehicleData.fuel then
            exports.LegacyFuel:SetFuel(vehicle, vehicleData.fuel)
        end

        SetModelAsNoLongerNeeded(model)

        return vehicle
    end
end)
