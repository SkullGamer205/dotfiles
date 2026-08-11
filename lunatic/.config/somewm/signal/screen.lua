local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

--- Attach tags and widgets to all screens.
screen.connect_signal("request::desktop_decoration", function(s)
    -- Restore saved tags if this output was previously removed
    local output_name = s.output and s.output.name
    local restore = output_name and awful.permissions.saved_tags[output_name]
    if restore then
        awful.permissions.saved_tags[output_name] = nil
        -- Pass 1: recreate tags and build per-client tag lists
        local client_tags = {}
        for _, td in ipairs(restore) do
            local t = awful.tag.add(td.name, {
                screen = s,
                layout = td.layout,
                master_width_factor = td.master_width_factor,
                master_count = td.master_count,
                gap = td.gap,
                selected = td.selected,
            })
            for _, c in ipairs(td.clients) do
                if c.valid then
                    if not client_tags[c] then
                        client_tags[c] = {}
                    end
                    table.insert(client_tags[c], t)
                end
            end
        end
        -- Pass 2: move clients and assign full tag lists
        for c, tags in pairs(client_tags) do
            c:move_to_screen(s)
            c:tags(tags)
        end
    else
        -- Create all tags and attach layouts to each of them
        awful.tag(require('config.user').tags, s, awful.layout.layouts[1])
    end

    -- Attach a wibar to each screen
    s.bar = require('ui.wibar')(s)
end)

-- @DOC_WALLPAPER@
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            widget = wibox.container.tile,
            valign = "center",
            halign = "center",
            tiled  = true,
            {
                widget    = wibox.widget.imagebox,
                image     = beautiful.wallpaper,
                upscale   = false,
                downscale = false
            },
        }
    }
end)
