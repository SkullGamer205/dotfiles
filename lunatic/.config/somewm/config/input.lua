local awful     = require("awful")
local kbd       = require("config.user").keyboard

-- Global defaults (apply to all devices unless overridden by rules)
awful.input.xkb_layout                  = kbd.layout        or "us"
awful.input.xkb_variant                 = kbd.variant       or nil
awful.input.xkb_options                 = kbd.options       or nil
awful.input.xkb_model                   = kbd.model         or nil
awful.input.keyboard_repeat_rate        = kbd.set_repeat[1] or 25
awful.input.keyboard_repeat_delay       = kbd.set_repeat[2] or 600
