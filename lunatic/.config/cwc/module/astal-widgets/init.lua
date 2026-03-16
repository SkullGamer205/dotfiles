-- Add directories
local configDir_Astal = configDir_CwC .. "/module/astal-widgets"
package.path = package.path .. ";" .. configDir_Astal .. "/?.lua;" .. configDir_Astal .. "/?/init.lua"

-- Main libraries
pcall(require, "luarocks.loader")

local src = require("lib.common").src
local Debug = require("lib.debug")

Debug.info("App", "Starting astal-bar")

local astal = require("astal")
local App = require("astal.gtk3.app")

local AstalBar  = require("windows.bar")
local AstalTray = require("windows.tray")

Debug.info("App", "Components loaded successfully")

Debug.set_config({
    log_to_file = true,
    log_to_console = true,
    log_level = Debug.LEVELS.DEBUG,
})

local scss = src("scss/style.scss")
local css = "/tmp/astal-style.css"
os.execute("sass ".. scss .. " " .. css)

Debug.info("App", "Sass loaded successfully")

-- Main function
App:start {
--    instance_name = "lunatic",
    instance_name = "astal",
    class_name = "astal-cwc" ,
    css = css,
    on_second_instance = function()
        Debug.warn("App", "Another instance is running")
    end,
    
    requrest_handler = function(msg, res)
        Debug.debug("App", "Request received: %s", msg)
        res("ok")
    end,

    main = function()
        if #App.monitors == 0 then
            Debug.error("App", "No monitors detected")
            return
        end

        local function create_windows(monitor)
            if not monitor then
                Debug.error("App", "Invalid monitor provided")
                return false
            end
    
            local windows = {
               AstalBar(monitor),
               AstalTray(monitor)
            }
    
            for name, window in pairs(windows) do
                if not window then
                    Debug.error("App", "Failed to create" .. name)
                    return false
                end
                window.gdkmonitor = monitor
            end
            return true
        end
        
        for _, monitor in pairs (App.monitors) do
            if not create_windows(monitor) then
                Debug.error("App", "Failed to create windows for monitor")
                return
            end
        end
    end
}
