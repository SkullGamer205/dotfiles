local App = require("astal.gtk3.app")
local Bar = require("widget.Bar")

App:start {
    instance_name = "bar",
    class_name = "bar",
    main = function()
        Bar(0)
    end,
}
