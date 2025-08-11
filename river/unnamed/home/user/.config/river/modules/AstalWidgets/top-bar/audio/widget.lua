local astal     = require("astal")
local Astal     = astal.require("Astal", "3.0")
local Widget    = require("astal.gtk3.widget")
local App       = require("astal.gtk3").App
local Anchor    = Astal.WindowAnchor
local bind      = astal.bind
local Variable  = astal.Variable
local Wp        = astal.require("AstalWp")

local Debug     = require("lib.debug")

local function getWp()
    local audio = Wp.get_default()
    if not audio then
        Debug.error("Audio", "Unable to get wireplumber")
        return nil
    end
    return audio
end

local function getSpeaker()
    local speaker = getWp():get_default_speaker()
    if not speaker then
        Debug.error("Audio", "Unable to get speaker")
        return nil
    end
    return speaker
end

local function getMicro()
    local micro = getWp():get_default_microphone()
    if not micro then
        Debug.error("Audio", "Unable to get microphone")
        return nil
    end
    return micro
end

local function SpeakerWidget()
    local speaker = getSpeaker()

    return Widget.Box({
        class_name = "boy_speaker",
        vertical = true,
        Widget.Box({
            class_name = "box_speaker",
            Widget.Icon({
                css = "font-size: 24px;",
                icon = bind(speaker, "volume-icon"),
            }),
            Widget.Label({
                label = bind(speaker, "description"):as(tostring),
            })
        }),

        Widget.Box({
            css = "min-width: 140px;",
            Widget.Slider({
                hexpand = true,
                on_dragged = function(self)
                    speaker.volume = self.value
                end,
                value = bind(speaker, "volume"),
            }),
            Widget.Label({
                label = bind(speaker, "volume"):as(
                    function(s) return string.format("%.0f%%", tostring(s * 100)) end
                ),
            })
        })
    })

end

local function MicrophoneWidget()
    local micro = getMicro()

    return Widget.Box({
        class_name = "boy_micro",
        vertical = true,
        Widget.Box({
            class_name = "box_micro",
            Widget.Icon({
                css = "font-size: 24px;",
                icon = bind(micro, "volume-icon"),
            }),
            Widget.Label({
                label = bind(micro, "description"):as(tostring),
            })
        }),

        Widget.Box({
            css = "min-width: 140px;",
            Widget.Slider({
                hexpand = true,
                on_dragged = function(self)
                    micro.volume = self.value
                end,
                value = bind(micro, "volume"),
            }),
            Widget.Label({
                label = bind(micro, "volume"):as(
                    function(s) return string.format("%.0f%%", tostring(s * 100)) end
                ),
            })
        })
    })

end

return function()
    return Widget.Window({
        name = "SoundWindow",
        class_name = "win_sound",
        application = App,
        monitor = monitor,
        exclusivity = "NORMAL",
        anchor = Anchor.TOP + Anchor.RIGHT,
        visible = false,

        Widget.Box({
            class_name = "box_audio",
            vertical = true,
            SpeakerWidget(),
            MicrophoneWidget(),
        })
    })
end
