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
    'timeout 300 "$XDG_CONFIG_HOME/river/scripts/gtklock.sh"',
  },
  {
    'artix-pipewire-loader',
  },
  {
    'mpd',
  },
  {
    'mpd-mpris',
    '-no-instance',
  },
}

-- Run startup commands
-- 'riverctl spawn ...' always returns (even when the child process is a daemon)
-- so we don't need to resort to posix.unistd.spawn()
local filename = "/tmp/river-autostart"
local f_lock = io.open(filename, "r")

if f_lock then
    io.close(f_lock)
    print("[ERROR]: ", filename, "exists. Autostart will abort.")
    return 0
else
    f_lock = io.open(filename, "w")
    print("[DONE]: ", filename, "hook created.")
    for _, cmd in ipairs(startup_commands) do
        os.execute(string.format([[riverctl spawn '%s']], concat(cmd, ' ')))
    end
    io.close(f_lock)
end
