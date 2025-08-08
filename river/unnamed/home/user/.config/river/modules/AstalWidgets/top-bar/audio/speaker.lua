local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Wp = astal.require("AstalWp")

return function()
    local WpAudio = Wp.get_default()
    local speaker = WpAudio:get_default_speaker()
    local speaker_visibility = Variable()

    local speaker_icon = Widget.Icon({
        icon = bind(speaker, "volume-icon"),
        css = "margin-left: 4px",
    })

    local speaker_label = Widget.Label({ 
        label = bind(speaker, "volume"):as(
            function(p) return string.format("%.0f%%", tostring(p * 100)) end
        ),
    })

    return Widget.EventBox({
        on_hover = function()
            speaker_visibility:set(true)
        end,

        on_hover_lost = function()
            speaker_visibility:set(false)
        end,
        
        Widget.Box({
            Widget.Revealer({
                reveal_child = bind(speaker_visibility),
                transition_type = "SLIDE_LEFT",
                speaker_label,
            }),
            speaker_icon,
        })
    })
end

