-- Convenient functions ────────────────────────────────────────────────────────

--[[

NOTE:
- execp() needs 'lua-posix' package
- bitwise operands for tag mappings need Lua version >= 5.3

--]]

-- Wrapper around table.concat() to also handle other types
function concat(...)
  local list, sep, i, j = ...

  if type(list) == 'table' then
    return table.concat(list, sep, i, j)
  else
    return tostring(list)
  end
end

-- All the setting tables ──────────────────────────────────────────────────────

local river_options = {
  -- Theme options
  ['border-width'] = 2,
  ['border-color-focused'] = '0x9DA9A0',
  ['border-color-unfocused'] = '0x4f5b58',
  ['border-color-urgent'] = '0xe67e80',
  ['xcursor-theme'] = { 'Mita Cursor', 14 },
  ['background-color'] = '0x1e2326',
  -- Other options
  ['set-repeat'] = { 50, 300 },
  ['focus-follows-cursor'] = 'normal',
  ['set-cursor-warp'] = 'on-output-change',
  ['attach-mode'] = 'bottom',
  ['default-layout'] = 'rivertile',
  ['keyboard-layout'] = '-options grp:caps_toggle,grp_led:caps us,ru',
}

local gsettings = {
  ['org.gnome.desktop.interface'] = {
    ['gtk-theme'] = 'oomox-xresources',
    ['icon-theme'] = 'oomox-xresources',
    ['cursor-theme'] = river_options['xcursor-theme'][1],
    ['cursor-size'] = river_options['xcursor-theme'][2],
  },
}

-- Apply settings ──────────────────────────────────────────────────────────────

-- GNOME-related settings
for group, tbl in pairs(gsettings) do
  for key, value in pairs(tbl) do
    os.execute(string.format('gsettings set %s %s %s', group, key, value))
  end
end

-- Set river's options
for key, value in pairs(river_options) do
  os.execute(string.format('riverctl %s %s', key, concat(value, ' ')))
end

-- Launch the layout generator as the final initial process.
--
-- River run the init file as a process group leader and send
-- SIGTERM to the group on exit. Therefore, keep the main init
-- process running (replace it with the layout generator process).

os.execute(string.format('rivertile -view-padding 4 -outer-padding 4 -main-location left -main-count 1 -main-ratio 0.66 &'))

