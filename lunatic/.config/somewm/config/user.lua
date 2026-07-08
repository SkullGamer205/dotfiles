local awful = require('awful')

-- Specify user preferences for SomeWM's behavior
return {
    modkey = "Mod4",
    -- tags = { '1', '2', '3', '4', '5', '6', '7', '8' },
    tags = { '1', '2', '3', '4'},

    layouts = {
        awful.layout.suit.carousel,
        awful.layout.suit.floating,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.tile,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    },

    font = {
        name = 'PixelCode',
        size = '10',
    },

    palette = {
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
}
