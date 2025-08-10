
local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Bluetooth = astal.require("AstalBluetooth")

return function()
    local bluetooth = Bluetooth.get_default()
    local bt_adapter = bind(bluetooth, "adapter")
    local bt_devices = bind(bluetooth, "devices")
    local bt_visibility = Variable()
   
    --[[
    local bt_icon_func = function(b)    
        local is_powered = bind(b, "powered"):as(tostring)
        local is_pairable = bind(b, "is-connected"):as(tostring)
        if string.find(is_powered, 'false') then
            return "bluetooth-disabled-symbolic"
        elseif string.find(is_connected, 'true') then
            return "bluetooth-paired-symbolic"
        elseif string.find(is_powered, 'true') then 
            return "bluetooth-active-symbolic"
        else
            return is_powered
        end
    end
    --]]
    local bt_icon = function(b)
        return Widget.Icon({
            name = "Bluetooth_Icon",
            class_name = "ico-bt",
            icon = "bluetooth-active",
        })
        --[[
        return Widget.Label({
            label = bt_icon_func(b),
        })
        --]]
    end

    local bt_label = function(b)
        return Widget.Label({
            name = "Bluetooth_Label",
            class_name = "str-bt",
            css = "margin-right: 2px",
            label = bind(b, "powered"):as(tostring),
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
                visible = bt_adapter:as(function(v) return v ~= nil end),
                bt_adapter:as(
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
