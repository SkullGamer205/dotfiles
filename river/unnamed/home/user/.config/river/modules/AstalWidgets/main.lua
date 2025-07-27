pcall(require, "luarocks.loader")
local src = require("lib").src
local astal = require("astal")
local App = require("astal.gtk3.app")
local Bar = require("TopBar.Bar")
local Notif = require("Notifications.init")
local Notif_list = require("Notifications.notification_list")
local Launcher = require("Launcher.init")
local PlayerPopup = require("PlayerPopup.init")

local scss = src("style.scss")
local css = "/tmp/astal-style.css"
astal.exec("sass ".. scss .. " " .. css)
App:start {
    instance_name = "astal",
    class_name = "astal-river",
    css = css,
    main = function()
        for _, mon in pairs (App.monitors) do
            Bar(mon)
            Notif(mon)
        end
            Launcher()
            PlayerPopup()
            Notif_list()
    end
}
