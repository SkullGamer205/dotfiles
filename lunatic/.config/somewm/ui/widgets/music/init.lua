local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleIcon    = require('module.simple_widgets.image')
local SimpleBox     = require('module.simple_widgets.box')
-- local MusicMenu     = require(... .. '.widget')

local icon      = SimpleIcon.create_icon(beautiful.music_icon, {
    main_color      = beautiful.fg_normal,
    highlight_color = beautiful.fg_focus,
})

local widget = SimpleBox.create_box(icon, {
    main_color      = beautiful.colors.background_light,
    highlight_color = beautiful.bg_focus,
    -- on_clicked      = function() MusicMenu.toggle() end
})

return function()
    return widget
end
