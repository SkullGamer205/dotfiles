local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleIcon    = require('module.simple_widgets.image')
local SimpleBox     = require('module.simple_widgets.box')
local SimplePopup   = require('module.simple_widgets.popup').create
local NotifMenu     = require(... .. '.widget')

local icon      = SimpleIcon.create_icon(beautiful.notifications_empty_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.fg_focus,
})

return function(s)
    local popup     = SimplePopup('notifmenu', {
        main_widget = NotifMenu,
        placement   = awful.placement.under_mouse + awful.placement.no_offscreen,
    })
    
     local widget = SimpleBox.create_box(icon, {
        main_color      = beautiful.colors.background_light,
        highlight_color = beautiful.bg_focus,
        on_clicked      = function() popup.toggle() end
    })

    return widget
end
