local astal = require("astal")
local App = require("astal.gtk3").App
local Widget = require("astal.gtk3.widget")
local bind = astal.bind
local Mpris = astal.require("AstalMpris")
local map = require("lib").map


return function()
	local player = Mpris.Player.new("mpd")

	return Widget.Button({
            name = "Player",
            class_name = "player-button",
            on_clicked = function()
                local player_popup = App:get_window("MediaPlayerWindow")
                if player_popup then
                    if not player_popup:get_visible() then
                        player_popup:show()
                    else
                        player_popup:hide()
                    end
                end
            end,

            Widget.Box({
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
        })
end
