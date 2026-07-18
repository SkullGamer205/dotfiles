-- Power Menu
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local wibox         = require('wibox')
local SimplePopup   = require('module.simple_widgets.popup').create
local SimpleIcon    = require('module.simple_widgets.image').create_icon
local SimpleBox     = require('module.simple_widgets.box').create_box

-- For different lua versions
local unpack        = table.unpack or unpack

local options = {
    {name = 'Poweroff',     icon = beautiful.power_shutdown,    key = 'p',    command = function() awful.spawn('loginctl poweroff')          end},
    {name = 'Reboot',       icon = beautiful.power_reboot,      key = 'r',    command = function() awful.spawn('loginctl reboot')            end},
    {name = 'Log out',      icon = beautiful.power_logout,      key = 'o',    command = function() awful.spawn('loginctl kill-session self') end},
    {name = 'Lock',         icon = beautiful.power_lockscreen,  key = 'l',    command = function() awful.spawn('loginctl lock-session self') end},
    {name = 'Suspend',      icon = beautiful.power_suspend,     key = 's',    command = function() awful.spawn('loginctl suspend')           end},
    {name = 'Hibernate',    icon = beautiful.power_hibernate,   key = 'h',    command = function() awful.spawn('loginctl hibernate')         end},
}

local selected_index = 1

local function create_button(option, index)
    local is_selected = index == selected_index

    local icon_widget = SimpleIcon(option.icon, {
        highlight_color = beautiful.colors.primary,
        main_color      = is_selected and beautiful.colors.primary or beautiful.fg_normal,
        width           = beautiful.font:match("%d+$") * 8,
    })

    local text_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        text    = '[' .. option.key .. '] ' .. option.name,
        align   = 'center',
    })

    local widget = wibox.widget({
        widget   = wibox.container.margin,
        margins  = 16,
        {
            widget = wibox.layout.fixed.vertical,
            spacing = 8,
            icon_widget,
            text_widget,
        }
    })

    local button = SimpleBox(widget, {
        main_color      = beautiful.bg_normal,
        highlight_color = beautiful.bg_focus,
        on_clicked  = option.command,
    })

    return button
end

local function create_power_widget()
    local buttons = {}

    for i, option in pairs(options) do
        table.insert(buttons, create_button(option, i))
    end

    return wibox.widget({
        widget  = wibox.container.place,
        halign  = 'center',
        valign  = 'center',
        {
            widget          = wibox.container.background,
            bg              = beautiful.bg_normal,
            border_color    = beautiful.border_color_active,
            border_width    = beautiful.border_width * 2,
            {
                widget  = wibox.container.margin,
                margins = 32,
                {
                    layout  = wibox.layout.fixed.vertical,
                    spacing = 32,
                    -- Title
                    {
                        widget  = wibox.widget.textbox,
                        halign  = 'center',
                        text    = 'What you would like to do?',
                        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match("%d+$") * 2
                    },
        
                    -- Buttons
                    {
                        layout = wibox.layout.fixed.horizontal,
                        unpack(buttons),
                    },
        
                    -- Hint
                    {
                        widget  = wibox.widget.textbox,
                        halign  = 'center',
                        text    = 'Press Escape to cancel',
                        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match("%d+$") - 2
                    },
                }
            },
        },
    })
end

local function execute_selected(w)
    if options[selected_index] then
        w:hide()
        options[selected_index].command()
    end
end

local powermenu = SimplePopup('powermenu', {
    main_widget = create_power_widget,
    placement   = awful.placement.maximize,

    on_show     = function() selected_index = 1 end,

    keypressed_callback = function(w, key, _)
        if      key == "Return" then
            w.hide()
            execute_selected()
        elseif  key == "Left" then 
            selected_index = math.max(1, selected_index - 1)
            w.refresh()
        elseif  key == "Right" then 
            selected_index = math.min(#options, selected_index + 1)
            w.refresh()
        else
            -- Check for shortcut keys
            for i, option in pairs(options) do
                if key == option.key then
                    selected_index = i
                    w.refresh()
                    
                    gears.timer.start_new(0.15, function()
                        execute_selected()
                        return false
                    end)

                    w.hide()
                    return
                end
            end
        end
    end,
})

return powermenu
