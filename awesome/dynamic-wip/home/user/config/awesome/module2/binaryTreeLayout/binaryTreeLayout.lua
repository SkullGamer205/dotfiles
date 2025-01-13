--[[

    Binary Tree Layout.
    The actual AwesomeWM layout object(?).

--]]
--------------------------------------------------
local awful  = require "awful"
local gTable = require "gears.table"
local capi   = { client = client, screen = screen, mouse = mouse, mousegrabber = mousegrabber }

local relPath    = (...):match "(.*).binaryTreeLayout"
---@module "binaryTree"
local binaryTree = require(relPath .. ".binaryTree")
---@module "utils"
local utils      = require(relPath .. ".utils")

--------------------------------------------------
---@class BinaryTreeLayout
local M = {
    name       = "binaryTreeLayout",
    trees      = {},
    isVertical = false,
    split      = 0.5,
    mt         = {},
}

---Updates all the information for the clients based on where they are in the tree.
---@param node Node #Node object.
function M.updateGeometry(node)
    local workarea = node.workarea
    if not workarea then return end

    local isVertical = node.isVertical

    if node.data then
        node.data:geometry {
            x      = workarea.x,
            y      = workarea.y,
            width  = workarea.width,
            height = workarea.height,
        }
    else
        local dir = isVertical and {
            pos  = "y",
            size = "height",
        } or {
            pos  = "x",
            size = "width",
        }

        local split       = utils.clamp(workarea[dir.size] * node.split, 1, workarea[dir.size] - 1)
        local gap         = workarea.gap / 2
        local newWorkarea = gTable.clone(workarea)

        newWorkarea[dir.size] = split
        newWorkarea[dir.size] = utils.clamp(newWorkarea[dir.size] - gap, 1, workarea[dir.size])

        if node.left then
            node.left.workarea = gTable.clone(newWorkarea)
            M.updateGeometry(node.left)
        end

        if node.right then
            newWorkarea[dir.size] = utils.clamp(workarea[dir.size] - split - gap - gap, 1, workarea[dir.size] - 1)
            newWorkarea[dir.pos]  = newWorkarea[dir.pos] + split + gap
            node.right.workarea   = gTable.clone(newWorkarea)
            M.updateGeometry(node.right)
        end
    end
end

---Gets the node adjacent to the starting node by the direction.
---@param startingNode Node #Starting Node
---@param direction string #The direction to get the node from.
---@return Node|nil
function M._getNodeByDirection(startingNode, direction)
    local isVertical = direction == "up" or direction == "down"
    local right = direction == "down" or direction == "right"
    local node = startingNode
    local prevNode

    repeat
        prevNode = node
        node = node.parent
    until not node
        or (right and node.left == prevNode or not right and node.right == prevNode)
        and node.isVertical == isVertical

    return node
end

---Clamps down the value of the split
---@param mouse any #Mouse coords.
---@param workarea Workarea #The workarea for the parent node.
---@param rootWorkarea Workarea #The root or furthest most workarea. Basically screen workarea.
---@param isVertical boolean #Changes if the calculation uses vertical variables.
---@return number
function M.clampSplit(mouse, workarea, rootWorkarea, isVertical)
    local dir = isVertical and {
        pos = "y",
        size = "height",
    } or {
        pos = "x",
        size = "width",
    }

    local amount = utils.clamp(mouse[dir.pos], rootWorkarea[dir.pos], rootWorkarea[dir.size])
    amount = utils.clamp(amount, workarea[dir.pos], workarea[dir.size])

    return utils.clamp(amount / workarea[dir.size], 0, 1)
end

---Generates a tag.
---@param p? any #Layout properties.
---@return string
function M._genTag(p)
    if p then
        return tostring(p.tag or capi.screen[p.screen].selected_tag)
    end
    return tostring(capi.mouse.screen.selected_tag)
end

---Changes the direction for the next split to be vertical.
function M:vertical()
    self.isVertical = true
end

---Changes the direction for the next split to be horizontal.
function M:horizontal()
    self.isVertical = false
end

---Toggles the direction for the next split.
function M:toggle()
    self.isVertical = not self.isVertical
end

---Changes the direction of parent node the current client is on.
---@param c any #The client to use.
---@param isVertical? boolean #Should the node be vertical will just toggle the not specified or not a boolean.
function M:changeDirection(c, isVertical)
    local dir

    if type(isVertical) == "boolean" then
        dir = isVertical
    end

    local tree = self.trees[self._genTag()]

    if not tree then
        return
    end

    local node = tree:find(c).parent

    if not node then
        return
    end

    if dir ~= nil then
        node.isVertical = dir
    else
        node.isVertical = not node.isVertical
    end

    M.updateGeometry(node)
