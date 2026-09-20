local awful      = require('awful')
local beautiful  = require('beautiful')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleIcon        = SimplifyWidgets.icon.create
local SimplePopup       = SimplifyWidgets.popup.create

-- local MusicMenu     = require(... .. '.widget')

local icon      = SimpleIcon(beautiful.music_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.fg_focus,
})

return function()
    local popup     = SimplePopup('musicmenu', {
        -- main_widget = MusicMenu,
        placement   = ( awful.placement.under_mouse + awful.placement.no_offscreen ),
    })

    local widget = SimpleBox(icon, {
        bg_main     = beautiful.colors.background_light,
        bg_hover    = beautiful.bg_focus,
        on_clicked  = { left = function() popup.toggle() end }
    })

    return widget
end
