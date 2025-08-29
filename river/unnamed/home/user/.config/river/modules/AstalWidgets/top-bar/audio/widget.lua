local astal     = require("astal")
local bind      = astal.bind
local Variable  = astal.Variable
local Astal     = astal.require("Astal", "3.0")
local Anchor    = Astal.WindowAnchor
local Astal3    = require("astal.gtk3")
local App       = Astal3.App
local Widget    = require("astal.gtk3.widget")
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

local current_page = Variable("speaker")

local function AudioWidget(type, name)
    return Widget.Box({
    name = name,
    class_name = "boy_" .. name,
    vertical = true,
        Widget.Box({
            class_name = "box_" .. name,
            Widget.Button({
                css = "font-size: 24px;",
                on_click_release = function()
                    type:set_mute(not type:get_mute())
                end,
                Widget.Icon({
                    icon = bind(type, "volume-icon"),
                })
            }),
            Widget.Label({
                label = bind(type, "description"):as(tostring),
            })
        }),

        Widget.Box({
            css = "min-width: 140px;",
            Widget.Slider({
                hexpand = true,
                on_dragged = function(self)
                    type.volume = self.value
                end,
                value = bind(type, "volume"),
            }),
            Widget.Label({
                label = bind(type, "volume"):as(
                    function(s) return string.format("%.0f%%", tostring(s * 100)) end
                ),
            })
        })
    })
end

local function btn_audio_type(type, name)
    return Widget.Button({
        label = name,
        on_click_release = function(_, event)
            current_page:set(name)
        end,
    })
end

return function()
    local speaker = getSpeaker()
    local micro = getMicro()
    
    local main_widget = Widget.Stack({
        transition_type = "SLIDE_LEFT_RIGHT",
        homogeneous = false,
        AudioWidget(speaker, "speaker"),
        AudioWidget(micro, "micro"),
        shown = bind(current_page)
    })

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
            Widget.Box({
                btn_audio_type(speaker, "speaker"),
                btn_audio_type(micro, "micro"),
            }),
            main_widget,
        })
    })
end
