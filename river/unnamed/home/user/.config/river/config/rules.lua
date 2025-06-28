-- Window Rules

local window_rules = {
  ['float'] = {
    ['app-id'] = {
      'float',
      'popup',
      'swappy',
      'pinentry-qt',
      'pavucontrol-qt',
    },
    ['title'] = {
      'Picture-in-Picture',
      -- 'About *',
    },
  },
  ['ssd'] = {
    ['app-id'] = { '"*"' },
  },
}

-- Window rules (float/csd filters)
for key, value in pairs(window_rules) do
  for type, patterns in pairs(value) do
    for _, pattern in ipairs(patterns) do
      os.execute(string.format('riverctl rule-add -%s %s %s', type, pattern, key))
      -- print(string.format('riverctl rule-add -%s %s %s', type, pattern, key))
    end
  end
end

