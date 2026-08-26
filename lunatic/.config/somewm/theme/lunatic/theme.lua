---------------------------
-- Default awesome theme --
---------------------------

-- Libs

local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi           = xresources.apply_dpi
local gears         = require('gears')
local gfs           = gears.filesystem
local themes_path   = string.match(gfs.get_configuration_dir(), '^(/?.-)/*$') .. '/theme/lunatic/'
-- local themes_path = gfs.get_themes_dir()

local user_config   = require('config.user')

local theme = {}


-- Font
theme.font_name     = user_config.font.name or 'sans'
theme.font_size     = dpi(user_config.font.size) or dpi(8)
theme.font          = theme.font_name .. ' ' .. theme.font_size


-- Colors


theme.palette       = user_config.palette or {
    -- Base24 One-Dark Theme

    -- Base00-07
    base00      = '#282c34', -- [ BG ] Default
    base01      = '#3f4451', -- [ BG ] Lighter
    base02      = '#4f5666', -- [ BG ] Selection
    base03      = '#545862', -- [ BG ] Highlight
    base04      = '#9196a1', -- [ FG ] Dark
    base05      = '#abb2bf', -- [ FG ] Default
    base06      = '#e6e6e6', -- [ FG ] Light
    base07      = '#ffffff', -- [ FG ] Lightest

    -- Base08-0E
    base08      = '#e05561', -- [ RED     ] Normal
    base09      = '#d18f52', -- [ ORANGE  ] Normal
    base0A      = '#42b3c2', -- [ YELLOW  ] Normal
    base0B      = '#4aa5f0', -- [ GREEN   ] Normal
    base0C      = '#c162de', -- [ CYAN    ] Normal
    base0D      = '#4aa5f0', -- [ BLUE    ] Normal
    base0E      = '#c162de', -- [ MAGENTA ] Normal
    base0F      = '#bf4034', -- [ BROWN   ] Normal

    -- Base10-17
    base10      = '#21252b', -- [ BG ]      Darker
    base11      = '#181a1f', -- [ BG ]      Darkest
    base12      = '#ff616e', -- [ RED     ] Bright
    base13      = '#f0a45d', -- [ YELLOW  ] Bright
    base14      = '#a5e075', -- [ GREEN   ] Bright
    base15      = '#4cd1e0', -- [ CYAN    ] Bright
    base16      = '#4dc4ff', -- [ BLUE    ] Bright
    base17      = '#de73ff', -- [ MAGENTA ] Bright
}

theme.colors = {
    background          = theme.palette.base00,
    background_light    = theme.palette.base01,
    background_dark     = theme.palette.base10,


    foreground          = theme.palette.base05,
    foreground_light    = theme.palette.base06,
    foreground_dark     = theme.palette.base14,

    primary             = theme.palette.base0B,

    low                 = theme.palette.base0B,
    low_light           = theme.palette.base14,

    medium              = theme.palette.base0A,
    medium_light        = theme.palette.base13,

    high                = theme.palette.base08,
    high_light          = theme.palette.base12,
}

-- Default gaps & margins
theme.gap_default           = dpi(2)

-- Background
theme.bg_normal             = theme.colors.background
theme.bg_focus              = theme.colors.background_light
theme.bg_urgent             = theme.colors.high
theme.bg_minimize           = theme.colors.background_dark
theme.bg_systray            = theme.bg_normal

-- Foreground
theme.fg_normal             = theme.colors.foreground
theme.fg_focus              = theme.colors.foreground_light
theme.fg_urgent             = theme.colors.high_light
theme.fg_minimize           = theme.colors.background

-- Borders
theme.useless_gap           = theme.gap_default * 2
theme.border_width          = theme.gap_default
theme.border_color_normal   = theme.colors.background_light
theme.border_color_active   = theme.colors.foreground
theme.border_color_marked   = theme.colors.medium
theme.borded_color_urgent   = theme.colors.high

-- Taglist
theme.taglist_bg_empty      = theme.colors.background
theme.taglist_fg_empty      = theme.colors.background_dark

theme.taglist_bg_occupied   = theme.taglist_bg_empty
theme.taglist_fg_occupied   = theme.colors.foreground

-- Dynamic tags. Skip
-- theme.taglist_bg_volatile   =
-- theme.taglist_fg_volatile   =

