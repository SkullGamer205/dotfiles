---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gdebug = require("gears.debug")
local gfs = require("gears.filesystem")
local recolor_image = require("gears.color").recolor_image
local themes_path = gfs.get_configuration_dir() .. "themes/"

local color = gfs.get_configuration_dir() .. "themes/module/color.lua"
local theme = {}

theme.palette = setmetatable({

    background      = xrdb.background or "#1d1f21",
    foreground      = xrdb.foreground or "#c5c8c6",

    black           = xrdb.color0     or "#1d1f21",
    red             = xrdb.color1     or "#cc6666",
    green           = xrdb.color2     or "#b5bd68",
    yellow          = xrdb.color3     or "#f0c674",
    blue            = xrdb.color4     or "#81a2be",
    magenta         = xrdb.color5     or "#b294bb",
    cyan            = xrdb.color6     or "#8abeb7",
    white           = xrdb.color7     or "#c5c8c6",

    black_bright    = xrdb.color8     or "#373B41",
    red_bright      = xrdb.color9     or "#d54e53",
    green_bright    = xrdb.color10    or "#b9ca4a",
    yellow_bright   = xrdb.color11    or "#e7c547",
    blue_bright     = xrdb.color12    or "#7aa6da",
    magenta_bright  = xrdb.color13    or "#c397d8",
    cyan_bright     = xrdb.color14    or "#70c0b1",
    white_bright    = xrdb.color15    or "#eaeaea",

}, color.palette_metatable)

theme.colors = {

    background      = theme.palette.background,
    foreground      = theme.palette.foreground,
    
}


-- Icon Theme
theme.icon_theme          = "SE98"

-- Font
theme.font_name           = "Terminess Nerd Font Mono"
theme.font_size           = 9
theme.font                = theme.font_name .. " " .. theme.font_size
    
    
-- Background
theme.bg_normal           = theme.palette.background
theme.bg_focus            = theme.palette.background
theme.bg_urgent           = theme.palette.red
theme.bg_minimize         = theme.palette.background
theme.bg_systray          = theme.palette.background

-- Foreground
theme.fg_normal           = theme.palette.black_bright
theme.fg_focus            = theme.palette.foreground
theme.fg_urgent           = theme.palette.background
theme.fg_minimize         = theme.palette.foreground

-- Border
theme.border_width        = dpi(0)
theme.border_color_normal = theme.palette.background
theme.border_color_active = theme.palette.black_bright
theme.border_color_urgent = theme.palette.red

-- Gaps
theme.useless_gap         = dpi(4)
theme.gap_single_client   = false

-- Systray
theme.systray_icon_spacing      = 0
theme.bg_systray                = c_bg

-- HotKeys Popup
theme.hotkeys_font              = theme.font
theme.hotkeys_modifiers_fg      = theme.palette.blue
theme.hotkeys_description_font  = theme.font
theme.hotkeys_border_width      = theme.border_width
theme.hotkeys_border_color      = theme.palette.black_bright
theme.hotkeys_group_margin      = dpi(6) * 4

-- Maximized
theme.maximized_honor_padding   = true
theme.maximized_hide_border     = true

-- Wibar
theme.wibar_height              = dpi(6) * 4

-- Cursor
theme.enable_spawn_cursor       = false

-- Taglist
theme.taglist_disable_icon      = false

-- Fullscreen
theme.fullscreen_hide_border    = true

-- Icons
theme.menu_submenu_icon  = themes_path.."default/submenu.png"
theme.menu_height        = dpi(15)
theme.menu_width         = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh       = recolor_image(themes_path .. "default/layouts/fairhw.png",        theme.palette.foreground)
theme.layout_fairv       = recolor_image(themes_path .. "default/layouts/fairvw.png",        theme.palette.foreground)
theme.layout_floating    = recolor_image(themes_path .. "default/layouts/floatingw.png",     theme.palette.foreground)
theme.layout_magnifier   = recolor_image(themes_path .. "default/layouts/magnifierw.png",    theme.palette.foreground)
theme.layout_max         = recolor_image(themes_path .. "default/layouts/maxw.png",          theme.palette.foreground)
theme.layout_fullscreen  = recolor_image(themes_path .. "default/layouts/fullscreenw.png",   theme.palette.foreground)
theme.layout_tilebottom  = recolor_image(themes_path .. "default/layouts/tilebottomw.png",   theme.palette.foreground)
theme.layout_tileleft    = recolor_image(themes_path .. "default/layouts/tileleftw.png",     theme.palette.foreground)
theme.layout_tile        = recolor_image(themes_path .. "default/layouts/tilew.png",         theme.palette.foreground)
theme.layout_tiletop     = recolor_image(themes_path .. "default/layouts/tiletopw.png",      theme.palette.foreground)
theme.layout_spiral      = recolor_image(themes_path .. "default/layouts/spiralw.png",       theme.palette.foreground)
theme.layout_dwindle     = recolor_image(themes_path .. "default/layouts/dwindlew.png",      theme.palette.foreground)
theme.layout_cornernw    = recolor_image(themes_path .. "default/layouts/cornernww.png",     theme.palette.foreground)
theme.layout_cornerne    = recolor_image(themes_path .. "default/layouts/cornernew.png",     theme.palette.foreground)
theme.layout_cornersw    = recolor_image(themes_path .. "default/layouts/cornersww.png",     theme.palette.foreground)
theme.layout_cornerse    = recolor_image(themes_path .. "default/layouts/cornersew.png",     theme.palette.foreground)

