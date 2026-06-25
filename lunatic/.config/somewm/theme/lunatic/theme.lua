---------------------------
-- Default awesome theme --
---------------------------

-- Libs

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gears = require('gears')
local gfs = gears.filesystem
local themes_path = string.match(gfs.get_configuration_dir(), '^(/?.-)/*$') .. '/theme/lunatic/'
-- local themes_path = gfs.get_themes_dir()

local theme = {}


-- Font
theme.font_name     = 'Roboto'
theme.font_size     = 10
theme.font          = theme.font_name .. ' ' .. theme.font_size


-- Colors

theme.palette = {
    background      = '#1d1f21',
    foreground      = '#c5c8c6',
    
    black           = '#1d1f21',
    red             = '#cc6666',
    green           = '#b5bd68',
    yellow          = '#f0c674',
    blue            = '#81a2b5',
    magenta         = '#b294bb',
    cyan            = '#8abeb7',
    white           = '#c5c8c6',

    bright_black    = '#373b41',
    bright_red      = '#d54e53',
    bright_green    = '#b9ca4a',
    bright_yellow   = '#e7c547',
    bright_blue     = '#7aa6da',
    bright_magenta  = '#c397d8',
    bright_cyan     = '#70c0b1',
    bright_white    = '#eaeaea',
}

-- Background
theme.bg_normal             = theme.palette.background
theme.bg_focus              = theme.palette.magenta
theme.bg_urgent             = theme.palette.red
theme.bg_minimize           = theme.palette.bright_black
theme.bg_systray            = theme.bg_normal

-- Foreground
theme.fg_normal             = theme.palette.foreground
theme.fg_focus              = theme.palette.background
theme.fg_urgent             = theme.palette.background
theme.fg_minimize           = theme.palette.background

-- Borders
theme.useless_gap           = dpi(4)
theme.border_width          = dpi(2)
theme.border_color_normal   = theme.palette.background
theme.border_color_active   = theme.palette.foreground
theme.border_color_marked   = theme.palette.yellow

-- Taglist
theme.taglist_bg_focus      = '#444444'
theme.taglist_fg_focus      = theme.palette.magenta

-- Menu
theme.menu_height = dpi(16)
theme.menu_width = dpi(128)
theme.menu_submenu_icon = themes_path .. "default/submenu.png"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Or disable them
theme.taglist_squares_sel   = nil
theme.taglist_squares_unsel = nil
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. "titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "titlebar/maximized_focus_active.png"

theme.wallpaper                                 = themes_path .. "background.png"

-- You can use your own layout icons like this:
theme.layout_carousel                           = themes_path .. "layouts/carousel.svg"
theme.layout_fairh                              = themes_path .. "layouts/fairhw.png"
theme.layout_fairv                              = themes_path .. "layouts/fairvw.png"
theme.layout_floating                           = themes_path .. "layouts/floatingw.png"
theme.layout_magnifier                          = themes_path .. "layouts/magnifierw.png"
theme.layout_max                                = themes_path .. "layouts/maxw.png"
theme.layout_fullscreen                         = themes_path .. "layouts/fullscreenw.png"
theme.layout_tilebottom                         = themes_path .. "layouts/tilebottomw.png"
theme.layout_tileleft                           = themes_path .. "layouts/tileleftw.png"
theme.layout_tile                               = themes_path .. "layouts/tilew.png"
theme.layout_tiletop                            = themes_path .. "layouts/tiletopw.png"
theme.layout_spiral                             = themes_path .. "layouts/spiralw.png"
theme.layout_dwindle                            = themes_path .. "layouts/dwindlew.png"
theme.layout_cornernw                           = themes_path .. "layouts/cornernww.png"
theme.layout_cornerne                           = themes_path .. "layouts/cornernew.png"
theme.layout_cornersw                           = themes_path .. "layouts/cornersww.png"
theme.layout_cornerse                           = themes_path .. "layouts/cornersew.png"

-- Launcher
theme.launcher_icon                             = themes_path .. 'icons/search.svg'

-- Power
theme.power_shutdown                            = themes_path .. 'icons/system-shutdown.svg'
theme.power_reboot                              = themes_path .. 'icons/system-reboot.svg'
theme.power_suspend                             = themes_path .. 'icons/system-suspend.svg'
theme.power_logout                              = themes_path .. 'icons/system-log-out.svg'
theme.power_lockscreen                          = themes_path .. 'icons/system-lock-screen.svg'
theme.power_hibernate                           = themes_path .. 'icons/system-hibernate.svg'

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Colloid-Dark'

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
  rnotification.append_rule({
    rule = { urgency = "critical" },
    properties = { bg = theme.palette.red, fg = theme.palette.foreground },
  })
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
