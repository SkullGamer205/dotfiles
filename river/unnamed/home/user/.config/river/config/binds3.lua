-- Convenient functions ────────────────────────────────────────────────────────

-- Wrapper around table.concat() to also handle other types
function concat(...)
  local list, sep, i, j = ...

  if type(list) == 'table' then
    return table.concat(list, sep, i, j)
  else
    return tostring(list)
  end
end

local drun_menu = 'rofi -show drun'
local run_menu = 'rofi -show run'

-- Additional modes and their mappings to switch between them and 'normal' mode
--
-- name: string (the name of the additional mode)
-- mod: string|list (modifiers for key binding, concanated by '+')
-- key: string
local modes = {
  {
    name = 'passthrough',
    from = 'normal',
    mod = 'None',
    key = 'Escape',
  },
  {
    name = 'passthrough',
    from = 'launcher',
    mod = 'None',
    key = 'Escape',
  },
  {
    name = 'passthrough',
    from = 'layout',
    mod = 'None',
    key = 'Escape',
  },
  {
    name = 'normal',
    from = 'passthrough',
    mod = 'None',
    key = 'Super_L',
  },
  {
    name = 'launcher',
    from = 'normal',
    mod = 'None',
    key = 'R',
  },
  {
    name = 'layout',
    from = 'normal',
    mod = 'None',
    key = 'V',
  },
}

