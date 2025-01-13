---------------------------------------------------------------------------
--- Retain
--
-- @author Kevin Zander &lt;veratil@gmail.com&gt;
-- @copyright 2017 Kevin Zander
-- @module retain
---------------------------------------------------------------------------

-- External Dependencies:
-- 	lua-json (http://luaforge.net/projects/luajson/)
--
-- Description:
--  Retain works behind the scenes to save your tags and current layout for
--   each screen. When a screen is connected it will load with your previous
--   tags and last layout, or if it's new it will use a default set.
--
-- JSON Encoded format:
--  { "screenID" : {
-- 			"tag position" : {
-- 				"name" : "tag name",
-- 				"layout" : "layout name",
-- 				"mcount" : master count,
-- 				"ccount" : column count,
-- 				"mwf" : master width factor },
-- 			...
-- 		},
-- 		...
-- 	}
--
-- Decoded format:
-- 	{ "screenID" = {
-- 			"tag position" = {
-- 				name = "tag name",
-- 				layout = "layout name",
-- 				mcount = master count,
-- 				ccount = column count,
-- 				mwf = master width factor
-- 			},
-- 			...
-- 		},
-- 		...
-- 	}
--
-- Usage:
--  In rc.lua add `local retain = require("retain")`.
--
--  After defining your awful.layout.layouts add `retain.tags.load()`.
--
--  The default fallback tags and layouts are awesome's defaults.
--   You can set your own by setting:
--    retain.tags.defaults.names = {"tag name", "tag name", ...}
--    retain.tags.defaults.layouts = {layout, layout, ...}
--   where names and layouts are acceptable parameters to awful.tag()
--
--   For example:
--    retain.tags.defaults.names = {"A", "B", "C"}
--    retain.tags.defaults.layouts = {l[2], l[4], l[6]}
--   where l = awful.layout.layouts
--
--  In the awful.screen.connect_for_each_screen function, change your
--   awful.tag() line to:
--    awful.tag(retain.tags.getnames(s), s, retain.tags.getlayouts(s))
--
--  The default save file is:
--    awful.util.get_configuration_dir() .. ".retained"
--   If you want to save to a different location, change
--    retain.tags.savefile

local json = require("json")
local awful = require("awful")
local gfs = require("gears.filesystem")
local naughty = require("naughty")

local retain = {tags={},layout={}}

retain.debug = false
retain.tags.savefile = gfs.get_configuration_dir() .. 'retain.json'
retain.tags.defaults = {
	names={"1","2","3","4","5","6","7","8","9"},
	layouts=awful.layout.suit.floating,
}
retain.tags._mytags = {}
retain.tags._loaded = nil

local function debug(txt)
	if retain.debug then
		print("RETAIN: " .. txt)
	end
end
-- get the index of the screen
local function getScreenIndex(scr)
	if type(scr) == "screen" then
		return scr.sid
	elseif type(scr) == "string" then
		return screen[scr].sid
	elseif type(scr) == "number" then
		return scr
	end
	return nil
end

-- gather the tags of a screen by numeric index
local function gatherTags(scr)
	debug("gatherTags()")
	local tbl = {}
	for i,v in ipairs(scr.tags) do
		-- save tag as {tag index = {tag name, tag layout name}}
		debug(v.name .. " " .. v.layout.name)
		tbl[tostring(i)] = {name=v.name, layout=v.layout.name}
	end
	return tbl
end

-- find a layout by name
local function findLayout(name)
	debug("findLayout()")
	for _,l in ipairs(awful.layout.layouts) do
		if l.name == name then
			debug("found " .. name)
			return l
		end
	end
	return nil
end

-- convert _loaded to _mytags
local function convertLoadedTags(sid)
	debug("convertLoadedTags()")
	local sin = tonumber(sid)
	debug("screen index " .. sid)
	for tid,ttb in pairs(retain.tags._loaded[sid]) do
		local tin = tonumber(tid)
		debug("tag index " .. tid)
		debug(ttb.name .. " " .. ttb.layout)
		if not retain.tags._mytags[sin] then retain.tags._mytags[sin] = {names={},layouts={}} end
		retain.tags._mytags[sin].names[tin] = ttb.name
		retain.tags._mytags[sin].layouts[tin] = findLayout(ttb.layout)
	end
end

-- save all screens
function retain.tags.save_all()
	debug("save_all()")
	for s in screen do
		retain.tags.save(s)
	end
end

-- save tags for a specific screen
function retain.tags.save(scr)
	debug("save()")
	if not scr or type(scr) ~= "screen" then return end
	local si = tostring(scr.sid)
	debug("screen id: " .. si)
	-- collect tags and their layout name
	local tbl = gatherTags(scr)
	-- merge into loaded collection so we don't have to read the file again
	-- this allows one to connect the screen again at a later time without
	--  having to read the file again
	if not retain.tags._loaded then retain.tags._loaded = {} end
	retain.tags._loaded[si] = tbl
	-- save to mytags
	convertLoadedTags(si)
	-- write serialized to file
	debug("saving file")
	local f = io.open(retain.tags.savefile, 'w')
	f:write(json.encode(retain.tags._loaded))
	f:close()
end

-- load saved tags
function retain.tags.load()
	debug("load()")
	local f = io.open(retain.tags.savefile, 'r')
	-- no save file found
	if not f then
		debug("file not found")
		-- XXX: This will always show on first load
		naughty.notify({
			preset = naughty.config.presets.critical,
			text = "No save file found",
			title = "retain",
		})
		-- load defaults
		debug("loading defaults")
		retain.tags._mytags = retain.tags.defaults
		return
	end
	-- if _loaded is nil, load it
	if not retain.tags._loaded then
		debug("_loaded empty")
		-- json to table, save
		retain.tags._loaded = json.decode(f:read("*a"))
		-- if failure
		if not retain.tags._loaded or type(retain.tags._loaded) ~= "table" then
			debug("failed to read file")
			retain.tags._loaded = nil
			naughty.notify({
				preset = naughty.config.presets.critical,
				text = "Error in loading json, loading defaults",
				title = "retain",
			})
			-- load defaults
			retain.tags._mytags = retain.tags.defaults
			-- close the file before return
			f:close()
			return
		end
	end
	f:close()
	-- convert to numeric index
	for sid,stb in pairs(retain.tags._loaded) do
		debug(sid .. " " .. tostring(stb))
		-- k = screen index
		-- v = list of objects
		local sin = tonumber(sid) -- screen index
		retain.tags._mytags[sin] = {names={},layouts={}}
		-- stb = {"tag index" = ttb, ...}
		for tid,ttb in pairs(stb) do
			-- ttb = {name = "tag name", layout = "layout name"}
			debug(tid .. " " .. tostring(ttb))
			local tin = tonumber(tid) -- tag index
			retain.tags._mytags[sin].names[tin] = ttb.name
			retain.tags._mytags[sin].layouts[tin] = findLayout(ttb.layout)
		end
	end
end

-- Reduce code duplication, get a table from tags table
local function getTable(scr, name)
	debug("getTable()")
	local s = getScreenIndex(scr)
	debug(tostring(s))
	if retain.tags._mytags[s] then
		debug(#retain.tags._mytags[s])
		if #retain.tags._mytags[s][name] > 0 then
			return retain.tags._mytags[s][name]
		end
	end
	return retain.tags.defaults[name]
end

-- get the names of tags from tags table
function retain.tags.getnames(scr)
	return getTable(scr, "names")
end

-- get the layouts of tags from tags table
function retain.tags.getlayouts(scr)
	return getTable(scr, "layouts")
end

function retain.connect_signals()
	debug("connect_signals()")
	-- always save on a screen removed
	screen.connect_signal("removed", retain.tags.save)

	-- save on awesome restart or exit
	awesome.connect_signal("exit", retain.tags.save_all)
end

-- On disconnect of a screen, this should have our latest index
-- Retain will get this variable on screen removed signal
awful.screen.connect_for_each_screen(function(s)
	s.sid = s.index
end)

-- reload on a screen add
--screen.connect_signal("added", retain.tags.update)

return retain
