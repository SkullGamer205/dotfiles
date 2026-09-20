local awful         = require('awful')
local beautiful     = require('beautiful')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleIcon        = SimplifyWidgets.icon.create

local LauncherWidget    = require(... .. '.widget')

local icon      = SimpleIcon(beautiful.launcher_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.fg_focus,
})

local widget    = SimpleBox(icon, {
    bg_main     = beautiful.colors.background_light,
    bg_hover    = beautiful.bg_focus,
    on_clicked  = { left = function() LauncherWidget.toggle() end }
})

return function()
    return widget
end
