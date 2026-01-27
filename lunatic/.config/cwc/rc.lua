-- cwc default config

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local impl = require("impl")
local config = require("config")

local cwc = cwc

-- config.init should go first before anything else
config.init(require("conf"))

-- execute oneshot.lua once, cwc.is_startup() mark that the configuration is loaded for the first time
if cwc.is_startup() then
    gears.protected_call(require, "oneshot")
end

-- execute keybind script
gears.protected_call(require, "binds")

-- use core implementation
impl.use_core()

-- Treat all signals
require('signal')

