local App = require("astal.gtk3").App
local Widget = require("astal.gtk3.widget")

--[[
return function(text)
    return Widget.Button({
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("Left click")
            elseif event.button == "SECONDARY" then
                os.execute("foot")
            end
        end,
        Widget.Label({
            label = text,
        }),
    })
end
--]]

return function()
	return Widget.Button({
            name = "LauncherButton",
            class_name = "launcher-button",
		on_clicked = function()
			local launcher = App:get_window("Launcher")
			if launcher then
				if not launcher:get_visible() then
					launcher:show()
				else
					launcher:hide()
				end
			end
		end,
		Widget.Icon({
			icon = "search-symbolic"
		}),
	})
end
