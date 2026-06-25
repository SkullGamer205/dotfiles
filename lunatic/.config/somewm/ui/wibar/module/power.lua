local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleWidgets = require('utils.simple_widgets')

local icon      = SimpleWidgets.image(beautiful.power_shutdown, nil, beautiful.fg_normal, beautiful.bg_focus)
local widget    = SimpleWidgets.square(icon, beautiful.bg_normal)

widget:add_button(awful,button({ nil }, 1, function()
    -- require('ui.menu').main
end)
)

return function()
    return widget
end
