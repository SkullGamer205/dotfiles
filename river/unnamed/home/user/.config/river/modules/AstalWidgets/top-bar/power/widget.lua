local astal     = require("astal")
local Astal     = astal.require("Astal", "3.0")
local App       = require("astal.gtk3").App
local Widget    = require("astal.gtk3.widget")
local bind      = astal.bind
local Variable  = astal.Variable
local Anchor    = Astal.WindowAnchor
local Debug     = require("lib.debug")

--[[
Icons:
    [1,1] shutdown    -> system-shutdown-symbolic
    [2,1] reboot      -> system-reboot-symbolic
    [2,1] lock        -> system-lock-screen-symbolic
    [2,2] log-out     -> system-log-out-symbolic
    [3,1] hibernate   -> system-hibernate-symbolic
    [3,2] sleep       -> sleep
--]]

return function()
    return Widget.Window({
        name = "PowerWindow",
        class_name = "win_power",
        application = App,
        monitor = monitor,
        exclusivity = "NORMAL",
        anchor = Anchor.TOP + Anchor.BOTTOM + Anchor.LEFT + Anchor.RIGHT,
        visible = false,
        Widget.Box({})
    })
end
