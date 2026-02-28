local Astal = require("astal")
local Widget = require("astal.gtk3").Widget
local GLib = Astal.require("GLib")
local Variable = Astal.Variable
local bind = Astal.bind

local function Time(format)
    local time = Variable.new(""):poll(1000, function()
        return GLib.DateTime.new_now_local():format(format)
    end)

    return Widget.Label({
        on_destroy = function() time:drop() end,
        label = bind(time),
    })
end

return function()
    return Widget.Box({
        Time("%H\n%M"),
    })
end
