-- Libs
local wibox             = require('wibox')
local beautiful         = require('beautiful')
local SimpleBox         = require('module.simplify.widgets').box.create

local current_time = os.time()
local day          = 24 * 60 * 60

local SimpleText        = require('module.simplify.widgets').textbox.colored

local current_date = function(_format, _scale)
    return SimpleText({
        align   = {'center', 'center'},
        text    = os.date(_format, current_time +  day),
        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * _scale
    })

end

return function()
    return SimpleBox({
        SimpleBox(current_date('%b | %a', 2), {
           bg_main  = beautiful.colors.foreground,
           fg_main  = beautiful.colors.background_light,
        }),
        current_date('%d', 6),
        current_date('%Y', 2),
    }, {
        bg_main = beautiful.colors.background_light,
        align   = "vertical"
    })
end
