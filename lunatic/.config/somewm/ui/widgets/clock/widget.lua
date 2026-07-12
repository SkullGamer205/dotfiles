-- Libs
local awful             = require('awful')
local beautiful         = require('beautiful')
local wibox             = require('wibox')
local gears             = require('gears')
local SimplePopup       = require('module.simple_widgets.popup').create
local SimpleBox         = require('module.simple_widgets.box').create_box

local function clock_widget(format)
    local clock_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        align   = 'center',
        valign  = 'center',
        text    = '',
        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 4
    })

    local function update_func()
        clock_widget:set_text('' .. os.date(format))
    end

    gears.timer({
        timeout     = 1,
        autostart   = true,
        call_now    = true,
        callback    = update_func,
    })

    return clock_widget
end

local function calendar_widget()
    local cal_buttons  = {}
    local current_time = os.time()
    local day          = 24 * 60 * 60

    local current_month = wibox.widget({
        widget = wibox.widget.textbox,
        halign = 'center',
        valign = 'center',
        text   = os.date('%B. %Y', current_time + ((- 2) * day)),
        font   = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 1.5
    })

    local function cal_date_button(i)
        local function text_widget(i)
            return wibox.widget({
                widget = wibox.widget.textbox,
                halign = 'center',
                valign = 'center',
                text   = os.date('%d (%a)', current_time + ((- 2 + i) * day)),
                font   = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 1.25
            })
        end

        return SimpleBox(text_widget(i), {
            main_color          = beautiful.bg_normal,
            highlight_color     = beautiful.bg_focus,
            margin              = 2,
        })
    end

    for i = 1, 7 do
        cal_buttons[#cal_buttons + 1] = cal_date_button(i)
    end

    return wibox.widget({
        widget = wibox.container.place,
        {
            layout  = wibox.layout.fixed.vertical,
            current_month,
            unpack(cal_buttons)
        }
    })
end

local function create_clock_widget()
    return wibox.widget({
        widget  = wibox.container.place,
        halign  = 'right',
        valign  = 'center',
        {
            widget          = wibox.container.background,
            bg              = beautiful.bg_normal,
            border_color    = beautiful.border_color_active,
            border_width    = beautiful.border_width,
            {
                layout  = wibox.layout.fixed.horizontal,
                -- Clock
                SimpleBox(clock_widget('%H\n%M\n%S'),
                {
                    -- main_color = beautiful.bg_focus,
                    margin     = 8,
                }
            ),
                calendar_widget(),
                -- Weather
                -- {},
            }
        }
    })
end

local clockmenu = SimplePopup('clockmenu', {
    main_widget = create_clock_widget,
    placement   = awful.placement.maximize,
})

return clockmenu
