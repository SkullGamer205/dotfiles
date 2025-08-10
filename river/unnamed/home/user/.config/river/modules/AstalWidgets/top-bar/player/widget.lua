local astal = require("astal")
local Astal = astal.require("Astal", "3.0")
local App = require("astal.gtk3").App
local Anchor = Astal.WindowAnchor
local bind = astal.bind
local map = require("lib.common").map
local Widget = require("astal.gtk3.widget")
local lookup_icon = Astal.Icon.lookup_icon

local Mpris = astal.require("AstalMpris")

local function hide()
    local player_popup = App:get_window("MediaPlayerWindow")
    if player_popup then player_popup:hide() end
end

---@param length integer
local function length_str(length)
	local min = math.floor(length / 60)
	local sec = math.floor(length % 60)

	return string.format("%d:%s%d", min, sec < 10 and "0" or "", sec)
end

local function MediaPlayer(player)
	local title = bind(player, "title"):as(
		function(t) return t or "Без названия" end
	)

	local artist = bind(player, "artist"):as(
		function(a) return a or "Неизвестен" end
	)

	local cover_art = bind(player, "cover-art"):as(
		function(c) return string.format("background-image: url('%s');", c) end
	)

	local player_icon = bind(player, "entry"):as(
		function(e) return "audio-x-generic-symbolic" end
	)

	local position = bind(player, "position"):as(
		function(p) return player.length > 0 and p / player.length or 0 end
	)

	local play_icon = bind(player, "playback-status"):as(
		function(s)
			return s == "Играет" and "media-playback-pause-symbolic"
				or "media-playback-start-symbolic"
		end
	)

	return Widget.Box({
		class_name = "MediaPlayer",
		Widget.Box({
			class_name = "cover-art",
			css = cover_art,
		}),
		Widget.Box({
			vertical = true,
			Widget.Box({
				class_name = "title",
				Widget.Label({
					ellipsize = "END",
					hexpand = true,
					halign = "START",
					label = title,
				}),
				Widget.Icon({
					icon = player_icon,
				}),
			}),
			Widget.Label({
				halign = "START",
				valign = "START",
				vexpand = true,
				wrap = true,
				label = artist,
			}),
			Widget.Slider({
				visible = bind(player, "length"):as(
					function(l) return l > 0 end
				),
				on_dragged = function(event)
					player.position = event.value * player.length
				end,
				value = position,
			}),
			Widget.CenterBox({
				class_name = "actions",
				Widget.Label({
					hexpand = true,
					class_name = "position",
					halign = "START",
					visible = bind(player, "length"):as(
						function(l) return l > 0 end
					),
					label = bind(player, "position"):as(length_str),
				}),
				Widget.Box({
					Widget.Button({
						on_clicked = function() player:previous() end,
						visible = bind(player, "can-go-previous"),
						Widget.Icon({
							icon = "media-skip-backward-symbolic",
						}),
					}),
					Widget.Button({
						on_clicked = function() player:play_pause() end,
						visible = bind(player, "can-control"),
						Widget.Icon({
							icon = play_icon,
						}),
					}),
					Widget.Button({
						on_clicked = function() player:next() end,
						visible = bind(player, "can-go-next"),
						Widget.Icon({
							icon = "media-skip-forward-symbolic",
						}),
					}),
				}),
				Widget.Label({
					class_name = "length",
					hexpand = true,
					halign = "END",
					visible = bind(player, "length"):as(
						function(l) return l > 0 end
					),
					label = bind(player, "length"):as(
						function(l) return l > 0 and length_str(l) or "0:00" end
					),
				}),
			}),
		}),
	})
end

return function()
	local mpris = Mpris.get_default()
        return Widget.Window({
            name = "MediaPlayerWindow",
            application = App,
            monitor = monitor,
            anchor = Anchor.TOP,
            exclusivity = "NORMAL",
            class_name = "MediaPlayerWindow",
            visible = false,
	Widget.Box({
		vertical = true,
                position = left,
		bind(mpris, "players"):as(
			function(players) return map(players, MediaPlayer) end
		),
	})
    })
end
