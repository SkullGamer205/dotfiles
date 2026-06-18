-- @DOC_LAYOUT@
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    require('awful').layout.append_default_layouts(require('config.user').layouts)
end)
