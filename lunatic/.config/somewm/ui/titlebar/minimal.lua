local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
return function(c)
    -- {{{ Titlebars
    -- @DOC_TITLEBARS@

    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c, {size = beautiful.border_width * 3}).widget = {
        layout = wibox.layout.align.horizontal,
        buttons = buttons,
    }
end
