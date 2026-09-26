local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')


local SimpleTextbox = {}

-- Module for creating scrolling textbox
-- @param opts                  table                                   Configuration and callbacks.
-- @param opts.text             string          (default: nil)          Text
-- @param opts.markup           string          (default: nil)          Text with markup
-- @param opts.font             string          (default: nil)          Text font
-- @param opts.color            string          (default: fg_normal)    Text color
-- @param opts.align            table           (default: {nil, nil})   Text align
-- @param opts.direction        string          (default: 'horizontal') Scroll direction
-- @param opts.speed            intenger        (default: 50)           Scrolling speed

function SimpleTextbox.colored(opts) 
    opts            = opts              or {}
    local text      = opts.text         or nil
    local markup    = opts.markup       or nil
    local font      = opts.font         or nil
    local color     = opts.color        or nil
    local align     = opts.align        or {nil, nil}

    local widget    = wibox.widget({
        widget      = wibox.container.background,
        fg          = color,
        {
            widget      = wibox.widget.textbox,
            markup      = markup,
            text        = text,
            font        = font,
            align       = align[1],
            valign      = align[2],
            id          = 'text_role'
        },

        set_text        = function(self, new_text)
            self:get_children_by_id('text_role')[1].text    = new_text
        end,
        
        set_markup      = function(self, new_markup)
            self:get_children_by_id('text_role')[1].markup  = new_markup
        end,

        set_color       = function(self, new_color)
            self.fg     = new_color
        end
    })

    return widget
end

function SimpleTextbox.scrolling(opts)
    opts            = opts              or {}
    local text      = opts.text         or nil
    local markup    = opts.markup       or nil
    local font      = opts.font         or nil
    local color     = opts.color        or nil
    local speed     = opts.speed        or 50
    local align     = opts.align        or {nil, nil}

    local direction
    if  opts.direction == 'vertical' then
        direction = wibox.container.scroll.vertical
    else
        direction = wibox.container.scroll.horizontal
    end

    local widget = wibox.widget({
        widget          = direction,
        speed           = speed,
        step_function   = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        
        SimpleTextbox.colored({
            text    = text,
            markup  = markup,
            font    = font,
            color   = color,
            align   = align,
        })
    })

    return widget
end

return SimpleTextbox
