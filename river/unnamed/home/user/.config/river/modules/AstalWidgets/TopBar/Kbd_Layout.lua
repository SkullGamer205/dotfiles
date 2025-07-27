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
    -- local kbd_layout = io.popen('riverctl keyboard-layout-current | cut -c 1-3')
	return Widget.Box({
            name = "KbdLayout_Box",
            class_name = "kbd-layout-box",
            css = "margin-left: 4px",
            Widget.Icon({
                name = "KbdLayout_Icon",
                class_name = "kbd-layout-icon",
                css = "margin-right: 4px",
                icon = "indicator-keyboard",
            }),
            Widget.Label({
                name = "KbdLayout_Label",
	        class_name = "kbd-layout-Label",
		label = kbd_layout(),
	    }),
        })
end
