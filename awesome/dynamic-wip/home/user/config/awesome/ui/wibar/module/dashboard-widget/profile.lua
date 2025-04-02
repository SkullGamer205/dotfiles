local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi

local logout_popup = require("ui.wibar.module.logout-popup-widget.logout-popup")

local CValues = require("ui.wibar.module.dashboard-widget.cvalues")

local profile = wibox.layout({
      layout  = wibox.layout.manual, 
})

local profile_pic = wibox.widget({
   {
      {
	 {
	    image  = ".face",
	    resize = true,
	    forced_width = dpi(32),
	    forced_height = dpi(32),
	    widget = wibox.widget.imagebox,
	 },
	 top = dpi(2),
	 bottom = dpi(2),
	 left = dpi(2),
	 right = dpi(2),
	 bg = beautiful.fg_focus,
	 widget = wibox.container.margin,
      },
      bg = beautiful.fg_focus,
      widget = wibox.container.background,
   },
   visible = true,
   halign = "left",
   valign = "top",
   bg = beautiful.fg_focus,
   widget = wibox.container.place,
})

local username_string = wibox.widget({
      {
	 {
	    id = "username",
	    text = "@" .. os.getenv("USER"),
	    align = left,
	    widget = wibox.widget.textbox,
	 },
	 fg = beautiful.fg_focus,
	 widget = wibox.container.background,
      },
      visible = true,
      halign = "left",
      valign = "top",
      bg = beautiful.fg_focus,
      widget = wibox.container.place,
})

local hostname_string = wibox.widget({
      {
	 {
	    id = "hostname",
	    text = "@" .. awesome.hostname,
	    align = left,
	    widget = wibox.widget.textbox,
	 },
	 fg = beautiful.fg_focus,
	 widget = wibox.container.background,
      },
      visible = true,
      halign = "left",
      valign = "top",
      bg = beautiful.fg_focus,
      widget = wibox.container.place,
})

local logout = wibox.widget({
      {
	 {
	    image  = beautiful.switch_user_icon,
	    resize = true,
	    forced_width = dpi(32),
	    forced_height = dpi(32),
	    widget = wibox.widget.imagebox,
	    buttons = {
	       awful.button({}, 1, nil, function(s)
		     awesome.emit_signal("dashboard::toggle")
		     logout_popup.launch{
			text_color = beautiful.fg_focus,
			onlock = function() awful.spawn.with_shell("xtrlock-pam") end,
			onreboot = function() awful.spawn.with_shell("loginctl reboot") end ,
			onsuspend = function() awful.spawn.with_shell("loginctl suspend") end ,
			onpoweroff = function() awful.spawn.with_shell("loginctl poweroff") end ,
			phrases = {'晚安，师父！ (⌒▽⌒)☆ ', '你已经走了吗？  	(・・ ) ?', "晚上好！ (⌒‿⌒)", "您是无意中点击了这个吗？ (＠_＠)"},
		     }
	       end),
	    },
	 },
	 fg = beautiful.fg_focus,
	 widget = wibox.container.background,
      },
      visible = true,
      halign = "right",
      valign = "center",
      bg = beautiful.fg_focus,
      widget = wibox.container.place,
})



local user_strings = wibox.layout({
      layout  = wibox.layout.manual, 
})

username_string.point = {x = 2, y = 2}
hostname_string.point = {x = 2, y = 16}

profile_pic.point = {x = dpi(2), y = dpi(2)}
user_strings.point = {x = dpi(profile_pic.point.x) + profile_pic.widget.widget.widget.forced_width + (2 * CValues.padding) , y = dpi(2)}
logout.point = {x = dpi(CValues.max_dpi - logout.widget.widget.forced_width - CValues.padding ), y = dpi(2)}

user_strings:add(username_string)
user_strings:add(hostname_string)

profile:add(profile_pic)
profile:add(user_strings)
profile:add(logout)

return profile
