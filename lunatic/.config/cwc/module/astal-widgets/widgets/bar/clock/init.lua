local Astal = require("astal")
local Widget = require("astal.gtk3").Widget
local GLib = Astal.require("GLib")
local Variable = Astal.Variable
local bind = Astal.bind

local function Time(format)
    local time = Variable.new(""):poll(1000, function()
        local success, datetime = pcall (function()
            return GLib.DateTime.new_now_local():format(format)
        end)
        return success and datetime or ""
    end)

    return Widget.Label({
        setup = function(self)
            self:hook(self, "destroy", function()
                time:drop()
            end)
        end,
        label = bind(time),
    })
end

return function()
    return Widget.Box({
        class_name = "box-clock",
        Time("%H\n%M"),
    })
end
