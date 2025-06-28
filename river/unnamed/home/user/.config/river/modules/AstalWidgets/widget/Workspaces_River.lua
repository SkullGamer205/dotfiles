local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local bind = astal.bind
-- local Hyprland = astal.require("AstalHyprland")
local River = require("lgi").require("AstalRiver")
local map = require("lib").map

return function()
    local river = River.River.get_default()
    for _, o in ipairs(river.outputs) do
        print(o.name)
    end
end
