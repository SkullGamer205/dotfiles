-- Some function grabbed from this file:  raw.githubusercontent.com/sewergweller/gwileful/refs/heads/master/ui/launcher/init.lua

-- Launcher
local wibox         = require('wibox')
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local gio           = require('lgi').Gio

local dpi           = beautiful.xresources.apply_dpi

local SimplePopup   = require('module.simple_widgets.popup').create
local SimpleBox     = require('module.simple_widgets.box').create_box
local SimpleIcon    = require('module.simple_widgets.image').create_icon

-- States
local state = {    
    search_text     = "",
    selected_index  = 1,
    filtered_apps   = {},
    all_apps        = {},
}

-- Config
local config = {
    max_results = 8,
    max_width   = 512,
}

_Widgets = {}

_Widgets.prompt  = wibox.widget.textbox('Search')
_Widgets.search_bar = SimpleBox(_Widgets.prompt, {
    margin  =  dpi(2),
})

_Widgets.entries = wibox.widget({
    layout      = wibox.layout.fixed.vertical,
    expand      = true
})

local function create_launcher_widget()
    return wibox.widget({
        widget  = wibox.container.place,
        halign  = center,
        valign  = center,
        {
            widget      = wibox.container.background,
            bg          = beautiful.bg_normal,
            {
                layout  = wibox.layout.fixed.vertical,
                _Widgets.search_bar,
                _Widgets.entries,
            }
        }
    })
end

--- App related
---------------
local _Apps= {}

-- Gets all entries.
function _Apps.gen()
   local entry_list = {}
   for _, entry in ipairs(gio.AppInfo.get_all()) do
      if entry:should_show() then
         local name =
            entry:get_name():gsub("&", "&amp;"):gsub("<", "&lt;"):gsub("'", "&#39;")
         table.insert(entry_list, { name = name, appinfo = entry })
      end
   end
   return entry_list
end

-- Reduces shown entries to those matching the user's input, sorted and merged into one
-- table.
function _Apps.filter(cmd)
   _Apps.filtered = {}
   _Apps.reg_filtered = {}

   -- Filter entries matching `cmd` (user's input).
   for _, entry in ipairs(_Apps.unfiltered) do
      if entry.name:lower():sub(1, cmd:len()) == cmd:lower() then
         table.insert(_Apps.filtered, entry)
      elseif entry.name:lower():match(cmd:lower()) then
         table.insert(_Apps.reg_filtered, entry)
      end
   end
   -- Sort remaining entries.
   table.sort(_Apps.filtered, function(a, b) return a.name:lower() < b.name:lower() end)
   table.sort(_Apps.reg_filtered, function(a, b) return a.name:lower() < b.name:lower() end)
   -- Merge entries.
   for i = 1, #_Apps.reg_filtered do
      _Apps.filtered[#_Apps.filtered + 1] = _Apps.reg_filtered[i]
   end
   -- Clear entries.
   _Widgets.entries:reset()
   _Apps.entry_index, _Apps.start_index = 1, 1

   -- Add filtered entries.
   for i, entry in ipairs(_Apps.filtered) do
      local widget = wibox.widget({
         widget = wibox.container.background,
         -- bg     = color.bg1,
         -- fg     = color.fg0,
         border_width = dpi(1),
         -- border_color = color.bg1,
         {
            widget  = wibox.container.margin,
            margins = {
               top = dpi(6), bottom = dpi(6),
               left = dpi(12), right = dpi(12)
            },
            wibox.widget.textbox(entry.name)
         }
      })

      widget.visible = (_Apps.start_index <= i and i <= _Apps.start_index + config.max_results - 1)
      _Widgets.entries:add(widget)
      if i == _Apps.entry_index then
         -- widget.fg = color.accent
         -- widget.border_color = color.bg3
      end
   end

   collectgarbage('collect')
end

function _Apps.open(w)
   -- Reset everything.
   _Apps.start_index, _Apps.entry_index = 1, 1
   -- Gets all entries.
   _Apps.unfiltered = _Apps.gen()
   _Apps.filter('')

   -- Populates prompt and makes it responsive.
   awful.prompt.run({
      prompt  = 'Searching: ',
      textbox = _Widgets.prompt,
      -- Upon modifying the contents of the prompt.
      changed_callback = function(cmd)
         local input = cmd:gsub("[%[%]%(%)%.%-%+%?%*%%]", "%%%1")
         _Apps.filter(input)
      end,
      -- Upon pressing enter.
      exe_callback = function(cmd)
         w.hide()
         local entry = _Apps.filtered[_Apps.entry_index]
         if entry then
            entry.appinfo:launch()
         else
            awful.spawn.with_shell(cmd)
         end
      end,
      -- When all else is done.
      done_callback = function()
         w.hide()
      end
   })
end


local launchermenu = SimplePopup('launchermenu', {
    main_widget         = create_launcher_widget,
    placement           = awful.placement.maximize,
    enable_keygrabber   = false,

    on_show     = function(w) _Apps.open(w) end,
})

return launchermenu
