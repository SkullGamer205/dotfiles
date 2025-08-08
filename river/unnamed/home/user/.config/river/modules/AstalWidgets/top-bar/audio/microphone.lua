local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Wp = astal.require("AstalWp")

return function()
    local WpAudio = Wp.get_default()
    local microphone = WpAudio:get_default_microphone()
    local microphone_visibility = Variable()

    local microphone_icon = Widget.Icon({
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
            Widget.Revealer({
                reveal_child = bind(microphone_visibility),
                transition_type = "SLIDE_LEFT",
                microphone_label,
            }),
            microphone_icon,
        })
    })
end

