local astal  = require("astal")
local Astal  = require("astal.gtk3").Astal
local Anchor = require("astal.gtk3").Astal.WindowAnchor

local App    = require("astal.gtk3.app")
local Apps   = astal.require("AstalApps")

local Widget = require("astal.gtk3").Widget

local Tray   = astal.require("AstalTray")
local map    = require("lib.common").map
local bind = astal.bind

local Debug = require("lib.debug")

return function(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("TrayBox", "No monitor available")
        return nil
    end

    local tray = Tray.get_default()

    local tray_box = function()
        return Widget.Box({
            name = "box-tray",
            class_name = "box",
            vertical = true,
    
            bind(tray, "items"):as(function(items)
                return map(items, function(item)
                    return Widget.MenuButton({
                        tooltip_markup  = bind(item, "tooltip_markup"),
                        use_popover     = false,
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

    tray_window = function()
        return Widget.Window({
            name = "TrayBox",
            class_name = "tray",
            application = App,
            gdkmonitor = gdkmonitor,
            anchor = Anchor.BOTTOM + Anchor.RIGHT,
            exclusivity = "NORMAL",
            visible = false,
                tray_box()
        })
    end

    return tray_window()
end
