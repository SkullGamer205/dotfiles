local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Tray = astal.require("AstalTray")
local Variable = require("astal").Variable
local map = require("lib").map
local bind = astal.bind

--[[
return function()
    local tray = Tray.get_default()
    return Widget.Box({
		class_name = "SysTray",
		bind(tray, "items"):as(function(items)
			return map(items, function(item)
				return Widget.MenuButton({
					tooltip_markup = bind(item, "tooltip_markup"),
					use_popover = false,
					menu_model = bind(item, "menu-model"),
					action_group = bind(item, "action-group"):as(
						function(ag) return { "dbusmenu", ag } end
					),
					Widget.Icon({
						gicon = bind(item, "gicon"),
					}),
				})
			end)
		end),
	})
end
--]]
return function()
	local tray = Tray.get_default()
	local tray_visibility = Variable()

	return Widget.Box({
		class_name = "systray",
		Widget.Button({
			class_name = "reveal-button",
			on_clicked = function()
				tray_visibility:set(not tray_visibility:get())
			end,
			Widget.Icon({
				icon = bind(tray_visibility):as(function(v)
					return v and "arrow-right" or "arrow-left"
				end)
			})
		}),
		Widget.Revealer({
			reveal_child = bind(tray_visibility),
			transition_type = "SLIDE_LEFT",
			Widget.Box({
				bind(tray, "items"):as(function(items)
					return map(items, function(item)
						return Widget.MenuButton({
							class_name = "item",
							tooltip_markup = bind(item, "tooltip_markup"),
							use_popover = false,
							menu_model = bind(item, "menu-model"),
							action_group = bind(item, "action-group"):as(function(ag)
								return { "dbusmenu", ag }
							end),
							Widget.Icon({
								gicon = bind(item, "gicon")
							})
						})
					end)
				end)
			})
		})
	})
end
