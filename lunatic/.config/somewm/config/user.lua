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
    }
}
