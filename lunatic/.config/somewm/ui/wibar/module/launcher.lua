local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleWidgets = require('utils.simple_widgets')

local icon      = SimpleWidgets.image(beautiful.launcher_icon, nil, beautiful.fg_normal, beautiful.bg_focus)
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

-- return function()
-- -- Create a launcher widget
--     return awful.widget.launcher({
--         image = beautiful.launcher_icon,
--         menu  = require('ui.menu').main
--     })
-- end
