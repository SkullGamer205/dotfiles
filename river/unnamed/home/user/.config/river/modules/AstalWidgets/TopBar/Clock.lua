local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local bind = astal.bind
local GLib = astal.require("GLib")
local Variable = astal.Variable

local function Time(format)
    local time = Variable(""):poll(1000, function()
        return GLib.DateTime.new_now_local():format(format)
    end)

    return Widget.Label({
		on_destroy = function() time:drop() end,
		label = time(),
	})
end

return function()
    local time_visibility = Variable()
        return Widget.EventBox({
            class_name = "time_eventbox",
            on_hover = function()
                time_visibility:set(true)
            end,

            on_hover_lost = function()
                time_visibility:set(false)
            end,

            Widget.Box({
		class_name = "Time",
                Widget.Revealer({
                    reveal_child = bind(time_visibility),
                    transition_type = "SLIDE_LEFT",
                Time("%Y年%m月%d日 │ ")
                }),
                Time("%H:%M"),
                Widget.Revealer({
                    reveal_child = bind(time_visibility),
                    transition_type = "SLIDE_RIGHT",
                Time(":%S "),
                })
            })
        })
end
