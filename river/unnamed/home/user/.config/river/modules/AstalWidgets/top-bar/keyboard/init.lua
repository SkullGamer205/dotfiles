--[[
    This is RiverWM-Exclusive function,
    and also patch-exclusive.

    For correct working this function a patch
    "0001-river_kbd_patch" must be applied for
    the feature to work.
--]]

local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local GLib = astal.require("GLib")
local Variable = astal.Variable

-- XK_ISO_Next_Group
return function()
    local kbd_layout = Variable(kbd_s):poll(
        1000,
        function()
            local kbd_c = "riverctl keyboard-layout-current | cut -c 1-2"
            local kbd_h = io.popen(kbd_c, 'r')
            local kbd_s = kbd_h:read("*l")
            kbd_h:close()

            return tostring(kbd_s)
        end
    )
    local ico_kbd = Widget.Icon({
        name = "KbdLayout_Icon",
        css = "margin-left: 4px",
        icon = "indicator-keyboard",
    })

    local str_kbd = Widget.Label({
        label = kbd_layout(),
    })
    -- local kbd_layout = io.popen('riverctl keyboard-layout-current | cut -c 1-3')
    return Widget.Box({
        name = "KbdLayout_Box",
        class_name = "box-kbd",
        css = "padding: 0 0.5em 0 0.5em",
        -- css = "margin-left: 4px",
        str_kbd,
        ico_kbd,
    })
end
