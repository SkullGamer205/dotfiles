local wibox = require("wibox")

local widget = {}

local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/ui/wibar/module/aww/micro-widget/icons/'

function widget.get_widget(widgets_args)
    local args = widgets_args or {}

    local icon_dir = args.icon_dir or ICON_DIR

    return wibox.widget {
        {
            id = "icon",
            resize = false,
            widget = wibox.widget.imagebox,
        },
        valign = 'center',
        layout = wibox.container.place,
        set_micro_level = function(self, new_value)
            local micro_icon_name
            if self.is_muted then
                micro_icon_name = 'mic-volume-muted'
            else
                local new_value_num = tonumber(new_value)
                if (new_value_num >= 0 and new_value_num < 33) then
                    micro_icon_name="mic-volume-low"
                elseif (new_value_num < 66) then
                    micro_icon_name="mic-volume-medium"
                else
                    micro_icon_name="mic-volume-high"
                end
            end
            self:get_children_by_id('icon')[1]:set_image(icon_dir .. micro_icon_name .. '.svg')
        end,
        mute = function(self)
            self.is_muted = true
            self:get_children_by_id('icon')[1]:set_image(icon_dir .. 'mic-volume-muted.svg')
        end,
        unmute = function(self)
            self.is_muted = false
        end
    }
end

return widget
