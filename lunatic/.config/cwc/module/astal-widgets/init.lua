local configDir_CwC = ((os.getenv("XDG_CONFIG_HOME")) or (os.getenv("HOME") .. "/.config")) .. "/cwc"
local configDir_Astal = configDir_CwC .. "/module/astal-widgets"
local cwcDir = "/usr/share/cwc/lib"

package.path = package.path .. ";" .. configDir_CwC .. "/?.lua;" .. configDir_CwC .. "/?/init.lua"
package.path = package.path .. ";" .. configDir_Astal .. "/?.lua;" .. configDir_Astal .. "/?/init.lua"
package.path = package.path .. ";" .. cwcDir .. "/?.lua;" .. cwcDir .. "/?/init.lua"

pcall(require, "luarocks.loader")

local M = {}

-- local addRelPath = require("lib.common").addRelPath
-- addRelPath("module")
local src = require("lib.common").src
local astal = require("astal")
local App = require("astal.gtk3.app")
local AstalBar = require("statusbar")

-- local scss = src("style.scss")
-- local css = "/tmp/astal-style.css"
-- astal.exec("sass ".. scss .. " " .. css)

-- function M.start()

App:start {
    instance_name = "astal",
    class_name = "astal-cwc",
    -- css = css,
    -- hold = false,
    on_second_instance = function()
        print("Another instance attempted to start")
    end,
    
    requrest_handler = function(msg, res)
        print(msg)
        res(ok)
    end,
    
    main = function()
       for _, monitor in pairs (App.monitors) do
           AstalBar(monitor)
       end
    end
}

-- end

-- return M
