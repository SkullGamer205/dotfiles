--[[

    Table utility functions.

--]]
--------------------------------------------------
--------------------------------------------------
local M = {}

--#region Copied from another place
-- Original credit goes to https://github.com/EvandroLG/array.lua for providing array util methods. Thanks EvandrolLG.

function M.convertToHash(obj)
    local output = {}

    for i = 1, #obj do
        local value = obj[i]
        output[value] = true
    end

    return output
end

function M.tableDiff(obj1, obj2)
    local output = {}
    local hash = M.convertToHash(obj2)

    for i = 1, #obj1 do
        local value = obj1[i]

        if not hash[value] then table.insert(output, value) end
    end

    return output
end

--#endregion

---Returns the indexes of the differences in two tables.
---@param tbl1 table #First Table.
---@param tbl2 table #Second Table.
---@return table #Collection of index.
function M.tableDiffIndex(tbl1, tbl2)
    local indexes = {}
    local r = {}
    for i, v in ipairs(tbl1) do r[i] = v == tbl2[i] end
    for i, v in ipairs(r) do if not v then table.insert(indexes, i) end end

    return indexes
end

--------------------------------------------------
return M
