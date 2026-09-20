local awful      = require('awful')
local beautiful  = require('beautiful')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleIcon        = SimplifyWidgets.icon.create
local SimplePopup       = SimplifyWidgets.popup.create
local NotifMenu     = require(... .. '.widget')

local icon      = SimpleIcon(beautiful.notifications_empty_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.fg_focus,
})

return function(s)
    local popup     = SimplePopup('notifmenu', {
        main_widget   = NotifMenu,
        placement     = awful.placement.under_mouse + awful.placement.no_offscreen,
        border_color  = beautiful.border_color_active,
        border_width  = beautiful.border_width,
    })
    
    return SimpleBox(icon, {
        bg_main     = beautiful.colors.background_light,
        bg_hover    = beautiful.bg_focus,
        on_clicked  = { left = function() popup.toggle() end }
    })
end
