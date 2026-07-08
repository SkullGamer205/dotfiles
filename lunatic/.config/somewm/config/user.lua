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

    -- Everforest dark
    palette = {
        background      = '#272E33',
        foreground      = '#D3C6AA',
        
        black           = '#1E2326',
        red             = '#E67E80',
        green           = '#A7C080',
        yellow          = '#DBBC7F',
        blue            = '#7FBBB3',
        magenta         = '#D699B6',
        cyan            = '#83C092',
        white           = '#F2EFDF',
    
        bright_black    = '#293136',
        bright_red      = '#F85552',
        bright_green    = '#F57D26',
        bright_yellow   = '#DFA000',
        bright_blue     = '#3A94C5',
        bright_magenta  = '#DF69BA',
        bright_cyan     = '#35A77C',
        bright_white    = '#FFFBEF',
    }
}
