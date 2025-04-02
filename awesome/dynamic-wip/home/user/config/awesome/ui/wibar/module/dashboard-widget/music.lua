local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local gfs = require("gears.filesystem")
local icons_dir = gfs.get_configuration_dir() .. "ui/wibar/module/dashboard-widget/icons/"
local naughty = require("naughty")

MPRIS_TRK_NAME = 'bash -c "playerctl metadata xesam:title"'
MPRIS_TRK_ARTST = 'bash -c "playerctl metadata xesam:artist"'
MPRIS_IMG_CMD = 'bash -c "playerctl metadata mpris:artUrl | cut -c 8-255"'

MPRIS_TRK_PRV = 'bash -c "playerctl previous"'
MPRIS_TRK_PLP = 'bash -c "playerctl play-pause"'
MPRIS_TRK_NXT = 'bash -c "playerctl next"'

local CValues = require("ui.wibar.module.dashboard-widget.cvalues")

local music = wibox.layout({
      layout  = wibox.layout.manual, 
})


local music_pic = wibox.widget({
   {
      {
	 {
	    
	    image = MPRIS_IMG_CMD,
	    resize = true,
	    forced_width = dpi(64),
	    forced_height = dpi(64),
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


local track_name = wibox.widget({
      {
	 {
	    {
	       awful.widget.watch(MPRIS_TRK_NAME, 1),
	       layout = wibox.layout.align.horizontal,
	    },
	 top = dpi(0),
	 bottom = dpi(-12),
	 left = dpi(4),
	 right = dpi(2),
	 widget = wibox.container.margin,
	 },
      fg = beautiful.fg_focus,
      widget = wibox.container.background,
      },
      visible = true,
   halign = "left",
   valign = "top",
   bg = beautiful.bg_normal,
   widget = wibox.container.place,
})
    
local track_artist = wibox.widget({
      {
	 {
	    {
	       awful.widget.watch(MPRIS_TRK_ARTST, 1),
	       layout = wibox.layout.align.horizontal,
	    },
	 top = dpi(0),
	 bottom = dpi(0),
	 left = dpi(4),
	 right = dpi(2),
	 widget = wibox.container.margin,
	 },
	 fg = beautiful.c_grnB,
      widget = wibox.container.background,
      },
      visible = true,
   halign = "left",
   valign = "center",
   fg = beautiful.bg_normal,
   widget = wibox.container.place,
})

local track_main_info = wibox.widget({
      track_name,
      track_artist,
      layout = wibox.layout.align.vertical,
}) 

local back_track_btn = wibox.widget({
      {
	 {
	    image  = icons_dir .. "prev.svg",
	    resize = true,
	    forced_width = dpi(24),
	    forced_height = dpi(24),
	    widget = wibox.widget.imagebox,
	    buttons = {
			awful.button({}, 1, nil, function(s) 
				awful.spawn(MPRIS_TRK_PRV)
			end)
	    },
	 },
	 fg = beautiful.bg_normal,
	 widget = wibox.container.background,
      },
      visible = true,
      halign = "left",
      valign = "top",
      widget = wibox.container.place,
})

local play_pause_track_btn = wibox.widget({
      {
	 {
	    image  = icons_dir .. "play.svg",
	    resize = true,
	    forced_width = dpi(24),
	    forced_height = dpi(24),
	    widget = wibox.widget.imagebox,
	    buttons = {
			awful.button({}, 1, nil, function(s) 
				awful.spawn(MPRIS_TRK_PLP)
			end)
	    },
	 },
	 fg = beautiful.bg_normal,
	 widget = wibox.container.background,
      },
      visible = true,
      halign = "left",
      valign = "top",
      widget = wibox.container.place,
})

local next_track_btn = wibox.widget({
      {
	 {
	    image  = icons_dir .. "next.svg",
	    resize = true,
	    forced_width = dpi(24),
	    forced_height = dpi(24),
	    widget = wibox.widget.imagebox,
	    buttons = {
			awful.button({}, 1, nil, function(s) 
				awful.spawn(MPRIS_TRK_NXT)
			end)
	    },
	 },
	 fg = beautiful.bg_normal,
	 widget = wibox.container.background,
      },
      visible = true,
      halign = "left",
      valign = "top",
      widget = wibox.container.place,
})

next_track_btn:connect_signal("mouse::enter", function()
	wibox.widget({
		bg = beautiful.cyan_bright,
		widget = wibox.container.background,
	})
end)
track_main_info.point = {x = music_pic.widget.widget.widget.forced_width + 2 * CValues.padding, y = dpi(CValues.max_dpi - music_pic.widget.widget.widget.forced_height - CValues.padding)}
music_pic.point = {x = dpi(2), y = dpi(CValues.max_dpi - music_pic.widget.widget.widget.forced_height - CValues.padding)}
next_track_btn.point = {x = dpi(CValues.max_dpi - next_track_btn.widget.widget.forced_width), y = dpi(CValues.max_dpi - next_track_btn.widget.widget.forced_width)}
play_pause_track_btn.point = {x = dpi(CValues.max_dpi - play_pause_track_btn.widget.widget.forced_width), y = dpi(CValues.max_dpi - play_pause_track_btn.widget.widget.forced_height * 2)}
back_track_btn.point = {x = dpi(CValues.max_dpi - back_track_btn.widget.widget.forced_width), y = dpi(CValues.max_dpi - back_track_btn.widget.widget.forced_height * 3)}
music:add(music_pic)
music:add(track_main_info)
music:add(back_track_btn)
music:add(play_pause_track_btn)
music:add(next_track_btn)
return music
