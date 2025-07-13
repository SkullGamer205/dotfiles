pcall(require, "luarocks.loader")
local src = require("lib").src
local astal = require("astal")
local App = require("astal.gtk3").App
local Bar = require("TopBar.Bar")
local Notif = require("Notifications.init")
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
            Bar(monitor)
            Notif(monitor)
            Launcher()
            PlayerPopup()
    end
}
