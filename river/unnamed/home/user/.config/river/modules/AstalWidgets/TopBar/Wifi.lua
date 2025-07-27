local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Network = astal.require("AstalNetwork")

return function()
    local network = Network.get_default()
    local wifi = bind(network, "wifi")
    local wifi_visibility = Variable()

    local wifi_icon = function(w)
        return Widget.Icon({
            -- tooltip_text = bind(w, "ssid"):as(tostring),
            name = "Wi-Fi_Icon",
            class_name = "wifi-icon",
            css = "margin-left: 2px",
            icon = bind(w, "icon-name"),
        })
    end

    local wifi_label = function(w)
        return Widget.Label({
            name = "Wi-Fi_Label",
            class_name = "wifi-label",
            label = bind(w, "ssid"):as(tostring),
        })
    end

    return Widget.EventBox({
        name = "Wi-Fi_EventBox",
        class_name = "wifi-eventbox",
        on_hover = function()
            wifi_visibility:set(true)
        end,
        
        on_hover_lost = function()
            wifi_visibility:set(false)
        end,
        
        Widget.Button({
            name = "Wi-Fi_Button",
            class_name = "wifi-btn",
            on_click_release = function(_, event)
                if event.button == "SECONDARY" then
                    os.execute("foot -T \"Network Manager TUI\" -a \"nm-tui\" -e \"nmtui\" &")
                end
            end,

            Widget.Box({
                name = "Wi-Fi",
                class_name = "wifi",
                visible = wifi:as(function(v) return v ~= nil end),
                wifi:as(
                    function(w)
                        return Widget.Box({
                            name = "Wi-Fi_Box",
                            class_name = "wifi-box",
                            Widget.Revealer({
                                reveal_child = bind(wifi_visibility),
                                transition_type = "SLIDE_LEFT",
                                wifi_label(w),
                            }),
                            wifi_icon(w),
                        })
                    end
                ),
            })
        })   
    })
end
