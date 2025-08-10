local astal     = require("astal")
local bind      = astal.bind
local Variable  = astal.Variable
local Widget    = require("astal.gtk3.widget")
local Bluetooth = astal.require("AstalBluetooth")

return function()
    local bluetooth = Bluetooth.get_default()
    return Widget.Label({
        label = function()
            for _, d in pairs(bluetooth.devices) do
                print(d.name)
            end
        })
    end