theme.layout_mstab       = recolor_image(themes_path .. "default/layouts/mstab.png",         theme.palette.foreground)
theme.layout_deck        = recolor_image(themes_path .. "default/layouts/deck.png",          theme.palette.foreground)
theme.layout_equalarea   = recolor_image(themes_path .. "default/layouts/equalarea.png",     theme.palette.foreground)
theme.layout_horizontal  = recolor_image(themes_path .. "default/layouts/horizontal.png",    theme.palette.foreground)
theme.layout_vertical    = recolor_image(themes_path .. "default/layouts/vertical.png",      theme.palette.foreground)
theme.layout_centered    = recolor_image(themes_path .. "default/layouts/centered.png",      theme.palette.foreground)
theme.layout_centerwork  = recolor_image(themes_path .. "default/layouts/centerworkw.png",   theme.palette.foreground)
theme.layout_machi       = recolor_image(themes_path .. "default/layouts/machiw.png",        theme.palette.foreground)

theme.layout_leavedright  = recolor_image(themes_path .. "default/layouts/leavedright.png",   theme.palette.foreground)
theme.layout_leavedleft   = recolor_image(themes_path .. "default/layouts/leavedleft.png",    theme.palette.foreground)
theme.layout_leavedtop    = recolor_image(themes_path .. "default/layouts/leavedtop.png",     theme.palette.foreground)
theme.layout_leavedbottom = recolor_image(themes_path .. "default/layouts/leavedrbottom.png", theme.palette.foreground)
-- arrow
theme.arrow_down_icon    = recolor_image(themes_path .. "default/other/arrow_down.svg",      theme.palette.foreground)
theme.arrow_up_icon      = recolor_image(themes_path .. "default/other/arrow_up.svg",        theme.palette.foreground)
theme.arrow_right_icon   = recolor_image(themes_path .. "default/other/arrow_right.svg",     theme.palette.foreground)
theme.arrow_left_icon    = recolor_image(themes_path .. "default/other/arrow_left.svg",      theme.palette.foreground)

-- status
theme.download_icon      = recolor_image(themes_path .. "default/other/download.svg",        theme.palette.white)
theme.upload_icon        = recolor_image(themes_path .. "default/other/upload.svg",          theme.palette.white)
theme.hard_drive_icon    = recolor_image(themes_path .. "default/other/hard_drive.svg",      theme.palette.cyan)
theme.temperature_icon   = recolor_image(themes_path .. "default/other/temperature.svg",     theme.palette.magenta)
theme.gpu_icon           = recolor_image(themes_path .. "default/other/gpu.svg",             theme.palette.green)
theme.memory_icon        = recolor_image(themes_path .. "default/other/memory.svg",          theme.palette.cyan)
theme.cpu_icon           = recolor_image(themes_path .. "default/other/cpu.svg",             theme.palette.magenta)
theme.clock_icon         = recolor_image(themes_path .. "default/other/clock.svg",           theme.palette.green)
theme.volume_icon        = recolor_image(themes_path .. "default/other/volume.svg",          theme.palette.blue)
theme.volume_mute_icon   = recolor_image(themes_path .. "default/other/volume_mute.svg",     theme.palette.yellow)
theme.mic_icon           = recolor_image(themes_path .. "default/other/mic.svg",             theme.palette.cyan)
theme.mic_off_icon       = recolor_image(themes_path .. "default/other/mic_off.svg",         theme.palette.yellow)

-- other icon
theme.menu_submenu_icon  = recolor_image(themes_path .. "default/other/submenu.svg",         theme.palette.foreground)
theme.notification_icon  = recolor_image(themes_path .. "default/other/notification.svg",    theme.palette.foreground)
theme.edit_icon          = recolor_image(themes_path .. "default/other/edit.svg",            theme.palette.foreground)
theme.refresh_icon       = recolor_image(themes_path .. "default/other/refresh.svg",         theme.palette.foreground)
theme.book_icon          = recolor_image(themes_path .. "default/other/book.svg",            theme.palette.foreground)
theme.keyboard_icon      = recolor_image(themes_path .. "default/other/keyboard.svg",        theme.palette.foreground)
theme.add_icon           = recolor_image(themes_path .. "default/other/add.svg",             theme.palette.foreground)
theme.subtract_icon      = recolor_image(themes_path .. "default/other/subtract.svg",        theme.palette.foreground)
theme.awesome_icon       = recolor_image(themes_path .. "default/other/awesomewm.svg",       theme.palette.black_bright)
theme.dashboard_icon     = recolor_image(themes_path .. "default/other/dashboard.svg",       theme.palette.foreground)
theme.menu_icon          = recolor_image(themes_path .. "default/other/menu.svg",            theme.palette.blue)
theme.image_icon         = recolor_image(themes_path .. "default/other/image.svg",           theme.palette.green)
theme.camera_icon        = recolor_image(themes_path .. "default/other/camera.svg",          theme.palette.blue)
theme.switch_user_icon   = recolor_image(themes_path .. "default/other/switch_user.svg",     theme.palette.yellow)

-- taglist

theme.taglist_spacing    = 2
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

-- Smart Borders

return theme

