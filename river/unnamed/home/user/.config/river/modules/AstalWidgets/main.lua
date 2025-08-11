pcall(require, "luarocks.loader")

-- local currentd = addRelPath("")
local src = require("lib.common").src
local astal = require("astal")
local App = require("astal.gtk3.app")
local bar = require("top-bar.main")
local notif = require("top-bar.notification.init")
local w_notif = require("top-bar.notification.notification_list")
local w_launcher = require("top-bar.launcher.widget")
local w_audio = require("top-bar.audio.widget")
local w_player = require("top-bar.player.widget")
local w_battery = require("top-bar.battery.widget")

local scss = src("style.scss")
local css = "/tmp/astal-style.css"
astal.exec("sass ".. scss .. " " .. css)
App:start {
    instance_name = "astal",
    class_name = "astal-river",
    css = css,
    main = function()
        for _, mon in pairs (App.monitors) do
            bar(mon)
            notif(mon)
        end
            w_launcher()
            w_audio()
            w_player()
            w_notif()
            w_battery()
    end
}
