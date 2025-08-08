local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local bind = astal.bind
local Hyprland = astal.require("AstalHyprland")

return function()
	local hypr = Hyprland.get_default()
	local focused = bind(hypr, "focused-client")

	return Widget.Box({
		class_name = "Focused",
		visible = focused,
		focused:as(
			function(client)
				return client
					and Widget.Label({
						label = bind(client, "title"):as(tostring),
					})
			end
		),
	})
end
