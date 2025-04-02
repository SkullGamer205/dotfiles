local awful = require("awful")
local gears = require('gears')
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps   = require('config.apps')
local run_shell = require('module.run-shell')

local launcher_commands = {
  {
    description = "| Отобразить \"Шпаргалку\"",
    pattern = {'h'},
    handler = function() hotkeys_popup.show_help() end
  },
  {
    description = "| Перезагрузить AwesomeWM",
    pattern = {'r'},
    handler = function() awesome.restart() end
  },
--  {
--    description = "quit awesome",
--    pattern = {'Q'},
--    handler = function() awesome.quit() end
--  },
  {
    description = "| Запустить Lua код:",
    pattern = {'x'},
    handler = function()
      awful.prompt.run {
        prompt       = "Введите Lua код: ",
        textbox      = awful.screen.focused().mypromptbox.widget.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
  },
  {
    description = "| Открыть терминал",
    pattern = {'t'},
    handler = function() awful.spawn(apps.terminal) end
  },
  {
    description = "| Запустить менюбар",
    pattern = {'m'},
    handler = function() run_shell.launch()  end
  },
  {
    description = "| Запустить Rofi-Desktop",
    pattern = {'M'},
    handler = function() awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/rofi-desktop/rofi-desktop.sh")end
  },
  {
    description = "| Запустить браузер",
    pattern = {'f','f'},
    handler = function() awful.spawn(apps.browser)  end
  },
  {
    description = "| Запустить LibreOffice",
    pattern = {'l', 'o'},
    handler = function() awful.spawn(apps.office)  end
  },
  {
    description = "| Запустить текстовый редактор",
    pattern = {'e'},
    handler = function() awful.spawn(apps.editor_cmd)  end
  },
  {
    pattern = {'i'},
    handler = function(mode) mode.stop() end
  },
}

return launcher_commands
