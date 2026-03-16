local Astal = require("astal")
local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3").Widget

local Tray  = Astal.require("AstalTray")
local bind = Astal.bind
local Variable = Astal.Variable

return function()
    local tray = Tray.get_default()

    return Widget.Button({
        class_name="button-tray",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                local tray_box = App:get_window("TrayBox")
                if tray_box then
                    if not tray_box:get_visible() then
                        tray_box:show()
                    else
                        tray_box:hide()
                    end
                end
            end
        end,

        Widget.Label({
            label = bind(tray, "items"):as(function(items)
                return #items
            end)
        }),
    })
end
