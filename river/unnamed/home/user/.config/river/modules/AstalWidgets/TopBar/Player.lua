local astal = require("astal")
local App = require("astal.gtk3").App
local Widget = require("astal.gtk3.widget")
local bind = astal.bind
local Mpris = astal.require("AstalMpris")
local map = require("lib").map
local Variable = astal.Variable


return function()
	local player = Mpris.Player.new("mpd")
        local player_visibility = Variable()

            return Widget.EventBox({
                on_hover = function()
                    player_visibility:set(true)
                end,
                on_hover_lost = function()
                    player_visibility:set(false)
                end,

                Widget.Box({
                    class_name = "Media",
		    visible = bind(player, "available"), 
                        Widget.Button({
                            name = "Player",
                            class_name = "player-button",
                            css = "border: 0px",
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
                                Widget.Revealer({
                                    reveal_child = bind(player_visibility),
                                    transition_type = "SLIDE_LEFT",
                                    Widget.Label({
                                        label = bind(player, "metadata"):as(
                                            function()
			    		        return (player.title or "")
                                                    .. " - "
					            .. (player.artist or "")
                                                end
                                            ),
                                        }),
                                    }),
                                Widget.Icon({
                                    icon = "emblem-music-symbolic",
                            
                                }),
                            })
                        })
                    })
                })
            end
