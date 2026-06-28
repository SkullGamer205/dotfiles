local awful         = require('awful')
local beautiful     = require('beautiful')

local SimpleIcon    = require('module.simple_widgets.image')
local SimpleWidgets = require('utils.simple_widgets')

local icon      = SimpleIcon.create_icon(beautiful.launcher_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.bg_focus,
})

local widget    = SimpleWidgets.square(icon, beautiful.bg_normal)

widget:add_button(awful,button({}, 1, function()
    -- require('ui.menu').main
end)
)
widget:add_button(awful.button({}, 1, function()
end))

return function()
    return widget
end
