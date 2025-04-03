package.loaded.net_widgets = nil

local net_widgets = {
    indicator   = require(...  .. ".indicator"),
    wireless    = require(...  .. ".wireless"),
    internet    = require(...  .. ".internet")
}

return net_widgets
