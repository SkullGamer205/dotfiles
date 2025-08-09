local lgi = require("lgi")

local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Bluetooth = astal.require("AstalBluetooth")

return function()
    local bluetooth = Bluetooth.get_default()
    local btb = bind(bluetooth, "adapter")
    local btd = bind(bluetooth, "devices")
    local bt_visibility = Variable()

    local bt_icon = function(b)
        return Widget.Icon({
            -- tooltip_text = bind(w, "ssid"):as(tostring),
            name = "Bluetooth_Icon",
            class_name = "ico-bt",
            icon = "bluetooth-symbolic",

            --[[
            icon = function()
                    local powered = bind(b, "powered")
                    local pairable  = bind(b, "pairable")

                    if powered == true then
                        if pairable == true then
                            return tostring("bluetooth-paired")
                        else
                            return tostring("bluetooth-active")
                        end
                        return tostring("bluetooth-disabled")
                    end
                end
            --]]
        })
    end

    local bt_label = function(b)
        return Widget.Label({
            name = "Bluetooth_Label",
            class_name = "str-bt",
            css = "margin-right: 2px",
            label = bind(b, "name"):as(tostring),
        })
    end

    return Widget.EventBox({
        name = "Bluetooth_EventBox",
        class_name = "ebx-bt",
        on_hover = function()
            bt_visibility:set(true)
        end,
        
        on_hover_lost = function()
            bt_visibility:set(false)
        end,
        
        Widget.EventBox({
            name = "Bluetooth_Button",
            class_name = "ebx-bt",
            on_click_release = function(_, event)
                if event.button == "SECONDARY" then
                    os.execute("foot -T \"Bluetooth TUI\" -a \"bluetuith\" -e \"bluetuith\" &")
                end
            end,

            Widget.Box({
                name = "Bluetooth",
                class_name = "box-bt",
                visible = btb:as(function(v) return v ~= nil end),
                btb:as(
                    function(b)
                        return Widget.Box({
                            name = "WBluetooth_Box",
                            class_name = "box-bt",
                            Widget.Revealer({
                                reveal_child = bind(bt_visibility),
                                transition_type = "SLIDE_LEFT",
                                bt_label(b),
                            }),
                            bt_icon(b),
                        })
                    end
                ),
            })
        })   
    })
end
