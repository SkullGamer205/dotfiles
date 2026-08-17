local awful = require("awful")

local helpers = {}

function helpers.table_to_keybinding(bindings)
  local key_bindings = {}
  for _, g_key in ipairs(bindings) do
    table.insert(key_bindings, awful.key(g_key[1], g_key[2], g_key[3], { description = g_key[4], group = g_key[5] }))
  end
  return key_bindings
end

return helpers
