--[[

     Lain
     Layouts, widgets and utilities for Awesome WM

     Layouts section

     Licensed under GNU General Public License v2
      * (c) 2013,      Luca CPZ
      * (c) 2010-2012, Peter Hofmann

--]]

if not LAIN_DIR then LAIN_DIR = (...):match("(.-)[^%.]+$") end
local wrequire     = require(string.format(LAIN_DIR.."helpers")).wrequire
local setmetatable = setmetatable

local layout       = { _NAME = LAIN_DIR.."layout" }

return setmetatable(layout, { __index = wrequire })
