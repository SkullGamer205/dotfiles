local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Wp = astal.require("AstalWp")

return function()
    local microphone = Wp.get_default().audio.default_microphone
    local microphone_visibility = Variable()

    local microphone_icon = Widget.Icon({
        css = "margin-right: 4px",
        icon = bind(microphone, "volume-icon"),
    })

    local microphone_label = Widget.Label({ 
        css = "margin-right: 4px",
        label = bind(microphone, "volume"):as(
            function(p) return tostring(math.floor(p * 100)) .. "%" end
        ),
    })

    return Widget.EventBox({
        on_hover = function()
            microphone_visibility:set(true)
        end,

        on_hover_lost = function()
            microphone_visibility:set(false)
        end,
        
        Widget.Box({
            microphone_icon,
            Widget.Revealer({
                reveal_child = bind(microphone_visibility),
                transition_type = "SLIDE_RIGHT",
                microphone_label,
            }),
        })
    })
end

