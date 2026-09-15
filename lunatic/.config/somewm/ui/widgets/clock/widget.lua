-- Libs
local awful             = require('awful')
local beautiful         = require('beautiful')
local wibox             = require('wibox')
local SimpleBox         = require('module.simple_widgets.box').create_box

local modules           = require('ui.widgets.clock.modules')

return function()
    return SimpleBox({
        modules.clock("%H\n%M\n%S"),
        modules.calendar()},
        {
            align    = "horizontal",
            bg_main  = beautiful.bg_normal,
            inner_margin = 0,
            outer_margin = 0,
        })
end
