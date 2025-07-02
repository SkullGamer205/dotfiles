local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local bind = astal.bind
local Mpris = astal.require("AstalMpris")
local map = require("lib").map


return function()
	local player = Mpris.Player.new("mpd")

	return Widget.Box({
		class_name = "Media",
		visible = bind(player, "available"),
		Widget.Box({
			class_name = "Cover",
			valign = "CENTER",
			css = bind(player, "cover-art"):as(
				function(cover)
					return "background-image: url('" .. (cover or "") .. "');"
				end
			),
		}),
		Widget.Label({
			label = bind(player, "metadata"):as(
				function()
					return (player.title or "")
						.. " - "
						.. (player.artist or "")
				end
			),
		}),
	})
end
