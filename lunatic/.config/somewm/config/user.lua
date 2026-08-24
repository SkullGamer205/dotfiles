local awful = require('awful')

-- Specify user preferences for SomeWM's behavior
return {

    -- THEME

    -- Base24 Everforest Theme
    palette     = {
    -- Base00-07
    base00      = '#272e33', -- [ BG ] Default
    base01      = '#2e383c', -- [ BG ] Lighter
    base02      = '#414b50', -- [ BG ] Selection
    base03      = '#4f5b58', -- [ BG ] Highlight
    base04      = '#9da9a0', -- [ FG ] Dark
    base05      = '#d3c6aa', -- [ FG ] Default
    base06      = '#edeada', -- [ FG ] Light
    base07      = '#fffbef', -- [ FG ] Lightest

    -- Base08-0E
    base08      = '#e67e80', -- [ RED     ] Normal
    base09      = '#e69875', -- [ ORANGE  ] Normal
    base0A      = '#dbbc7f', -- [ YELLOW  ] Normal
    base0B      = '#a7c080', -- [ GREEN   ] Normal
    base0C      = '#7fbbb3', -- [ CYAN    ] Normal
    base0D      = '#83c092', -- [ BLUE    ] Normal
    base0E      = '#d699b6', -- [ MAGENTA ] Normal
    base0F      = '#e67e80', -- [ BROWN   ] Normal

    -- Base10-17
    base10      = '#1e2326', -- [ BG ]      Darker
    base11      = '#1e2326', -- [ BG ]      Darkest
    base12      = '#f85552', -- [ RED     ] Bright
    base13      = '#DFA000', -- [ YELLOW  ] Bright
    base14      = '#F57D26', -- [ GREEN   ] Bright
    base15      = '#35A77C', -- [ CYAN    ] Bright
    base16      = '#3A94C5', -- [ BLUE    ] Bright
    base17      = '#DF69BA', -- [ MAGENTA ] Bright
    },

    font = {
        -- name = 'CozetteCrossedSeven',
        name = 'Fairfax',
        size = '9',
    },
    
    -- OUTPUTS
    outputs = {
        -- Virtual machine
        ['Virtual-1'] = {
            resolution      = {1920, 1080, 60}, -- Width, Height, Rate
            adaptive_sync   = false,
            scale           = 1.0,
            position        = {0, 0},
        },

        -- Virtual display
        ['WL-1'] = {
            resolution      = {640, 480, 60},
            adaptive_sync   = false,
            scale           = 1.0,
            position        = {0, 0},
        },
        
        -- Real displays
        ['eDP-1'] = {
            resolution      = {1920, 1080, 75},
            adaptive_sync   = false,
            scale           = 1.0,
            position        = {0, 0},
        },
        
        ['HDMI-A-1'] = {
            resolution      = {1920, 1080, 75},
            adaptive_sync   = false,
            scale           = 1.0,
            position        = {1920, 0},
        },
        
        ['DP-1'] = {
            resolution      = {1920, 1080, 60},
            adaptive_sync   = false,
            scale           = 1.0,
            position        = {3840, 0},
        },

    },

    -- INPUTS
    keyboard    = {
        layout      = "us,ru",
        variant     = "",
        options     = "",
        -- model       = "",
        set_repeat  = {30, 300},        -- rate, delay
    },

    -- KEYBOARD
    modkey = "Mod4",

    -- TAGS
    tags = { '1', '2', '3', '4'},

    -- LAYOUTS
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

    -- Screenshots
    shots = {
        directory   = os.getenv("HOME") .. "/media/screenshots/",
        notify      = true,

    }
}
