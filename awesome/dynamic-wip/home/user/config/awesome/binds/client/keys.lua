local awful  = require('awful')
local gears  = require("gears")
local mod    = require('binds.mod')
local lain   = require('module.lain')
local retain = require('module.awesome-retain')
local machi  = require('module.layout-machi')
local modkey = mod.modkey

--- Client keybindings.
client.connect_signal('request::default_keybindings', function()
   awful.keyboard.append_client_keybindings({
      -- Client state management.
      awful.key({ modkey,           }, 'f',
         function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
         end, { description = 'Переключить полноэкранный режим', group = 'Клиент' }),
      awful.key({ modkey, }, 'c', function(c) c:kill() end,
         { description = 'Закрыть', group = 'Клиент' }),
      awful.key({ modkey, mod.ctrl  }, 'space', awful.client.floating.toggle,
         { description = 'Переключить плавающий режим', group = 'Клиент' }),
      awful.key({ modkey,           }, 'n',
         function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
         end, { description = 'Свернуть', group = 'Клиент' }),
      awful.key({ modkey,           }, 'm',
         function(c)
            c.maximized = not c.maximized
            c:raise()
         end, { description = '(Раз-)вернуть', group = 'Клиент' }),
      awful.key({ modkey, mod.ctrl  }, 'm',
         function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
         end, { description = '(Раз-)вернуть вертикально', group = 'Клиент' }),
      awful.key({ modkey, mod.shift }, 'm',
         function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
         end, { description = '(Раз-)вернуть горизонтально', group = 'Клиент' }),

      -- Client position in tiling management.
      awful.key({ modkey, mod.ctrl  }, 'Return', function(c) c:swap(awful.client.getmaster()) end,
         { description = 'Перейти на главное окно', group = 'Клиент' }),
      awful.key({ modkey,           }, 'o', function(c) c:move_to_screen() end,
         { description = 'Перейти на экран', group = 'Клиент' }),
      awful.key({ modkey,           }, 't', function(c) c.ontop = not c.ontop end,
         { description = 'Переключить режим \"Поверх всех окон\"', group = 'Клиент' })
   })
end)

awful.keyboard.append_global_keybindings({
    awful.key({ modkey, mod.shift }, "n", function () lain.util.add_tag(mylayout) end,
              {description = "Добавить тег", group = "Тег"}),
    awful.key({ modkey, mod.shift }, "r", function () lain.util.rename_tag() end,
              {description = "Переименновать тег", group = "Тег"}),
    awful.key({ modkey, mod.shift }, "d", function () lain.util.delete_tag() end,
              {description = "Удалить тег", group = "Тег"}),
    awful.key({ modkey, mod.shift }, "F1", function () lain.util.move_tag(-1) end,
              {description = "Переместить тег влево", group = "Тег"}),
    awful.key({ modkey, mod.shift }, "F2", function () lain.util.move_tag(1) end,
              {description = "Переместить тег вправо", group = "Тег"}),
})

-- Resize gaps
awful.keyboard.append_global_keybindings({
awful.key({ modkey, mod.ctrl }, "KP_Add", function () lain.util.useless_gaps_resize(4) end,
              {description = "Увеличить отступы", group = "Планировка"}),
awful.key({ modkey, mod.ctrl }, "KP_Subtract", function () lain.util.useless_gaps_resize(-4) end,
              {description = "Усеньшить отступы", group = "Планировка"}),
})

-- Machi
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, ".",    function () machi.default_editor.start_interactive() end,
               {description = "[ Machi ] Edit the current layout if it is a machi layout", group = "Планировка"}),
    awful.key({ modkey,           }, "/",    function () machi.switcher.start(client.focus) end,
               {description = "[ Machi ] Switch between windows for a machi layout", group = "Планировка"}),
})

-- Retain
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "q",    function () retain.tags.save_all() end,
               {description = "Сохранить", group = "Тег"}),
})
