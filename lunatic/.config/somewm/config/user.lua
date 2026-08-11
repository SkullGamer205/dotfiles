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
        name = 'CozetteCrossedSeven',
        size = '10',
    },

    -- Base24 Everforest Theme
    palette     = {
    -- Base00-07
    base00      = '#272e33', -- [ BG ] Default
    base01      = '#343f44', -- [ BG ] Lighter
    base02      = '#3d484d', -- [ BG ] Selection
    base03      = '#56635f', -- [ BG ] Highlight
    base04      = '#9196a1', -- [ FG ] Dark
    base05      = '#d3c6aa', -- [ FG ] Default
    base06      = '#e6e6e6', -- [ FG ] Light
    base07      = '#ffffff', -- [ FG ] Lightest

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
    }
}
