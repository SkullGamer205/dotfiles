--[[

    Index file.

--]]
--------------------------------------------------
-- As I do not wish to restrict the user in where to place this folder I first get the path of this file.
-- Then use it to reference the other files.
local relPath = (...):match ".*"

--------------------------------------------------
local M = {
    binaryTreeLayout = require(relPath .. ".binaryTreeLayout"),
    binaryTree       = require(relPath .. ".binaryTree"),
    binaryTreeNode   = require(relPath .. ".binaryTreeNode"),
}

return setmetatable(M, {
    __call = function(...)
        return M.binaryTreeLayout(...)
    end
})
