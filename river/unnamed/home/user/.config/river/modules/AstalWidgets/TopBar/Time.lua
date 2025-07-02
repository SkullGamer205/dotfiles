local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local GLib = astal.require("GLib")
local Variable = astal.Variable

return function(format)
	local time = Variable(""):poll(
		1000,
		function() return GLib.DateTime.new_now_local():format(format) end
	)

	return Widget.Label({
		class_name = "Time",
		on_destroy = function() time:drop() end,
		label = time(),
	})
end
