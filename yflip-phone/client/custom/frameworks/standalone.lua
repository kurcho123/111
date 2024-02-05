CreateThread(function()
    if Config.Framework ~= "standalone" then
        return
    end

    while not NetworkIsSessionStarted() do
        Wait(500)
    end

    -- * Check if a player has a phone item.
    function HasPhoneItem(phoneImei)
        if not Config.Item.Require then
            return true
        end

        if Config.Item.Unique and phoneImei then
            return HasImeiIdentifier(phoneImei)
        end

        if GetResourceState("ox_inventory") == "started" and Config.Item.Inventory == "ox_inventory" then
            return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
        end

        return true
    end

    -- * Get company data based on the player's job and grade.
    function GetCompanyData(cb)
        cb {}
    end

    -- * Deposit money into the company account.
    function DepositMoney(amount, cb)
        cb(false)
    end

    -- * Withdraw money from the company account.
    function WithdrawMoney(amount, cb)
        cb(false)
    end

    -- * Hire an employee.
    function HireEmployee(source, cb)
        cb(false)
    end

    -- * Fire an employee.
    function FireEmployee(identifier, cb)
        cb(false)
    end

    -- * Promote/demote an employee.
    function SetGrade(identifier, newGrade, cb)
        cb(false)
    end

    -- * Toggle duty status.
    function ToggleDuty()
        return false
    end

    -- * Toggle duty status.
    function ToggleDuty()
        return false
    end
end)
