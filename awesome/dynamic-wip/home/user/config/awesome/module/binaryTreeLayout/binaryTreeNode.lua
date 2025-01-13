--[[

    A node for the binary tree.
    This containes a majority of the functions and information to manage the client data.

--]]
--------------------------------------------------
local gTable = require "gears.table"

--------------------------------------------------
---@class Node
local M = {
    parent     = nil,
    left       = nil,
    right      = nil,
    data       = nil,
    isVertical = false,
    workarea   = nil,
    split      = 0.5,
    mt         = {},
}
M.__index = M

---Sets the left node. If it exists it will try add to that node instead.
---@param node Node #The node.
---@return Node #Returns the node added.
function M:addLeft(node)
    if self.left then
        return self.left:addLeft(node)
    end

    self.left = node
    node.parent = self
    return node
end

---Sets the right node. If it exists it will try add to that node instead.
---@param node Node #The node.
---@return Node #Returns the node added.
function M:addRight(node)
    if self.right then
        return self.left:addRight(node)
    end

    self.right = node
    node.parent = self
    return node
end

---Attempts to find a Node with the given data. If none can be found nil is returned instead.
---@param data any #The data to be searched for.
---@return Node|nil
function M:find(data)
    if data == self.data then
        return self
    end

    local result = (self.left and self.left:find(data)) or (self.right and self.right:find(data))

    return result and result or nil
end

---Creates a new Node object
---@param args Node
---@return Node
function M:new(args)
    args = args or {}

    ---@type Node
    local node = {
        left       = args.left,
        right      = args.right,
        parent     = args.parent,
        data       = args.data,
        isVertical = args.isVertical or false,
        workarea   = args.workarea or { split = 0.5 },
    }
    node.__index = node
    gTable.crush(node, self, true)

    return node
end

--------------------------------------------------
---Metatable call.
---@param ... unknown
---@return Node
function M.mt:__call(...)
    return M:new(...)
end

return setmetatable(M, M.mt)
--------------------------------------------------
---@class Node #The node object for the tree.
---@field parent? Node #The parent node.
---@field left? Node #The left node.
---@field right? Node #The right node.
---@field data? any #The nodes data.
---@field isVertical? boolean #Determines if the node is vertical or not.
---@field workarea? Workarea #Workarea for the node.
---@field split number #Where the split occurs.


---@class Workarea #The workarea the nodes used. Similar to Awesome's workarea but with a gap.
---@field x number #X position.
---@field y number #Y position.
---@field width number #Width.
---@field height number #Height.
---@field gap number #The gap between everything.
