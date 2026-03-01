local astal = require('astal')
local Widget = require('astal.gtk3').Widget
local Network = astal.require("AstalNetwork")
local bind = astal.bind

return function()
    local network = Network.get_default()
    local wifi = {
        wifi = bind(network, "wifi"),
        icon = function(w)
            return Widget.Icon({
                name = "Wi-FiIcon",
                class_name = "icon-wifi",
                icon = bind(w, "icon-name"),
            })
        end
    }

    return Widget.Box({
        name = "Wi-Fi",
        class_name = "box-wifi",
        visible = wifi.wifi:as(function(v) return v ~= nil end),
        wifi.wifi:as(
            function(w)
                return Widget.Box({
                    name = "Wi-FiBox",
                    class_name = "box-wifi",
                    wifi.icon(w),
                })
            end
        ),
    })
end
