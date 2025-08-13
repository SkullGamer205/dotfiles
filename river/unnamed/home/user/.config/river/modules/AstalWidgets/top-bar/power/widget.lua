local astal     = require("astal")
local Astal     = astal.require("Astal", "3.0")
local App       = require("astal.gtk3").App
local Widget    = require("astal.gtk3.widget")
local bind      = astal.bind
local Variable  = astal.Variable
local Anchor    = Astal.WindowAnchor
local Gdk       = require("astal.gtk3").Gdk
local Debug     = require("lib.debug")

--[[
Icons:
    [1,1] shutdown    -> system-shutdown-symbolic
    [2,1] reboot      -> system-reboot-symbolic
    [2,1] lock        -> system-lock-screen-symbolic
    [2,2] log-out     -> system-log-out-symbolic
    [3,1] hibernate   -> system-hibernate-symbolic
    [3,2] sleep       -> sleep
--]]

local function box_rand_label(t)
    if #t > 0 then
        return Widget.Label({
            label = string.format('%s', t[math.random(#t)])
        })
    else
        Debug.Error("Power Menu", "Table as empty!")
        return Widget.Box({})
    end
end

local function box_power(p)
    return Widget.Box({
        expand = false,
        table.unpack(p)
    })
end

local function btn_power(props)
    return Widget.Button({
        expand = false,
        on_click_release = function(_, event)
            local w_power = App:get_window("PowerWindow")
            if event.button == "PRIMARY" then
                os.execute(string.format('%s', props.cmd))
                w_power:hide()
            else
                print("NOTHING")
            end
        end,
        Widget.Box({
            vertical = true,
            Widget.Icon({
                icon = string.format("%s", props.icon),
                css = "font-size: 64px;",
            }),
            Widget.Label({
                label = string.format("%s", props.name),
            })
        })
    })
end

return function()
    local buttons = {}
    local b_buttons = {
        [1] = { name = "Выключение",      icon = "system-shutdown-symbolic",      cmd = "loginctl poweroff"},
        [2] = { name = "Перезапуск",      icon = "system-reboot-symbolic",        cmd = "loginctl reboot"},
        [3] = { name = "Блокировка",      icon = "system-lock-screen-symbolic",   cmd = "gtklock"},
        [4] = { name = "Выход",           icon = "system-log-out-symbolic",       cmd = "pkill river"},
        [5] = { name = "Гибернация",      icon = "system-hibernate-symbolic",     cmd = "loginctl hibernate"},
        [6] = { name = "Сон",             icon = "sleep",                         cmd = "loginctl suspend"},
    }

    for i = 1, #b_buttons do
        buttons[i] = btn_power({
            icon   = b_buttons[i].icon,
            name   = b_buttons[i].name,
            cmd    = b_buttons[i].cmd,
        })
    end

    local str_exit_labels = {
        '晚安，师父！ (⌒▽⌒)☆ ',
        '你已经走了吗？  	(・・ ) ?',
        '晚上好！ (⌒ ‿⌒ )',
        '您是无意中点击了这个吗？ (＠_＠)' ,
    }

    -- phrases = {'晚安，师父！ (⌒▽⌒)☆ ', '你已经走了吗？  	(・・ ) ?', "晚上好！ (⌒‿⌒)", "您是无意中点击了这个吗？ (＠_＠)"},

    return Widget.Window({
        name = "PowerWindow",
        class_name = "win_power",
        application = App,
        monitor = monitor,
        exclusivity = "IGNORE",
        keymode = "ON_DEMAND",
        anchor = Anchor.TOP + Anchor.BOTTOM,
        visible = false,
        on_key_press_event = function(self,event)
            if event.keyval == Gdk.KEY_Escape then self:hide() end
        end,
       Widget.Box({
           vertical = true,
           valign = "CENTER",
           box_rand_label(str_exit_labels),
           box_power(buttons),
       }) 
    })
end
