--###################################################################################################################
--###################################################################################################################
--###                                                                                                             ###
--###                                                                                                             ###
--###    MMP"""""""MM                                                           M""MMM""MMM""M M"""""`'"""`YM     ###
--###    M' .mmmm  MM                                                           M  MMM  MMM  M M  mm.  mm.  M     ###
--###    M         `M dP  dP  dP .d8888b. .d8888b. .d8888b. 88d8b.d8b. .d8888b. M  MMP  MMP  M M  MMM  MMM  M     ###
--###    M  MMMMM  MM 88  88  88 88ooood8 Y8ooooo. 88'  `88 88'`88'`88 88ooood8 M  MM'  MM' .M M  MMM  MMM  M     ###
--###    M  MMMMM  MM 88.88b.88' 88.  ...       88 88.  .88 88  88  88 88.  ... M  `' . '' .MM M  MMM  MMM  M     ###
--###    M  MMMMM  MM 8888P Y8P  `88888P' `88888P' `88888P' dP  dP  dP `88888P' M  `' . '' .MM M  MMM  MMM  M     ###
--###    MMMMMMMMMMMM                                                           MMMMMMMMMMMMMM MMMMMMMMMMMMMM     ###
--###                                                                                                             ###
--###                                                                       Автор конфигурации: SkullGamer205     ###
--###################################################################################################################
--###################################################################################################################
--
--    \ \        /_) |                
--     \ \  \   /  | __ \   _` |  __| 
--      \ \  \ /   | |   | (   | |    
--       \_/\_/   _|_.__/ \__,_|_|    
--
local awful = require('awful')
local wibox = require('wibox')
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local beautiful = require("beautiful")

local my_module = require(... .. '.module')

local volume_widget = require(... .. ".module.aww.volume-widget.volume")
local micro_widget = require(... .. ".module.aww.micro-widget.micro")
local net_widgets = require(... .. ".module.net_widgets")
local dashboard  = require(... .. ".module.dashboard-widget")
local notify_history  = require(... .. ".module.dashboard-widget.notify_history")

local modalawesome = require("module.modalawesome")


return function(s)
   s.mypromptbox = awful.widget.prompt() -- Create a promptbox.
   
   -- Create the wibox
    s.wibox1 = awful.popup {
        screen  = s,
        placement = function(c)
           return awful.placement.top_left(c, { margins = 6 })
        end,
        minimum_height = 20,
        maximum_height = 20,
        minimum_width = 20,
        border_width = 2,
        strut = { top = 240, },
        border_color = xrdb.foreground,
        widget   = {
            layout = wibox.layout.fixed.horizontal,
            spacing = 1,
            spacing_widget = wibox.widget.separator,
        { -- Left widgets
	   layout = wibox.layout.fixed.horizontal,
	   my_module.layoutbox(),
	   -- modalawesome.active_mode,
	   -- modalawesome.sequence,
            my_module.taglist(s),
            my_module.tasklist(s),
            s.mypromptbox
            },
        }
    }
    s.wibox2 = awful.popup {
        screen  = s,
        placement = function(c)
           return awful.placement.top_right(c, { margins = 6 })
        end,
        maximum_height = 20,
        minimum_width = 20,
        border_width = 2,
        strut = { top = 240, },
        border_color = xrdb.foreground,
        widget   = {
            layout = wibox.layout.fixed.horizontal,
            spacing = 1,
            spacing_widget = wibox.widget.separator,
        { -- Right widgets
	   layout = wibox.layout.fixed.horizontal,
	   my_module.weather({api_key='f6c43462242d4e7196a144455242210', coordinates = {48.5357, 135.1730}, time_format_12h = false, units = 'C', both_units_widget = true, show_hourly_forecast = true, show_daily_forecast = true, }),
	   wibox.widget({awful.widget.keyboardlayout(), fg = xrdb.foreground, widget = wibox.container.background}), -- Keyboard map indicator and switcher.
	   wibox.widget.systray(),
	   net_widgets.wireless({
		 interfaces  = {"wlan0", "lo", "eth0"},
		 timeout     = 5,
		 skipvpncheck = false,
		 onclick     = "uxterm -e nmtui",
	   }),
	   volume_widget{widget_type = 'icon'},
	   micro_widget{widget_type = 'icon'},
	   my_module.battery(),
	   my_module.clock(), -- Create a textclock widget.
	   my_module.launcher()
            },
        }
    }
      s.wibox1:struts({top = s.wibox1.maximum_height + beautiful.useless_gap})
end

