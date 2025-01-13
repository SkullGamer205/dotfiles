local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi

local brightness = wibox.widget({
      {
	 {
	    {
	       {
		  id = "profile_pic",
		  image  = beautiful.avatar_icon,
		  resize = true,
		  forced_width = 32,
		  forced_height = 32,
		  widget = wibox.widget.imagebox,
	       },
	       top = dpi(2),
	       bottom = dpi(2),
	       left = dpi(2),
	       right = dpi(2),
	       bg = beautiful.fg_focus,
	       widget = wibox.container.margin,
	    },
	    widget = wibox.container.background,
	    bg = beautiful.bg_urgent,
	 },
	 visible = true,
	 align = "left",
	 valign = "top",
	 bg = beautiful.fg_focus,
	 widget = wibox.container.place,
      },
      nil,
      layout = wibox.layout.align.vertical,
})

return brightness
