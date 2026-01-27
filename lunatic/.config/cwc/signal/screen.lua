local tag = require("cuteful.tag")
local enum = require("cuteful.enum")

------------------------------- SCREEN SETUP ------------------------------------
cwc.connect_signal("screen::new", function(screen)
    
    if screen.name == "Virtual-1" then
        screen:set_position(0, 0)       -- NOTE: Position(s) MUST be non-negative - based on #49 (https://github.com/Cudiph/cwcwm/issues/49).

        screen:set_mode(1920, 1080, 60) -- width, height, refresh rate
        screen:set_adaptive_sync(true)
        screen:set_scale(1.0)
        screen:set_transform(enum.output_transform.TRANSFORM_NORMAL)

        -- by default the screen is not allowed to tear
        screen.allow_tearing = true
    end

    -- screen settings
    if screen.name == "eDP-1" then
        screen:set_position(0, 0)       -- NOTE: Position(s) MUST be non-negative - based on #49 (https://github.com/Cudiph/cwcwm/issues/49).
        screen:set_mode(1920, 1080, 75) -- width, height, refresh rate
        screen:set_adaptive_sync(true)
        screen:set_scale(1.0)
        screen:set_transform(enum.output_transform.TRANSFORM_NORMAL)

        -- by default the screen is not allowed to tear
        screen.allow_tearing = true
    end

    if screen.name == "HDMI-1" then
        screen:set_position(1920, 0)
        screen:set_mode(1920, 1080, 75)
        screen:set_adaptive_sync(true)
        screen:set_scale(1.0)
        screen:set_transform(enum.output_transform.TRANSFORM_NORMAL)

        screen.allow_tearing = true
    end
    
    -- don't apply if restored since it will reset whats manually changed
    if screen.restored then return end

    -- set all "general" tags to master/stack mode by default
    for i = 1, 9 do
        tag.layout_mode(i, enum.layout_mode.MASTER, screen)
    end

    -- set workspace 2, 8, and 9 to floating mode
    tag.layout_mode(2, enum.layout_mode.FLOATING, screen)
    tag.layout_mode(8, enum.layout_mode.FLOATING, screen)
    tag.layout_mode(9, enum.layout_mode.FLOATING, screen)

    -- set workspace 4, 5, 6 to bsp mode
    tag.layout_mode(4, enum.layout_mode.BSP, screen)
    tag.layout_mode(5, enum.layout_mode.BSP, screen)
    tag.layout_mode(6, enum.layout_mode.BSP, screen)
end)

-- cwc.connect_signal("screen::destroy", function(screen)
--     --- here screen.clients is equivalent as screen:get_clients()
--     local cmd = string.format(
--         'notify-send "Screen removed" "Screen %s [%s] with %s clients attached"', screen.name,
--         screen.description or "-", #screen.clients)
--     cwc.spawn_with_shell(cmd)
-- end)
