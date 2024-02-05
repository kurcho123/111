local currentResourceName = GetCurrentResourceName()

if not IsDuplicityVersion() then
    local lastInteraction = 0

    function CanInteract()
        if lastInteraction + 500 > GetGameTimer() then
            return false
        end
        
        lastInteraction = GetGameTimer()
        return true
    end
end

function debugPrint(...)
    if not Config.DebugPrint then
        return
    end

    local args = { ... }

    local appendStr = ''
    for _, v in ipairs(args) do
        appendStr = appendStr .. ' ' .. tostring(v)
    end

    local msgTemplate = '^3[%s]^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, appendStr)
    print(finalMsg)
end

--- This will print the table in JSON like format to the console.
---@param tbl any The table to print.
function debugTable(tbl)
    if not Config.DebugPrint then
        return
    end

    if type(tbl) ~= "table" then
        debugPrint("Invalid input. Expected a table.")
        return
    end

    local function printTableHelper(tbl, indent)
        indent = indent or 0
        local indentStr = string.rep("  ", indent)

        for key, value in pairs(tbl) do
            if type(value) == "table" then
                print(indentStr .. key .. " = {")
                printTableHelper(value, indent + 1)
                print(indentStr .. "}")
            else
                print(indentStr .. key .. " = " .. tostring(value))
            end
        end
    end

    printTableHelper(tbl)
end

function IntToBool(value)
    return value == 1
end