-- Each mapping contains 4 keys:
--
-- mod: string|list (modifiers, concanated by '+')
-- key: string
-- command: string|list (the command passed to riverctl)
-- opt: string ('release' or 'repeat')
local mappings = {
  -- Key bindings
  map = {
    normal = {
      -- Super+Q to close the focused view
      {
        mod = 'Super',
        key = 'Q',
        command = 'close',
      },
      -- Super+Shift+Q to exit river (requires 'swaynag' program from sway)
      {
        mod = { 'Super', 'Shift' },
        key = 'Q',
        command = { 'spawn', [['swaynag -t warning -m "Exit river?" -b "Yes" "riverctl exit"']] },
      },
      -- Super+Shift+X to lock the screen
      {
        mod = { 'Super', 'Shift' },
        key = 'X',
        command = { 'spawn', 'swaylock' },
      },
      -- Super+{J,K} to focus next/previous view in the layout stack
      {
        mod = 'Super',
        key = 'J',
        command = { 'focus-view', 'previous' },
      },
      {
        mod = 'Super',
        key = 'K',
        command = { 'focus-view', 'next' },
      },
      -- Super+Shift+{J,K} to swap focused view with the next/previous view in the layout stack
      {
        mod = { 'Super', 'Shift' },
        key = 'J',
        command = { 'swap', 'previous' },
      },
      {
        mod = { 'Super', 'Shift' },
        key = 'K',
        command = { 'swap', 'next' },
      },
      -- Super+{P,N} to focus next/previous output
      {
        mod = 'Super',
        key = 'P',
        command = { 'focus-output', 'previous' },
      },
      {
        mod = 'Super',
        key = 'N',
        command = { 'focus-output', 'next' },
      },
      -- Super+Shift+{P,N} to send the focused view to next/previous output
      {
        mod = { 'Super', 'Shift' },
        key = 'P',
        command = { 'send-to-output', 'previous' },
      },
      {
        mod = { 'Super', 'Shift' },
        key = 'N',
        command = { 'send-to-output', 'next' },
      },
      -- Super+E to bump the focused view to the top of the layout stack
      {
        mod = 'Super',
        key = 'E',
        command = 'zoom',
      },
      -- Super+Alt+{H,J,K,L} to move views (floating)
      {
        mod = { 'Super', 'Alt' },
        key = 'H',
        command = { 'move', 'left', 100 },
      },
      {
        mod = { 'Super', 'Alt' },
        key = 'J',
        command = { 'move', 'down', 100 },
      },
      {
        mod = { 'Super', 'Alt' },
        key = 'K',
        command = { 'move', 'up', 100 },
      },
      {
        mod = { 'Super', 'Alt' },
        key = 'L',
        command = { 'move', 'right', 100 },
      },
      -- Super+Alt+Control+{H,J,K,L} to snap views to screen edges
      {
        mod = { 'Super', 'Alt', 'Control' },
        key = 'H',
        command = { 'snap', 'left' },
      },
      {
        mod = { 'Super', 'Alt', 'Control' },
        key = 'J',
        command = { 'snap', 'down' },
      },
      {
        mod = { 'Super', 'Alt', 'Control' },
        key = 'K',
        command = { 'snap', 'up' },
      },
      {
        mod = { 'Super', 'Alt', 'Control' },
        key = 'L',
        command = { 'snap', 'right' },
      },
      -- Super+Space to toggle float
      {
        mod = 'Super',
        key = 'Space',
        command = 'toggle-float',
      },
      -- Super+F to toggle fullscreen
      {
        mod = 'Super',
        key = 'F',
        command = 'toggle-fullscreen',
      },
      {
      mod = { 'Super', 'Shift' },
      key = 'R',
      command = { 'spawn', string.format([['%s/.config/river/init']], os.getenv("$HOME") ) }, 
      },
  },
  launcher = {
      -- Terminal emulator
      {
        mod = 'None',
        key = 'T',
        command = { 'spawn', 'foot' },
      },
      -- Application launcher
      {
        mod = 'None',
        key = 'M',
        command = { 'spawn', string.format([['%s']], drun_menu) },
      },
      {
        mod = 'None',
        key = 'R',
        command = { 'spawn', string.format([['lua %s/.config/river/init']], os.getenv("HOME") ) }, 
      },
  },
  layout = {
      -- Super+{H,L} to decrease/increase the main_factor value of rivertile by 0.02
      {
        mod = 'None',
        key = 'H',
        command = { 'send-layout-cmd', 'rivertile', [['main-ratio -0.02']] },
      },
      {
        mod = 'None',
        key = 'L',
        command = { 'send-layout-cmd', 'rivertile', [['main-ratio +0.02']] },
      },
      -- M+{H,L} to increment/decrement the main_count value of rivertile
      {
        mod = 'Shift',
        key = 'H',
        command = { 'send-layout-cmd', 'rivertile', [['main-count +1']] },
      },
      {
        mod = 'Shift',
        key = 'L',
        command = { 'send-layout-cmd', 'rivertile', [['main-count -1']] },
      },
      -- Control+Alt+{H,J,K,L} to change layout orientation
      {
        mod = 'Control',
        key = 'H',
        command = { 'send-layout-cmd', 'rivertile', [['main-location left']] },
      },
      {
        mod = 'Control',
        key = 'J',
        command = { 'send-layout-cmd', 'rivertile', [['main-location bottom']] },
      },
      {
        mod = 'Control',
        key = 'K',
        command = { 'send-layout-cmd', 'rivertile', [['main-location top']] },
      },
      {
        mod = 'Control',
        key = 'L',
        command = { 'send-layout-cmd', 'rivertile', [['main-location right']] },
      },
       -- Super+Control+{H,J,K,L} to resize views
      {
        mod = { 'Shift', 'Control' },
        key = 'H',
        command = { 'resize', 'horizontal', -100 },
      },
      {
        mod = { 'Shift', 'Control' },
        key = 'J',
        command = { 'resize', 'vertical', 100 },
      },
      {
        mod = { 'Shift', 'Control' },
        key = 'K',
        command = { 'resize', 'vertical', -100 },
      },
      {
        mod = { 'Shift', 'Control' },
        key = 'L',
        command = { 'resize', 'horizontal', 100 },
      },
 },
    locked = {
      -- Eject optical drives
      {
        mod = 'None',
        key = 'XF86Eject',
        command = { 'spawn', [['eject -T']] },
      },
      -- Control MPRIS aware media players with 'playerctl'
      {
        mod = 'None',
        key = 'XF86AudioMedia',
        command = { 'spawn', [['playerctl play-pause']] },
      },
      {
        mod = 'None',
        key = 'XF86AudioPlay',
        command = { 'spawn', [['playerctl play-pause']] },
      },
      {
        mod = 'None',
        key = 'XF86AudioPrev',
        command = { 'spawn', [['playerctl previous']] },
      },
      {
        mod = 'None',
        key = 'XF86AudioNext',
        command = { 'spawn', [['playerctl next']] },
      },
      -- Audio 
      {
        mod = 'None',
        key = 'XF86AudioLowerVolume',
        command = { 'spawn', [['pactl set-sink-volume @DEFAULT_SINK@ -5%']] },
      },
      {
        mod = 'None',
        key = 'XF86AudioRaiseVolume',
        command = { 'spawn', [['pactl set-sink-volume @DEFAULT_SINK@ +5%']] },
      },
      {
        mod = 'None',
        key = 'XF86AudioMute',
        command = { 'spawn', [['pactl set-sink-mute @DEFAULT_SINK@ toggle']] },
      },
      {
        mod = 'None',
        key = 'XF86AudioMicMute',
        command = { 'spawn', [['pactl set-source-mute @DEFAULT_SOURCE@ toggle']] },
      },
      -- Brightness
      {
        mod = 'None',
        key = 'XF86MonBrightnessDown',
        command = { 'spawn', [['brightnessctl set 5%-']] },
      },
      {
        mod = 'None',
        key = 'XF86MonBrightnessUp',
        command = { 'spawn', [['brightnessctl set +5%']] },
      },
      -- Screenshot
      {
        mod = 'None',
        key = 'Print',
        command = { 'spawn', [['$HOME/.config/river/scripts/grim.sh -f']] },
      },
      {
        mod = 'Shift',
        key = 'Print',
        command = { 'spawn', [['$HOME/.config/river/scripts/grim.sh -a']] },
      },
    },
  },
  -- Mappings for pointer (mouse)
  ['map-pointer'] = {
    normal = {
      -- Super + Left Mouse Button to move views
      {
        mod = 'Super',
        key = 'BTN_LEFT',
        command = 'move-view',
      },
      -- Super + Right Mouse Button to resize views
      {
        mod = 'Super',
        key = 'BTN_RIGHT',
        command = 'resize-view',
      },
    },
  },
}

