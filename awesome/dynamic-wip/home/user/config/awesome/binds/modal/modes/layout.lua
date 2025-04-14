local awful = require("awful")

local layout_commands = {
  {
    description = "    │ Изменить высоту окна",
    pattern = {'[jk]'},
    handler = function(_, movement)
      if movement == 'j' then
        awful.client.incwfact(-0.05)
      else
        awful.client.incwfact(0.05)
      end
    end
  },
  {
    description = "    │ Изменить ширину главного окна",
    pattern = {'[hl]'},
    handler = function(_, movement)
      if movement == 'h' then
        awful.tag.incmwfact(-0.05)
      else
        awful.tag.incmwfact(0.05)
      end
    end
  },
  {
    description = "│ Изменить количество главных окон",
    pattern = {'m', '%d*', '[fb]'},
    handler = function(_, _, count, movement)
      count = count == '' and 1 or tonumber(count)

      if movement == 'f' then
        awful.tag.incnmaster(count, nil, true)
      else
        awful.tag.incnmaster(-count, nil, true)

      end

    end
  },
  {
    description = "│ Изменить колиество столбцов",
    pattern = {'c', '%d*', '[fb]'},
    handler = function(_, _, count, movement)
      count = count == '' and 1 or tonumber(count)

      if  movement == 'f' then
        awful.tag.incncol(count, nil, true)
      else
        awful.tag.incncol(-count, nil, true)
      end
    end
  },
  {
    description = " │ Изменить планировку окон",
    pattern = {'%d*', '[fb]'},
    handler = function(_, count, movement)
      count = count == '' and 1 or tonumber(count)

      if  movement == 'f' then
        awful.layout.inc(count)
      else
        awful.layout.inc(-count)
      end
    end
  },
  {
    description = "│ Изменить размер зазоров",
    pattern = {'g', '%d*', '[fb]'},
    handler = function(_, _, count, movement)
      count = count == '' and 1 or tonumber(count)

      if  movement == 'f' then
        awful.tag.incgap(count)
      else
        awful.tag.incgap(-count)
      end
    end
  },
  {
    description = "       │ Перейти в client modeш",
    pattern = {'i'},
    handler = function(mode) mode.stop() end
  },
}

return layout_commands