theme.taglist_bg_focus      = theme.taglist_bg_empty
theme.taglist_fg_focus      = theme.colors.primary

theme.taglist_bg_urgent     = theme.taglist_bg_empty
theme.taglist_fg_urgent     = theme.palette.high

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Or disable them
theme.taglist_squares_sel   = nil
theme.taglist_squares_unsel = nil

-- Menu
theme.menu_height = dpi(theme.font_size) * 2
theme.menu_width  = dpi(theme.font_size) * 12

theme.menu_fg_normal = theme.colors.foreground
theme.menu_bg_normal = theme.colors.background
theme.menu_fg_focus  = theme.bg_normal
theme.menu_bg_focus  = theme.colors.primary

theme.menu_submenu_icon = themes_path .. "icons/launcher/arrow.png"

-- Shadows
theme.shadow_enabled        = true
theme.shadow_radius         = 0
theme.shadow_opacity        = 0.5
theme.shadow_offset_x       = 10
theme.shadow_offset_y       = 10
theme.shadow_clip           = false

-- Disable shadow for panels/wiboxes
theme.shadow_drawin_enabled = false

-- Hotkeys
theme.hotkeys_font              = theme.font
theme.hotkeys_modifiers_fg      = theme.colors.primary
theme.hotkeys_label_fg          = theme.colors.background_dark
theme.hotkeys_description_font  = theme.font
theme.hotkeys_border_width      = theme.border_width
theme.hotkeys_border_color      = theme.colors.primary
theme.hotkeys_group_margin      = theme.gap_default * 10

-- Notification
theme.notification_spacing      = theme.gap_default * 5

-- Wibar
theme.wibar_width               = (theme.font_size * 2) + (theme.gap_default * 3)
theme.wibar_height              = 720

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

theme.wallpaper                                 = themes_path .. "tiled-wallpaper.xpm"

-- You can use your own layout icons like this:
theme.layout_carousel                           = gears.color.recolor_image(themes_path .. "layouts/carousel.svg",theme.fg_normal)
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

-- Notification
theme.notifications_empty_icon                  = themes_path .. "icons/notifications/notifications-empty.png"

-- Music
theme.music_icon                                = themes_path .. "icons/music/music.png"

-- Launcher
theme.launcher_icon                             = themes_path .. 'icons/launcher/find.png'
theme.launcher_exit                             = themes_path .. 'icons/launcher/exit.png'
theme.launcher_all_apps                         = themes_path .. 'icons/launcher/all-apps.png'
theme.launcher_favorites                        = themes_path .. 'icons/launcher/favorites.png'
theme.launcher_style                            = themes_path .. 'icons/launcher/styles.png'

-- Power
theme.power_shutdown                            = themes_path .. 'icons/system-shutdown.svg'
theme.power_reboot                              = themes_path .. 'icons/system-reboot.svg'
theme.power_suspend                             = themes_path .. 'icons/system-suspend.svg'
theme.power_logout                              = themes_path .. 'icons/system-log-out.svg'
theme.power_lockscreen                          = themes_path .. 'icons/system-lock-screen.svg'
theme.power_hibernate                           = themes_path .. 'icons/system-hibernate.svg'

-- Battery
theme.battery_health                            = themes_path .. 'icons/battery/battery-health.png'
theme.battery_loops                             = themes_path .. 'icons/battery/battery-loops.png'
theme.battery_volt                              = themes_path .. 'icons/battery/battery-volt.png'
theme.battery_watt                              = themes_path .. 'icons/battery/battery-watt.png'
theme.battery_full                              = themes_path .. 'icons/battery/battery-full.png'
theme.battery_good                              = themes_path .. 'icons/battery/battery-good.png'
theme.battery_low                               = themes_path .. 'icons/battery/battery-low.png'
theme.battery_full_charging                     = themes_path .. 'icons/battery/battery-full-charging.png'
theme.battery_good_charging                     = themes_path .. 'icons/battery/battery-good-charging.png'
theme.battery_low_charging                      = themes_path .. 'icons/battery/battery-low-charging.png'

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(theme.menu_height, theme.colors.primary, theme.bg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Colloid-Dark'

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
  rnotification.append_rule({
    rule = { urgency = "critical" },
    properties = { bg = theme.colors.high, fg = theme.colors.foreground },
  })
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
