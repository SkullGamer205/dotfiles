local astal = require('astal')
local Widget = require('astal.gtk3').Widget
local Network = astal.require("AstalNetwork")
local bind = astal.bind

local Variable = astal.Variable

return function()
    local network = Network.get_default()
    local wifi = {
        state = bind(network, "wired"),
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
        visible = bind(wifi.state):as(function(v) return v ~= nil end),
        bind(wifi.state):as(function(w)
            wifi.icon(w)
        end),
        
        setup = function(self)
            self:hook(self, "destroy", function()
                wifi.state:drop()
            end)
        end,

    })
end
