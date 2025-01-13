--[[

        Lua object to json objects to help with debugging.

--]]
--------------------------------------------------
local setmetatable = setmetatable

--------------------------------------------------
local M = { mt = {} }

---Returns the json string equivilent.
---@param obj any #The object to turn.
---@param pretty? boolean #Should the output be pretty. *default: false*
---@param indent? number #Amount of space given in the indent. *default: 4*
---@param depth? number #How far deep are we in. You can think of this as left offset. *default: 1*
---@param depthLimit? number #How deep to enter the childer objects. *default: 5*
function M.toJson(obj, pretty, indent, depth, depthLimit)
    pretty     = pretty or false
    indent     = (indent or 2) * (pretty and 1 or 0)
    depth      = depth or 1
    depthLimit = depthLimit or 5

    local t = type(obj)

    if t == "table" and depth < depthLimit then
        return M.tblToJson(obj, pretty, indent, depth, depthLimit)
    elseif t == "string" then
        return "\"" .. obj .. "\""
    else
        return tostring(obj)
    end
end

---Returns the json string equivilent.
---Array entires will be set to $Array key.
---@param tbl any #The object to turn.
---@param pretty? boolean #Should the output be pretty. *default: false*
---@param indent? number #Amount of space given in the indent. *default: 4*
---@param depth? number #How far deep are we in. You can think of this as left offset. *default: 1*
---@param depthLimit? number #How deep to enter the childer objects. *default: 5*
function M.tblToJson(tbl, pretty, indent, depth, depthLimit)
    pretty = pretty or false
    indent = (indent or 2) * (pretty and 1 or 0)
    depth  = depth or 1

    local array, hasItem, keys = {}, false, {}

    for k, v in pairs(tbl) do
        if type(k) == "number" then
            table.insert(array, M.toJson(v, pretty, indent, depth + 1, depthLimit))
        else
            hasItem = true
            table.insert(keys, "\"" .. tostring(k) .. "\": " .. M.toJson(v, pretty, indent, depth + 1, depthLimit))
        end
    end

    local prettyStr = pretty and "\n" or ""
    local indentStr = (" "):rep(indent * depth)
    local prefixIndent = (" "):rep(indent * math.max(depth - 1, 0))

    local result = prefixIndent .. "{" .. prettyStr

    if #array > 0 then
        local arrayIndent = (" "):rep(indent * depth * 2)
        result = result .. indentStr .. "$Array: [" .. prettyStr
        result = result .. arrayIndent .. table.concat(array, "," .. prettyStr .. arrayIndent) .. prettyStr
        result = result .. indentStr .. "]"
        if hasItem then
            result = result .. ","
        end
        result = result .. prettyStr
    end

    if #keys > 0 then
        result = result .. indentStr .. table.concat(keys, "," .. prettyStr .. indentStr) .. prettyStr
    end

    return result .. prefixIndent .. "}"
end

--------------------------------------------------
function M.mt:__call(...)
    return M.toJson(...)
end

return setmetatable(M, M.mt)
