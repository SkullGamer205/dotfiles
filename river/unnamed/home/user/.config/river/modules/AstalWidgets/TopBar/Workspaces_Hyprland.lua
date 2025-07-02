local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local bind = astal.bind
local Hyprland = astal.require("AstalHyprland")
local map = require("lib").map

return function()
	local hypr = Hyprland.get_default()

	return Widget.Box({
		class_name = "Workspaces",
		bind(hypr, "workspaces"):as(function(wss)
			table.sort(wss, function(a, b) return a.id < b.id end)

			return map(wss, function(ws)
				if not (ws.id >= -99 and ws.id <= -2) then -- filter out special workspaces
					return Widget.Button({
						class_name = bind(hypr, "focused-workspace"):as(
							function(fw) return fw == ws and "focused" or "" end
						),
						on_clicked = function() ws:focus() end,
						label = bind(ws, "id"):as(
							function(v)
								return type(v) == "number"
										and string.format("%.0f", v)
									or v
							end
						),
					})
				end
			end)
		end),
	})
end
