local astal = require('astal')
local Widget = require('astal.gtk3').Widget
local Bluetooth = astal.require("AstalBluetooth")
local bind = astal.bind
-- local Variable = astal.Variable

return function()
    local bluetooth = Bluetooth.get_default()
    local bt = {
        adapter = bind(bluetooth, "adapter"),
        devices = bind(bluetooth, "devices"),
        icon = function(b)
            return Widget.Icon({
                name = "BluetoothIcon",
                class_name = "icon-bluetooth",
                icon = "bluetooth-active",
            })
        end
    }

    return Widget.Box({
        setup = function(self)
            self:hook(self, "destroy", function()
                bt.adapter:drop()
                bt.devices:drop()
            end)
        end,
        
        name = "Bluetooth",
        class_name = "box-bluetooth",
        bt.adapter:as(
            function(b)
                return Widget.Box({
                    name = "BluetoothIconBox",
                    class_name = "box-icon-bluetooth",
                    bt.icon(b),
                })
            end
        ),
    })
end
