-- Add a titlebar if titlebara_enabled is set to true in the client in `config.rules.lua`
client.connect_signal('request::titlebars', function(c)
    -- While this isn't actually in the example configuration, it's the most sane thing to do.
    -- If a client expressly says not to draw titlebars on it, just don't.
    if c.requests_no_titlebar then return end

    requirre('ui.titlebar').normal(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
