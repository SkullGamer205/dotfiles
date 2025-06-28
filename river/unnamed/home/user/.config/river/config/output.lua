-- Configure outputs

local outputs = {
  ['eDP-1'] = {
    ['custom-mode'] = '1920x1080@75',
    pos = '1920,0',
    transform = 'normal',
    scale = '1.000000',
    preferred = false,
  },
    ['HDMI-A-1'] = {
    ['custom-mode'] = '1920x1080@75',
    pos = '0,0',
    transform = 'normal',
    scale = '1.000000',
    preferred = false,
  },
}

-- Configure outputs
local randr_cmd = 'wlr-randr'
for output, options in pairs(outputs) do
  randr_cmd = randr_cmd .. ' --output ' .. output

  for opt, value in pairs(options) do
    if opt ~= 'preferred' then
      randr_cmd = string.format(randr_cmd .. ' --%s %s', opt, value)
    end
  end

  -- Ensure '--preferred' is the last argument for each monitor
  if options.preferred then
    randr_cmd = randr_cmd .. ' --preferred'
  end
end
os.execute(randr_cmd)
