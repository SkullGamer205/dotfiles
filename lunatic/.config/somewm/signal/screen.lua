local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

--- Attach tags and widgets to all screens.
screen.connect_signal("request::desktop_decoration", function(s)
    -- Create all tags and attach layouts to each of them
    awful.tag(require('config.user').tags, s, require('config.user').default_layout)
end)
