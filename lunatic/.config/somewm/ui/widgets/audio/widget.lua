-- Libs
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local simple    = 'module.simple_widgets'
local s_icon    = require(simple .. '.image').create_icon
local s_box     = require(simple .. '.box').create_box
local s_sprt    = require(simple .. '.separator').create

local _Audio = {}

-- Header (Widget info (Speakers/Microphone))
_Audio.header = s_box({
    s_icon(beautiful.sink_volume_high, {width = 16}),
    wibox.widget.textbox("Volume Mixer"), 
}, {
    align       = "horizontal",
    bg_main     = beautiful.colors.background_light,
})

-- Widget template
_Audio.w_template   = s_box({
    s_icon(beautiful.systray_icon    , {width = 16}),           -- Set Sink/Source
    s_icon(beautiful.sink_volume_high, {width = 16}),           -- App/Device icon
    wibox.widget.textbox("Speakers"),                           -- App/Device Name
    wibox.widget({
        widget = wibox.widget.progressbar,
        value             = 45,
        max_value         = 100,
        forced_width      = 96,
        forced_height     = 2,
        color             = beautiful.fg_normal,
        background_color  = beautiful.bg_normal,
        border_color      = beautiful.colors.background_light,
        border_width      = 6,
    }),                                                         -- Bar
    wibox.widget.textbox("45%"),                                -- Sink/Source volume value
}, {
    align       = "horizontal",
    bg_main     = beautiful.colors.background_light,
})

-- External app button
function _Audio.externalApp(name, cmd)
    return s_box({
        wibox.widget.textbox("Open " .. name),
    }, {
        align         = "horizontal",
        bg_main       = beautiful.colors.background_light,
        outer_margin  = 2,
        on_clicked    = { left = function() awful.spawn.with_shell(string.format("%s", cmd)) end }
    })
end

local externalApps = s_box({
    _Audio.externalApp("QjackCtl", "qjackctl"),
    _Audio.externalApp("Volume Control", "pwvucontrol"),
}, {
    align       = "horizontal",
})

return function()
    return s_box({
        wibox.widget.textbox("W.I.P."),
        _Audio.header,
        s_sprt("horizontal", {color = beautiful.colors.background_light}),
        _Audio.w_template,
        s_sprt("horizontal", {color = beautiful.colors.background_light}),
        _Audio.w_template,
        _Audio.w_template,
        _Audio.w_template,
        s_sprt("horizontal", {color = beautiful.colors.background_light}),
        externalApps,
    }, {
        align   = "vertical",
        bg_main = beautiful.bg_normal,
    })
end
