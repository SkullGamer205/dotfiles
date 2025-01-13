# awesome-retain
Retain is an Awesome Lua module for retaining tags and their layouts between restarts and screen adds/removes.

## Dependencies
Awesome v4.1 or at least after the [`gears.filesystem`](https://github.com/awesomeWM/awesome/tree/f57e3eb48c3532f6fb80f62055e3acc8d82fef4c) commit.  
*You can change two lines to make it work with Awesome v4.0, see below.*

Retain saves its data in JSON format using [lua-json](http://luaforge.net/projects/luajson/).

## Usage
In your `rc.lua` add `local retain = require("retain")` after all the core modules.

Find the line where you define your `awful.layout.layouts`. After that line add `retain.tags.load()`.

The default fallback tags and layouts are awesome's defaults. You can set your own by setting:
```lua
retain.tags.defaults.names = {"tag name", "tag name", ...}
retain.tags.defaults.layouts = {layout, layout, ...}
```
where names and layouts are acceptable parameters to `awful.tag()`

For example:
```lua
retain.tags.defaults.names = {"A", "B", "C"}
retain.tags.defaults.layouts = {l[2], l[4], l[6]}
```
where `l = awful.layout.layouts`.

In your `awful.screen.connect_for_each_screen` function, change your `awful.tag()` line to:  
`awful.tag(retain.tags.getnames(s), s, retain.tags.getlayouts(s))`

The default save file is:  
`retain.tags.savefile = gears.filesystem.get_configuration_dir() .. ".retained"`  
If you want to save to a different location, change the variable `retain.tags.savefile`.

## Signals added
Retain connects three functions upon loading:  
* screen removed signal, `retain.tags.save`
* screen added (connect_for_each_screen), saves the screen.index variable to screen.sid
* awesome exit, `retain.tags.save_all`

The extra `sid` variable is needed because `index` is queried through the screen list object internally, when a screen is removed the `index` variable is no longer valid.

## Awesome v4.0
To make it work with Awesome v4.0:
* Remove the `local gfs = require("gears.filesystem")` line
* Change `gfs.get_configuration_dir()` to `awful.util.get_configuration_dir()`
