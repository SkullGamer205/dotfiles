local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleWidgets = require('utils.simple_widgets')
local SimpleIcon    = require('module.simple_widgets.image')
local PowerMenu     = require('ui.widgets.power')

local icon      = SimpleIcon.create_icon(beautiful.power_shutdown, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.bg_focus
})
local widget    = SimpleWidgets.square(icon, beautiful.bg_normal)

widget:add_button(awful.button({ nil }, 1, function()
    -- require('ui.menu').main
    PowerMenu.toggle()
end)
)

return function()
    return widget
end
