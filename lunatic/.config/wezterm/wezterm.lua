-- Wezterm API
local wezterm = require('wezterm')

-- Config holder
local config = wezterm.config_builder()

-- Font
config.font             = wezterm.font('Fairfax Hax')
config.font_size        = 9

-- Cursor
config.xcursor_theme    = "Adwaita"

-- Colors
local colorscheme       = wezterm.color.load_scheme(wezterm.config_dir .. "/colors/everforest-dark-hard.toml")

config.color_schemes    = {
    ["Everforest"]      = colorscheme
}

config.color_scheme     = "Everforest"
-- Window frame
config.window_frame     = {
    font                = wezterm.font('Fairfax'),
    font_size           = 9,
}

-- Simple Titlebar
config.use_fancy_tab_bar            = false
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.75
config.text_background_opacity   = 1
config.tab_max_width             = 32

return config
