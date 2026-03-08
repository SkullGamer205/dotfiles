local astal3 = require('astal.gtk3')
local App = astal3.App
local Widget = astal3.Widget

local wifi = require(... .. '.wifi')
local blue = require(... .. '.bluetooth')

return function()
    return Widget.Box({
        vertical = true,
        wifi(),
        blue(),
    })
end
