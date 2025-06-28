-- Inputs
local inputs = {
  ['pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad'] = {
    ['events'] = 'disabled-on-external-mouse',
    ['drag'] = 'enabled',
    ['tap'] = 'enabled',
    ['tap-button-map'] = 'left-right-middle',
    ['disable-while-typing'] = 'enabled',
    ['natural-scroll'] = 'enabled',
    ['scroll-method'] = 'two-finger',
  },
}

-- Configure input devices
for device, options in pairs(inputs) do
  for key, val in pairs(options) do
    os.execute(string.format('riverctl input %s %s %s', device, key, val))
  end
end

