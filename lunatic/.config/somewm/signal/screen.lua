local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

--- Attach tags and widgets to all screens.
screen.connect_signal("request::desktop_decoration", function(s)
    -- Create all tags and attach layouts to each of them
    awful.tag(require('config.user').tags, s, require('config.user').default_layout)
end)

-- @DOC_WALLPAPER@
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            widget = wibox.container.tile,
            valign = "center",
            halign = "center",
            tiled  = false,
            {
                widget    = wibox.widget.imagebox,
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true
            },
        }
    }
end)
