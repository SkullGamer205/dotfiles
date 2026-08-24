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
config.color_scheme     = "everforest-dark-hard"

return config
