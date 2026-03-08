local astal = require('astal')
local Widget = require('astal.gtk3').Widget
local GLib = astal.require('GLib')
local Variable = astal.Variable

return function()
    return Widget.Box({
        class_name = "box-xkb",
        Widget.Label({
            label = "EN",
        })
    })
end
