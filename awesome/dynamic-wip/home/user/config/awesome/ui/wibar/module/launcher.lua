local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require("wibox")

-- Create a launcher widget. Opens the Awesome menu when clicked.
return function()
   return awful.widget.button {
      image   = beautiful.dashboard_icon,
      widget = wibox.widget.imagebox,
      buttons = {
	 awful.button({}, 1, nil, function()
--	       require('ui.menu') MainMenu:toggle()
	       awesome.emit_signal("dashboard::toggle")
	 end),
	 awful.button({}, 3, nil, function()
--	       require('ui.menu') MainMenu:toggle()
	       awesome.emit_signal("notify_history_widget::toggle")
        end),
      }
   }
end
