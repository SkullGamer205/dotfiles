local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleIcon    = require('module.simple_widgets.image')
local SimpleBox     = require('module.simple_widgets.box')
local PowerMenu     = require(... .. '.widget')

local icon      = SimpleIcon.create_icon(beautiful.power_shutdown, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.bg_focus
})

local widget = SimpleBox.create_box(icon, {
    main_color      = beautiful.bg_normal,
    on_clicked      = function() PowerMenu.toggle() end
})

return function()
    return widget
end