-- These mappings are repeated, so they are separated from the mappings table
local function tag_mappings()
  for i = 1, 9 do
    local tag_num = 1 << (i - 1)

    -- Super+[1-9] to focus tag [0-8]
    os.execute(string.format('riverctl map normal None %s set-focused-tags %s', i, tag_num))

    -- Super+Shift+[1-9] to tag focused view with tag [0-8]
    os.execute(string.format('riverctl map normal Super+Shift %s set-view-tags %s', i, tag_num))

    -- Super+Control+[1-9] to toggle focus of tag [0-8]
    os.execute(string.format('riverctl map normal Super+Control %s toggle-focused-tags %s', i, tag_num))

    -- Super+Alt+[1-9] to toggle tag [0-8] of focused view
    os.execute(string.format('riverctl map normal Super+Alt %s toggle-view-tags %s', i, tag_num))
  end

  -- river has a total of 32 tags
  local all_tags = (1 << 32) - 1
  os.execute(string.format('riverctl map normal Super 0 set-focused-tags %s', all_tags))
  os.execute(string.format('riverctl map normal Super+Shift 0 set-view-tags %s', all_tags))
end

-- Additional modes (beside 'normal' and 'locked')
for _, mode in ipairs(modes) do
  local mode_name = mode.name
  local modifiers = concat(mode.mod, '+')

  -- Declare the mode
  os.execute('riverctl declare-mode ' .. mode_name)

  -- Setup key bindings to enter/exit the mode
  os.execute(string.format('riverctl map %s %s %s enter-mode %s', mode.from , modifiers, mode.key, mode_name))
end

-- Keyboard and mouse bindings
for map_type, tbl in pairs(mappings) do
  for mode, value in pairs(tbl) do
    for _, binding in ipairs(value) do
      local modifiers = concat(binding.mod, '+')
      local cmd = concat(binding.command, ' ')

      -- Options -release and -repeat for 'map' and 'unmap' commands
      local opt = binding.opt
      if opt ~= 'release' and opt ~= 'repeat' then
        opt = ''
      else
        opt = '-' .. opt
      end

      os.execute(string.format('riverctl %s %s %s %s %s %s', map_type, opt, mode, modifiers, binding.key, cmd))

      -- Duplicate mappings of mode 'locked' for mode 'normal'
      if mode == 'locked' then
        os.execute(string.format('riverctl %s %s normal %s %s %s', map_type, opt, modifiers, binding.key, cmd))
      end
    end
  end
end

-- Mappings for tag management
tag_mappings()
