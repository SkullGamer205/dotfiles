local Astal     = require("astal")
local App       = require("astal.gtk3.app")
local Widget    = require("astal.gtk3").Widget
local Variable  = Astal.Variable

local Tray      = Astal.require("AstalTray")
local bind      = Astal.bind

local Debug = require("lib.debug")

return function(gdkmonitor)
    local current_window = nil
    local window_visible = Variable(false)

    local function toggle_window(gdkmonitor)
        if window_visible:get() and current_window then
            current_window:hide()
            window_visible:set(false)
        else
            if not current_window then
                local CurrentWindow = require("windows.tray")
                current_window = CurrentWindow.new(gdkmonitor)
            end
            if current_window then
                current_window:show()
            end
            window_visible:set(true)
        end
    end

    local tray = Tray.get_default()
    
    tray_button = bind(tray, "items"):as(function(items)
    local traybox = App:get_window("TrayBox")
        if #items > 0 then
            return Widget.Button({
                class_name = "button-tray",
                on_click_release = function(_, event)
                    if event.button == "PRIMARY" then
                        toggle_window(gdkmonitor)
                    end
                end,
                
                Widget.Label({
                    label = #items
                }),

                on_destroy = function()
                    traybox:destroy()
                end
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
