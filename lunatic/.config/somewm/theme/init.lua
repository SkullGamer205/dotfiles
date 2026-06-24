-- @DOC_REQUIRE_SECTION@
-- Theme handling library
local beautiful = require("beautiful")
-- Standard awesome library
local gears = require("gears")

-- @DOC_LOAD_THEME@
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_configuration_dir() .. ... .. "/gtk/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/lunatic/theme.lua")
-- beautiful.init(gears.filesystem.get_themes_dir() ..  "/default/theme.lua")
