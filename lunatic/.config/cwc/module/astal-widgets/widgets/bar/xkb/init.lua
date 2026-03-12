local Astal = require('astal')
local Widget = require('astal.gtk3').Widget
local Variable = Astal.Variable

local bind = Astal.bind

return function()

    local xkb_layout = Variable.new("")
        :poll(500, {"cwctl", "-c", "return string.upper(string.sub(cwc.kbd.get()[1].layout_name, 1, 2))"})

    return Widget.Box({
        class_name = "box-xkb",
        on_destroy = function()
            xkb_layout:drop()
        end,

        Widget.Label({
            label = bind(xkb_layout):as(function(current)
                return current
            end),
        })
    })
end