end

---Method used to arrange the clients.
---@param p any
function M.arrange(p)
    local self = M

    local tag = self._genTag(p)
    local tree = self.trees[tag]
    if self.trees[tag] == nil then
        tree = binaryTree()

        ---@type Workarea
        tree.root.workarea = gTable.clone(p.workarea)
        tree.root.workarea.gap = p.useless_gap or 0
        tree.root.split = self.split or 0.5

        self.trees[tag] = tree
    end

    local changed = #p.clients - (#tree.clients or 0)
    if changed ~= 0 then
        local prevFocus = awful.client.focus.history.get(p.screen, 1)
        local difference = utils.table.tableDiff(p.clients, tree.clients)

        if changed > 0 then

            local baseNode = prevFocus and tree:find(prevFocus) or tree.root


            for _, newClient in ipairs(difference) do
                if baseNode.data then
                    local leftClient = baseNode.data

                    baseNode.data = nil
                    baseNode.isVertical = self.isVertical

                    baseNode:addLeft(binaryTree.newNode { data = leftClient })
                    baseNode = baseNode:addRight(binaryTree.newNode { data = newClient })
                else
                    baseNode.data = newClient
                end
            end
        else
            difference = utils.table.tableDiff(tree.clients, p.clients)
            for _, c in ipairs(difference) do
                tree:remove(c)
            end
        end
    else
        local difference = utils.table.tableDiffIndex(p.clients, tree.clients)

        if #difference < 1 then
            return
        end

        local firstClient  = p.clients[difference[1]]
        local secondClient = p.clients[difference[2]]

        local firstNode  = tree:find(firstClient)
        local secondNode = tree:find(secondClient)

        if not (firstNode and secondNode) then
            return
        end

        firstNode.data  = secondClient
        secondNode.data = firstClient
    end

    tree.clients = p.clients

    M.updateGeometry(tree.root)
end

---Used to resize the clients
---@param client any #The client to resize
---@param amount number #The amount to resize by. Note this is a % amount not a float.
---@param direction any #Which direction to resize.
function M.resize(client, amount, direction)
    amount = amount / 100

    local self = M
    local tree = self.trees[self._genTag()]

    -- makes the amount negative if is up or left. (Going backwards)
    if direction == "up" or direction == "left" then
        amount = amount * -1
    end

    local client_node = tree.root:find(client)
    local node = self._getNodeByDirection(client_node, direction)

    if node then
        node.split = utils.clamp(node.split + amount, 0, 1)
        self.updateGeometry(node)
    end
end

---Alteres the split amounts with the mouse drag event.
---@param client any #The client
---@param corner string #The corner direction.
function M.mouse_resize_handler(client, corner)
    local self = M
    local tree = self.trees[self._genTag()]

    local vertical   = corner:match "[^_]+" == "top" and "up" or "down"
    local horizontal = corner:match "([^_]+)$"

    local clientNode     = tree.root:find(client)
    local horizontalNode = self._getNodeByDirection(clientNode, horizontal)
    local verticalNode   = self._getNodeByDirection(clientNode, vertical)

    local workarea = tree.root.workarea
    local prev_coords = {}
    capi.mousegrabber.run(
        function(mouse)
            if gTable.hasitem(mouse.buttons, true) then
                prev_coords = { x = mouse.x, y = mouse.y }

                if horizontalNode then
                    horizontalNode.split = self.clampSplit(mouse, horizontalNode.workarea, workarea, false)
                    self.updateGeometry(horizontalNode)
                end

                if verticalNode then
                    verticalNode.split = self.clampSplit(mouse, verticalNode.workarea, workarea, true)
                    self.updateGeometry(verticalNode)
                end

                return true
            end

            return prev_coords.x == mouse.x and prev_coords.y == mouse.y
        end,
        "cross"
    )
end

---Creates a new Binary Tree Layout instance.
---@param args any
---@return BinaryTreeLayout
function M:new(args)
    args = args or {}

    ---@type BinaryTreeLayout
    local layout = {
        name       = args.name or self.name,
        trees      = args.trees or {},
        isVertical = args.isVertical or false,
    }
    gTable.crush(layout, M, true)

    return self
end

--------------------------------------------------
---Metatable call.
---@param ... unknown
---@return BinaryTreeLayout
function M.mt:__call(...)
    return M:new(...)
end

return setmetatable(M, M.mt)
--------------------------------------------------
---@class BinaryTreeLayout #The layout class.
---@field trees table<string, Tree> #Collection of trees.
---@field name string #The name of that will be told to AwesomeWM layout system.
---@field isVertical boolean #Controls if the next node will be vertical or not.
---@field split number #Default split amount.
