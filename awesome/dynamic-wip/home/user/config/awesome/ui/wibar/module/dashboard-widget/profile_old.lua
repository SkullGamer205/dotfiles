local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi

local profile = wibox.widget({
      {
	 {
	    {
	       {
		  id = "profile_pic",
		  image  = beautiful.avatar_icon,
		  resize = true,
		  forced_width = 64,
		  forced_height = 64,
		  widget = wibox.widget.imagebox,
	       },
	       top = dpi(2),
	       bottom = dpi(2),
	       left = dpi(2),
	       bg = beautiful.fg_focus,
	       widget = wibox.container.margin,
	    },
	    widget = wibox.container.background,
	    bg = beautiful.fg_focus,
	 },
	 visible = true,
	 align = "left",
	 valign = "top",
	 bg = beautiful.fg_focus,
	 widget = wibox.container.place,
      },
      {
	 {
	    {
	       {
		  {
		     {
			id = "username",
			text = os.getenv("USER"),
			align = left,
			widget = wibox.widget.textbox,
		     },
		     widget = wibox.container.background,
		     fg = beautiful.fg_focus,
		  },
		  visible = true,
		  align = "left",
		  valign = "top",
		  bg = beautiful.fg_focus,
		  widget = wibox.container.place,
	       },
	       layout = wibox.layout.align.horizontal,
	    },
	       nil,
	       {
		  {
		     {
			{
			   id = "hostname",
			   text = awesome.hostname,
			   align = left,
			   widget = wibox.widget.textbox,
			},
			widget = wibox.container.background,
			fg = beautiful.fg_focus,
		     },
		     visible = true,
		     align = "left",
		     valign = "bottom",
		     bg = beautiful.fg_focus,
		     widget = wibox.container.place,
		  },
		  layout = wibox.layout.align.horizontal,
	       },
	       layout = wibox.layout.align.vertical,
	 },
	 top = dpi(6),
	 bottom = dpi(6),
	 left = dpi(6),
	 right = dpi(6),
	 widget = wibox.container.margin,
      },
      nil,
      layout = wibox.layout.align.horizontal,
})

function update_username()
   username = function(self, username)
      local username = io.popen("whoami"):read("*a"):gsub("\n$", "")
      profile:get_children_by_id("username")[1].text = username
   end
end

screen.connect_signal("request::desktop_size", update_username)
screen.connect_signal("raw::output::properties", update_username)

return profile
