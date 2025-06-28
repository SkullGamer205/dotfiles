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


local startup_commands = {
  -- Inform dbus about the environment variables
  {
    'dbus-update-activation-environment',
    'DISPLAY',
    'WAYLAND_DISPLAY',
    'XDG_SESSION_TYPE',
    'XDG_CURRENT_DESKTOP',
  },
  {
      'swww-daemon',
  },
  -- Startup programs
  {
    'swayidle',
    'timeout 300 "gtklock"',
  },
  {
    'artix-pipewire-loader',
  },
}

-- Run startup commands

-- 'riverctl spawn ...' always returns (even when the child process is a daemon)
-- so we don't need to resort to posix.unistd.spawn()
for _, cmd in ipairs(startup_commands) do
  os.execute(string.format([[riverctl spawn '%s']], concat(cmd, ' ')))
end
