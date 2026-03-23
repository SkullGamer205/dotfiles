local astal  = require("astal")
local astal3 = require("astal.gtk3")
local Astal  = astal3.Astal
local Widget = astal3.Widget
local Anchor = astal3.Astal.WindowAnchor

local Tray   = astal.require("AstalTray")
local map    = require("lib.common").map
local bind   = astal.bind

local Debug  = require("lib.debug")

local TrayWindow = {}

function TrayWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("TrayBox", "No monitor available")
        return nil
    end

    local tray_window

    local tray = Tray.get_default()

    local function tray_box()
        return Widget.Box({
            name = "box-tray",
            class_name = "subwindow-box",
            vertical = true,
    
            bind(tray, "items"):as(function(items)
                return map(items, function(item)
                    return Widget.MenuButton({
                        use_popover     = false,
                        tooltip_markup  = bind(item, "tooltip_markup"),
                        menu_model      = bind(item, "menu_model"),
                        action_group    = bind(item, "action-group"):as(function(ag)
                            return { "dbusmenu", ag }
                        end),
                        Widget.Icon({
                            gicon       = bind(item, "gicon") 
                        })
                    })
                end)
            end)
        })
    end

    tray_window = Widget.Window({
            -- name = "TrayBox",
            class_name = "subwindow",
            -- application = App,
            gdkmonitor = gdkmonitor,
            anchor = Anchor.BOTTOM + Anchor.RIGHT,
            exclusivity = "NORMAL",
            visible = false,
                tray_box()
        })

    return tray_window
end

return TrayWindow
