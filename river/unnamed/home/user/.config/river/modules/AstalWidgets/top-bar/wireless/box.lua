local Astal  = require("astal.gtk3")
local App    = Astal.App
local Widget = require("astal.gtk3.widget")

local w_wifi   = require("top-bar.wireless.wifi")
local w_bt     = require("top-bar.wireless.bluetooth")

return function()
    return Widget.EventBox({
        class_name = "ebx-wireless",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("LEFT")
            elseif event.button == "SECONDARY" then
                print("RIGHT")
            end
        end,
        Widget.Box({
            class_name = "box-wireless",
            css = "padding: 0 0.5em 0 0.5em",
        w_wifi(),
        w_bt(),
        })
    })
end
