local awful = require('awful')

return function()
    -- Keyboard map indicator and switcher
    return awful.widget.keyboardlayout()
end
