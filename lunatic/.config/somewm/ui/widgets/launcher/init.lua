local awful         = require('awful')
local beautiful     = require('beautiful')

local SimpleIcon        = require('module.simple_widgets.image')
local SimpleBox         = require('module.simple_widgets.box')

local LauncherWidget    = require(... .. '.widget')

local icon      = SimpleIcon.create_icon(beautiful.launcher_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.fg_focus,
})

local widget    = SimpleBox.create_box(icon, {
    bg_main     = beautiful.colors.background_light,
    bg_hover    = beautiful.bg_focus,
    on_clicked  = { left = function() LauncherWidget.toggle() end }
})

return function()
    return widget
end
