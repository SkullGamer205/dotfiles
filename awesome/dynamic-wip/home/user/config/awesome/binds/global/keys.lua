local awful = require('awful')
local gears = require('gears')
local beautiful = require("beautiful")
local menubar = require("menubar")
local mod    = require('binds.mod')
local modkey = mod.modkey
local lain   = require('module.lain')
local apps   = require('config.apps')
local run_shell = require('module.run-shell')
local cyclefocus = require('module.awesome-cyclefocus')

--- Global key bindings
awful.keyboard.append_global_keybindings({
   -- General Awesome keys.
   awful.key({ modkey,           }, 's', require('awful.hotkeys_popup').show_help,
      { description = 'Отобразить \"Шпаргалку\"', group = 'AwesomeWM' }),
   awful.key({ modkey,           }, 'w', function() require('ui.menu') MainMenu:show() end,
      { description = 'Отобразить главное меню', group = 'AwesomeWM' }),
   awful.key({ modkey, mod.ctrl  }, 'r', awesome.restart,
      { description = 'Перезагрузить AwesomeWM', group = 'AwesomeWM' }),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Запустить Lua код: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "Запустить Lua команду", group = "AwesomeWM"}),
   awful.key({ modkey,           }, 'Return', function() awful.spawn(apps.terminal) end,
      { description = 'Открыть терминал', group = 'Лаунчер' }),
    awful.key({ modkey },            "r",     function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/rofi-desktop/rofi-desktop.sh") end,
       {description = "Запустить Rofi-Desktop", group = "Лаунчер"}),
        awful.key({ modkey },            "d",     function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/rofi-drun.sh") end,
              {description = "Запустить Drun", group = "Лаунчер"}),
    awful.key({ modkey }, "p", function() run_shell.launch() end,
              {description = "Запустить менюбар", group = "Лаунчер"}),

   -- Tags related keybindings.
    awful.key({ modkey,           }, "F1",   awful.tag.viewprev,
              {description = "Переключиться на предыдущий тег", group = "Тег"}),
    awful.key({ modkey,           }, "F2",  awful.tag.viewnext,
              {description = "Переключиться на следующий тег", group = "Тег"}),

   -- Focus related keybindings.
   awful.key({ modkey,           }, 'j', function() awful.client.focus.byidx( 1) end,
      { description = 'Переключиться на следующее окно', group = 'Клиент' }),
   awful.key({ modkey,           }, 'k', function() awful.client.focus.byidx(-1) end,
      { description = 'Переключиться на предыдущее окно', group = 'Клиент'}),
   awful.key({ modkey,           }, "Tab", function ()cyclefocus.cycle({modifier="Super_L"}) end,
      {description = "Переключить окна", group = "Клиент"}),
   awful.key({ modkey, mod.shift }, "Tab", function ()cyclefocus.cycle({modifier="Super_L"}) end,
      {description = "Переключить окна", group = "Клиент"}),
   awful.key({ modkey, mod.ctrl }, 'j', function() awful.screen.focus_relative( 1) end,
      { description = 'Переключиться на следующий экран', group = 'Экран' }),
   awful.key({ modkey, mod.ctrl }, 'k', function() awful.screen.focus_relative(-1) end,
      { description = 'Переключиться на предыдущий экран', group = 'Экран' }),
   awful.key({ modkey, mod.ctrl }, 'n', function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
         c:activate { raise = true, context = 'key.unminimize' }
      end
      end, { description = 'вернуть свёрнутое окно', group = 'Клиент' }),

   -- Layout related keybindings.
   awful.key({ modkey, mod.shift }, 'j', function() awful.client.swap.byidx( 1) end,
      { description = 'Поменять местами следующий клиент', group = 'Клиент' }),
   awful.key({ modkey, mod.shift }, 'k', function() awful.client.swap.byidx(-1) end,
      { description = 'Поменять местами предыдущий клиент', group = 'Клиент' }),
   awful.key({ modkey,           }, 'u', awful.client.urgent.jumpto,
      { description = 'Перейти к важному окну', group = 'Клиент' }),
   awful.key({ modkey,           }, 'l', function() awful.tag.incmwfact( 0.05) end,
      { description = 'Увеличить главное окно', group = 'Планировка' }),
   awful.key({ modkey,           }, 'h', function() awful.tag.incmwfact(-0.05) end,
      { description = 'Уменьшить главное окно', group = 'Планировка' }),
   awful.key({ modkey, mod.shift }, 'h', function() awful.tag.incnmaster( 1, nil, true) end,
      { description = 'Увеличить число главных окон', group = 'Планировка' }),
   awful.key({ modkey, mod.shift }, 'l', function() awful.tag.incnmaster(-1, nil, true) end,
      { description = 'Уменьшить число главных окон', group = 'Планировка' }),
   awful.key({ modkey, mod.ctrl  }, 'h', function() awful.tag.incncol( 1, nil, true) end,
      { description = 'Увеличить количество колонн', group = 'Планировка' }),
   awful.key({ modkey, mod.ctrl  }, 'l', function() awful.tag.incncol(-1, nil, true) end,
      { description = 'Уменьшить количество колонн', group = 'Планировка' }),
   awful.key({
      modifiers   = { modkey },
      keygroup    = 'numrow',
      description = 'Отобразить тег',
      group       = 'Тег',
      on_press    = function(index)
         local tag = awful.screen.focused().tags[index]
         if tag then tag:view_only() end
      end
   }),
   awful.key({
      modifiers   = { modkey, mod.ctrl },
      keygroup    = 'numrow',
      description = 'Переключить тег',
      group       = 'Тег',
      on_press    = function(index)
         local tag = awful.screen.focused().tags[index]
         if tag then awful.tag.viewtoggle(tag) end
      end
   }),
   awful.key({
      modifiers   = { modkey, mod.shift },
      keygroup    = 'numrow',
      description = 'Переместить активное окно в тег',
      group       = 'Тег',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then client.focus:move_to_tag(tag) end
         end
      end
   }),
   awful.key({
      modifiers   = { modkey, mod.ctrl, mod.shift },
      keygroup    = 'numrow',
      description = 'Переключить активное окно в теге',
      group       = 'Тег',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then client.focus:toggle_tag(tag) end
         end
      end
   }),
   awful.key({
      modifiers   = { modkey },
      keygroup    = 'numpad',
      description = 'Выбрать планировку',
      group       = 'Планировка',
      on_press    = function(index)
         local t = awful.screen.focused().selected_tag
         if t then
            t.layout = t.layouts[index] or t.layout
         end
      end
   })
})
