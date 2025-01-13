-------------------------------------------------
-- Notify history for Awesome Window Manager
--
--
--
-- @author SkullGamer205
-- @copyright 2024 SkullGamer205
-------------------------------------------------

local naughty = require("naughty")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gfs = require("gears.filesystem")

local CValues = require("ui.wibar.module.dashboard-widget.cvalues")

local notify_history_widget = wibox({
      widget = {
	 {
	    {
	       {
		  fill_space = false,
		  spacing = dpi(2),
		  layout = wibox.layout.fixed.vertical,		  
	       },
	       widget = wibox.container.margin,
	    },
	    naughty.list.notifications,
	    spacing = dpi(6) * 2,
	    layout = wibox.layout.fixed.horizontal,
	 },
	 margins = dpi(CValues.padding),
	 widget = wibox.container.margin,
      },
      type = "dock",
      screen = screen.primary,
      visible = false,
      ontop = true,
      width = dpi(CValues.max_dpi),
      height = dpi(CValues.max_dpi),
      border_width = dpi(2),
      border_color = beautiful.fg_focus,
})

awful.placement.top_right(notify_history_widget, {
    honor_workarea = true,
    margins = beautiful.useless_gap * 4,
    offset = dpi(CValues.padding * 2),
})

awesome.connect_signal("notify_history_widget::toggle", function()
    notify_history_widget.visible = not notify_history_widget.visible
end)

