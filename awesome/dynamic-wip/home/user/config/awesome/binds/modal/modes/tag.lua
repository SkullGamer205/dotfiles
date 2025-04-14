local awful  = require('awful')
local gears  = require("gears")
local lain   = require('module.lain')
local retain = require('module.awesome-retain')
local machi  = require('module.layout-machi')
local cyclefocus  = require('module.awesome-cyclefocus')
local grect = require("gears.geometry").rectangle
local gfind = require("gears.table").find_keys

-- helper function used by some bindings which manipulate tags
local function find_tag(func)
  return function(_, ...)
    local screen, count, movement = awful.screen.focused(), select(-2, ...)
    local showntags = gfind(screen.tags, function(_, t) return not t.hide end, true)
    local index = (screen.selected_tag or {}).index
    count = count == '' and 1 or tonumber(count)

    if movement == 'g' then
      index = count
    elseif movement == 'f' and index then
      index = ((index - 1 + count) % #showntags) + 1
    elseif movement == 'b' and index then
      index = ((index - 1 - count) % #showntags) + 1
    end

    if index and screen.tags[showntags[index]] then
      func(screen.tags[showntags[index]])
    end
  end
end

local tag_commands = {
  {
    description = " │ Сменить фокус",
    pattern = {'%d*', '[hjkl]'},
    handler = function(_, count, movement)
      local directions = {h = 'left', j = 'down', k = 'up', l = 'right'}
      count = count == '' and 1 or tonumber(count)

      for _ = 1, count do
        awful.client.focus.bydirection(directions[movement])
      end
    end
  },
  {
    description = " │ Сменить фокус",
    pattern = {'Tab'},
    handler = function(mode) mode.stop() end, function(c) cyclefocus.cycle({modifier=alt}) end
  },
  {
    description = "   │ Переключиться на пред. / след. экран",
    pattern = {'%d*', '[ey]'},
    handler = function(_, count, movement)
      count = count == '' and 1 or tonumber(count)

      if movement == 'e' then
        awful.screen.focus_relative(count)
      else
        awful.screen.focus_relative(-count)
      end
    end
  },
  {
    description = "│ Поменять окна местами",
    pattern = {'m', '%d*', '[hjkl]'},
    handler = function(_, _, count, movement)
      local directions = {h = 'left', j = 'down', k = 'up', l = 'right'}
      local sel = client.focus
      local scr = sel.screen
      count = count == '' and 1 or tonumber(count)

      -- this is a bit hacky, but awful.client.swap.bydirection doesn't work as expected
      if sel then
        local clients = scr.clients
        local geometries = {}
        for i,cl in ipairs(clients) do
          geometries[i] = cl:geometry()
        end

        local current = sel
        for _ = 1, count do
          local target = grect.get_in_direction(directions[movement], geometries, current:geometry())

          -- If we found a client to swap with, then go for it
          if target then
            current = clients[target]
            current:swap(sel)
          else
            break
          end
        end
      end
    end
  },
  {
    description = "         │ Перейти к важному окну",
    pattern = {'x'},
    handler = function() awful.client.urgent.jumpto() end
  },
  {
    description = "  │ Перемеситься к тегу",
    pattern = {'%d*', '[gfb]'},
    handler = find_tag(awful.tag.object.view_only)
  },
  {
    description = " │ Переключить тег",
    pattern = {'t', '%d*', '[gfb]'},
    handler = find_tag(awful.tag.viewtoggle)
  },
  {
    description = " │ Переместить активное окно в тег",
    pattern = {'m', '%d*', '[gfb]'},
    handler = find_tag(function(tag)
      local c = client.focus
      if c then
        c:move_to_tag(tag)
      end
    end)
  },
  {
    description = " │ Переключить активное окно в теге",
    pattern = {'c', '%d*', '[gfb]'},
    handler = find_tag(function(tag)
      local c = client.focus
      if c then
        c:toggle_tag(tag)
      end
    end)
  },
  {
    description = "        │ Переместить на главный план",
    pattern = {'m', 'm'},
    handler = function()
      local c, m = client.focus, awful.client.getmaster()
      if c and m then
        c:swap(m)
      end
    end
  },
  {
    description = "  │ Переместить окно на пред. след. экран",
    pattern = {'m', '%d*', '[ey]'},
    handler = function(_, _, count, movement)
      local c = client.focus
      count = count == '' and 1 or tonumber(count)

      if c then
        if movement == 'e' then
          c:move_to_screen(c.screen.index + count)
        else
          c:move_to_screen(c.screen.index - count)
        end
      end
    end
  },
  {
    description = "         │ Закрыть окно",
    pattern = {'q'},
    handler = function()
      local c = client.focus
      if c then
        c:kill()
      end
    end
  },
  {
    description = "        │ Переключить плавающий режим",
    pattern = {'p', 'h'},
    handler = function()
      local c = client.focus
      if c then
        c.floating = not c.floating
      end
    end
  },
  {
    description = "        │ Переключить режим \"Поверх всех окон\"",
    pattern = {'p', 'o'},
    handler = function()
      local c = client.focus
      if c then
        c.ontop = not c.ontop
      end
    end
  },
  {
    description = "        │ Переключить \"липкий\" режим",
    pattern = {'p', 's'},
    handler = function()
      local c = client.focus
      if c then
        c.sticky = not c.sticky
      end
    end
  },
  {
    description = "        │ Переключить полноэкранный режим",
    pattern = {'p', 'f'},
    handler = function()
      local c = client.focus
      if c then
        c.fullscreen = not c.fullscreen
        c:raise()
      end
    end
  },
  {
    description = "        │ (Раз-)вернуть",
    pattern = {'p', 'm'},
    handler = function()
      local c = client.focus
      if c then
        c.maximized = not c.maximized
        c:raise()
      end
    end
  },
  {
    description = "         │ Свернуть",
    pattern = {'n'},
    handler = function()
      local c = client.focus
      if c then
        c.minimized = true
      end
    end
  },
  {
    description = "         │ Вернуть окно",
    pattern = {'u'},
    handler = function()
        local c = awful.client.restore()
        if c then
            client.focus = c
            c:raise()
        end
    end,
  },
  {
    description = "        │ Вернуться на прошлый тег",
    pattern = {'z', 't'},
    handler = function()
      awful.tag.history.restore()
    end
  },
  {
    description = "        │ Вернуться на прошлое окно",
    pattern = {'z', 'c'},
    handler = function()
      awful.client.focus.history.previous()
      if client.focus then
          client.focus:raise()
      end
    end
  },

  -- Lain Tags
  {
    description = "         │ Добавить тег",
    pattern = {'a'},
    handler = function(mode) lain.util.add_tag(mylayout) end
  },
  {
    description = "         │ Удалить тег",
    pattern = {'d'},
    handler = function(mode) lain.util.delete_tag() end
  },
  {
    description = "         │ Переименновать тег",
    pattern = {'e'},
    handler = function(mode) lain.util.rename_tag() end
  },

  {
    description = "  │ Переместить тег влево/вправо",
    pattern = {'s', '%d*', '[fb]'},
    handler = function(movement)
    if movement == 'f' then
           lain.util.move_tag(1)
        else
           lain.util.move_tag(-1)
        end
    end
  },

  -- Change mode
  {
    description = "         │ Перейти в client mode",
    pattern = {'i'},
    handler = function(mode) mode.stop() end
  },
  {
    description = "         │ Перейти в launcher mode",
    pattern = {'r'},
    handler = function(mode) mode.start("launcher") end
  },
  {
    description = "         │ Перейти в layout mode",
    pattern = {'v'},
    handler = function(mode) mode.start("layout") end
  },
  {
    description = "         │ Перейти в Player Mode",
    pattern = {'P'},
    handler = function(mode) mode.start("player") end
  },
}

return tag_commands
