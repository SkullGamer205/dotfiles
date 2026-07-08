local awful = require('awful')

return function()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    return awful.widget.prompt()
end
