local Astal = require("astal")
local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3").Widget

local Tray  = Astal.require("AstalTray")
local bind = Astal.bind
local Variable = Astal.Variable

return function()
    local tray = Tray.get_default()
    
    tray_button = bind(tray, "items"):as(function(items)
    local traybox = App:get_window("TrayBox")
        if #items > 0 then
            return Widget.Button({
                class_name = "button-tray",
                on_click_release = function(_, event)
                    if event.button == "PRIMARY" then
                        if traybox then
                            if not traybox:get_visible() then
                                traybox:show()
                            else
                                traybox:hide()
                            end
                        end
                    end
                end,
                
                Widget.Label({
                    label = #items
                })
            })
        else
            if traybox then
                traybox:hide()
            end
            
            return nil
        end
    end)

    return tray_button
end
