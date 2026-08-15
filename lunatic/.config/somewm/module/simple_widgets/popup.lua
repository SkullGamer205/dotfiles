-- Default libraries
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local Debugger  = require('module.debugger')

-- Simple Popups
local simplepopup = {}

--- Creates a pop-up module with standard lifecycle methods.
-- @param name                          string      Identifer for the module (used in signals, e.g., "name::visible").
-- @param opts                          table       Configuration and callbacks.
-- @param opts.main_widget              function    Return the wibox widget to display.
-- @param opts.placement                function    (optional) (default: awful.placement.centered) Placement logic.
--
--
--
-- @param opts.stop_key                 string      (optional) (default: 'Escape') Key to dismiss.
-- @param opts.enable_keygrabber        boolean     (optional) (default: 'true') Enable  keygrabber (needed for opts.stop_key).
-- @param opts.keypressed_callback      function    (optional) Handles keys. Signature: function(widget, key, modifiers)
-- @param opts.on_show                  function    (optional) Callback on show
-- @param opts.on_hide                  function    (optional) Callback on hide.
-- @return                              table       The popup module

function simplepopup.create(name, opts)
    opts = opts or {}
    local widget = {}

    -- States
    local visible           = false
    local popup             = nil
    local keygrabber        = nil
    local is_cleaning_up    = false

    -- Defauls
    local placement         = opts.placement            or awful.placement.centered
    local border_width      = beautiful.border_width    or 0
    local border_color      = beautiful.border_color    or '#00000000'
    local shape             = beautiful.shape           or gears.shape.rounded_rect
    local stop_key          = opts.stop_key             or 'Escape'
    local enable_keygrabber = opts.enable_keygrabber    or true


    -- Internal cleanup
    local function cleanup()
        if is_cleaning_up then
            Debugger.warn("PopupWidget", "(" .. name .. ") Popup is currently cleaning. Ignoring")
            return
        end
        is_cleaning_up = true
        Debugger.debug("PopupWidget", "(" .. name .. ") Cleaning ...")

        visible = false
        if keygrabber then
            keygrabber:stop()
            keygrabber = nil
            Debugger.debug("PopupWidget", "(" .. name .. ") Keygrabber stopped")
        end

        if popup then
            popup.visible = false
            Debugger.debug("PopupWidget", "(" .. name .. ") Hiding ...")
        end

        awesome.emit_signal(name .. "::visible", false)
        if opts.on_hide then opts.on_hide(widget) end

        is_cleaning_up = false
        Debugger.debug("PopupWidget", "(" .. name .. ") Done")
    end

    -- Internal keygrabber setup
    local function start_keygrabber()
        Debugger.debug("PopupWidget", "(" .. name .. ") Keygrabber started")
        keygrabber = awful.keygrabber({
            autostart       = true,
            stop_key        = stop_key,
            stop_callback   = cleanup,

            keypressed_callback = function(_, modifiers, key, _)
                if opts.keypressed_callback then
                    opts.keypressed_callback(widget, key, modifiers)
                end
            end,
        })
    end

    -- Refresh popup widget
    function widget.refresh()
        if popup then
            Debugger.debug("PopupWidget", "(" .. name .. ") Refreshing ...")
            if opts.on_refresh then opts.on_refresh(widget) end
            popup.widget = opts.main_widget()
            Debugger.debug("PopupWidget", "(" .. name .. ") Done")
        end
    end

    -- Show popup
    function widget.show()
        if visible then
            Debugger.warn("PopupWidget", "(" .. name .. ") Popup is currently visible. Ignoring.")
            return
        end
        Debugger.debug("PopupWidget", "(" .. name .. ") Showing popup")

        if opts.on_show then opts.on_show(widget) end

        local s = awful.screen.focused()

        if not popup then
            popup = awful.popup({
                widget          = opts.main_widget(),
                screen          = s,
                placement       = placement,
                ontop           = true,
                visible         = false,
                border_width    = border_width,
                border_color    = border_color,
                shape           = shape,
                bg              = '#00000000',   -- transparent

                maximum_width   = s.geometry.width,
                maximum_height  = s.geometry.height,
            })
        end

        popup.screen = s
        placement(popup, { parent = s})
        popup.widget = opts.main_widget()
        popup.visible = true
        visible = true
         
        if opts.enable_keygrabber ~= false then start_keygrabber() end

        awesome.emit_signal(name .. "::visible", true)
    end

    -- Hide popup
    function widget.hide()
        if not visible then return end
        cleanup()
    end

    -- Toggle popup
    function widget.toggle()
        if visible then
            widget.hide()
        else
            widget.show()
        end
    end

    -- Check visibility
    function widget.is_visible()
        return visible
    end

    -- Access underlying popup
    function widget.get_popup()
        return popup
    end

    return widget
end

return simplepopup
