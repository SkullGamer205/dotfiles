local awful = require('awful')
local helpers = require('binds.helpers')
local hotkeys_popup = require('awful.hotkeys_popup')

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

local mod = require('binds.mod')
local modkey = mod.modkey

local apps = require('config.apps')
local user = require('config.user')

local global_helpers = {
    lua_prompt_run = function()
        awful.prompt.run {
          prompt       = "Run Lua code: ",
          textbox      = awful.screen.focused().mypromptbox.widget,
          exe_callback = awful.util.eval,
          history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end,
    
    client_restore_minimized = function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end,

    toggle_window = function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end,
}

local layout_helpers = {
    increase_master_clients = function()
        if awful.layout.get(awful.screen.focused()).name == "carousel" then
            awful.layout.suit.carousel.consume_window( 1)
        else
            awful.tag.incnmaster( 1, nil, true)
        end
    end,
    
    decrease_master_clients = function()
        if awful.layout.get(awful.screen.focused()).name == "carousel" then
            awful.layout.suit.carousel.consume_window(-1)
        else
            awful.tag.incnmaster(-1, nil, true)
        end
    end,

    increase_column_numbers = function()
        if awful.layout.get(awful.screen.focused()).name == "carousel" then
            awful.layout.suit.carousel.adjust_column_width( 0.05)
        else
            awful.tag.incncol( 1, nil, true)
        end
    end,
    
    decrease_column_numbers = function()
        if awful.layout.get(awful.screen.focused()).name == "carousel" then
            awful.layout.suit.carousel.adjust_column_width(-0.05)
        else
            awful.tag.incncol(-1, nil, true)
        end
    end,
}

local change_kbd_layout = function()
    local layouts = awful.widget.keyboardlayout.get_groups_from_group_names(
        awesome.xkb_get_group_names())
    local current = awesome.xkb_get_layout_group()
    awesome.xkb_set_layout_group((current + 1) % #layouts)
end

local media_helpers = {
  raise_volume = function()
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
  end,

  lower_volume = function()
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
  end,

  toggle_speaker = function()
    awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
  end,

  toggle_micro = function()
    awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
  end,
}

local shot_helpers = {
    screenshot = function(interactive)
        local interactive = interactive or false
        local directory   = user.shots.directory or os.getenv("HOME") .. "/screenshots/"
        local notifty     = user.shots.notify or false

        local s = awful.screenshot({
            interactive = interactive,
            directory   = directory,
        })

        -- Snipping
        s:connect_signal("snipping::start", function(self)
            if self._private.frame then
                self._private.imagebox.visible = false
                self._private.frame.bg = "#00000040"
                self._private.frame.surface_scale = 1.0
            end
        end)

        -- Notify
        if notify == true then
            s:connect_signal("file::saved", function(self, path)
                naughty.notify {
                    title = "Screenshot saved",
                    text = path,
                    timeout = 3,
                }
            end)
        end

        s:refresh()
    end,
}

-- @DOC_GLOBAL_KEYBINDINGS@

-- General Awesome keys
local g_keys = {
    -- Mod      / Key                            / Action                                                       / Description                   / Category
    --{{        }, ""                            ,                                                              , ""                            , ""            },
    
    -- Media
    {{          }, "XF86AudioLowerVolume"        , media_helpers.lower_volume                                   , "Decrease volume"             , "Media"       },
    {{          }, "XF86AudioRaiseVolume"        , media_helpers.raise_volume                                   , "Increase volume"             , "Media"       },
    {{          }, "XF86AudioMute"               , media_helpers.toggle_speaker                                 , "Mute volume"                 , "Media"       },
    {{          }, "XF86AudioMicMute"            , media_helpers.toggle_micro                                   , "Mute microphone"             , "Media"       },
    {{          }, "XF86AudioNext"               , function() awful.spawn("playerctl next") end                 , "Pext track"                  , "Media"       },
    {{          }, "XF86AudioPlay"               , function() awful.spawn("playerctl play-pause") end           , "Play/Pause track"            , "Media"       },
    {{          }, "XF86AudioPrev"               , function() awful.spawn("playerctl previous") end             , "Previous track"              , "Media"       },

    {{          }, "XF86MonBrightnessDown"       , function() awful.spawn("brightnessctl s 5%-") end            , "Decrease brightness"         , "Media"       },
    {{          }, "XF86MonBrightnessUp"         , function() awful.spawn("brightnessctl s +5%") end            , "Increase brightness"         , "Media"       },

    -- {{           }, "Print"                      , shot_helpers.screenshot(false)                               , "Make screenshoot"            , "Other"       },
    -- {{ mod.shift }, "Print"                      , shot_helpers.screenshot(true)                                , "Make screenshoot area"       , "Other"       },
    
    {{           }, "CapsLock"                   , change_kbd_layout()                                          , "Change keyboard layout"      , "Other"       },

    -- SomeWM
    {{ modkey,  }, "s"                           , hotkeys_popup.show_help                                      , "Show help"                   , "SomeWM"      }, 
    {{ modkey,  }, "w"                           , function() mymainmenu:toggle() end                           , "Show main menu"              , "SomeWM"      }, 
    {{ modkey,  }, "x"                           , global_helpers.lua_prompt_run                                , "Run Lua code"                , "SomeWM"      }, 
    {{ modkey, mod.ctrl  }, "r"                  , awesome.restart                                              , "Reload SomeWM"               , "SomeWM"      }, 
    {{ modkey, mod.shift }, "q"                  , awesome.quit                                                 , "Quit SomeWM"                 , "SomeWM"      }, 
    {{ modkey, mod.shift }, "Escape"             , awesome.lock()                                               , "Lock screen"                 , "SomeWM"      }, 

    -- Launcher
    {{ modkey,  }, "Return"                      , function() awful.spawn(apps.terminal) end                    , "Open terminal"               , "Launcher"    }, 
    {{ modkey,  }, "r"                           , function() awful.screen.focused().mypromptbox:run() end      , "Run prompt"                  , "Launcher"    }, 
    -- {{ modkey,  }, "p"                           , menubar.show()                                               , "Show titlebar"               , "Launcher"    }, 

    -- Tag
    {{ modkey,  }, "Left"                        , awful.tag.viewprev                                           , "View previous"               , "Tag"         }, 
    {{ modkey,  }, "Right"                       , awful.tag.viewnext                                           , "View next"                   , "Tag"         }, 
    {{ modkey,  }, "Escape"                      , awful.tag.history.restore                                    , "Go back"                     , "Tag"         },

    -- Client
    {{ modkey,  }, "j"                           , function() awful.client.focus.byidx( 1) end                  , "Focus next by index"         , "Client"      }, 
    {{ modkey,  }, "k"                           , function() awful.client.focus.byidx(-1) end                  , "Focus previous by index"     , "Client"      }, 
    {{ modkey,  }, "Tab"                         , global_helpers.toggle_window                                 , "Go back"                     , "Client"      },

    {{ modkey, mod.shift }, "j"                  , function() awful.client.swap.byidx( 1) end                   , "Swap next client by index"   , "Client"      }, 
    {{ modkey, mod.shift }, "k"                  , function() awful.client.swap.byidx(-1) end                   ,"Swap previous client by index", "Client"      }, 
    {{ modkey,           }, "u"                  , awful.client.urgent.jumpto                                   , "Jump to urgent client"       , "Client"      },

    {{ modkey, mod.ctrl  }, "j"                  , function() awful.screen.focus_relative( 1) end               , "Focus previous screen"       , "Client"      }, 
    {{ modkey, mod.ctrl  }, "k"                  , function() awful.screen.focus_relative(-1) end               , "Focus next screen"           , "Client"      }, 
    {{ modkey, mod.ctrl  }, "n"                  , global_helpers.client_restore_minimized                      , "Resrore minimized window"    , "Client"      },

    -- Layout
    {{ modkey, mod.shift }, "Space"              , function() awful.layout.inc( 1) end                          , "Select next"                 , "Layout"      }, 
    {{ modkey, mod.ctrl  }, "Space"              , function() awful.layout.inc(-1) end                          , "Select previous"             , "Layout"      },

    {{ modkey,           }, "h"                  , function() awful.tag.incmwfact(-0.05) end                    , "Decrease master with factor" , "Layout"      }, 
    {{ modkey,           }, "l"                  , function() awful.tag.incmwfact( 0.05) end                    , "Increase master with factor" , "Layout"      },  
    {{ modkey, mod.shift }, "h"                  , layout_helpers.increase_master_clients                       , "Increase number of masters"  , "Layout"      }, 
    {{ modkey, mod.shift }, "l"                  , layout_helpers.decrease_master_clients                       , "Decrease number of masters"  , "Layout"      }, 
    {{ modkey, mod.ctrl  }, "h"                  , layout_helpers.increase_column_numbers                       , "Increase column numbers"     , "Layout"      }, 
    {{ modkey, mod.ctrl  }, "l"                  , layout_helpers.decrease_column_numbers                       , "Decrease column numbers"     , "Layout"      },

    -- Carousel
    {{ modkey,           }, "bracketright"       ,function() awful.layout.suit.carousel.cycle_column_width() end, "Cucle column width"          , "Carousel"    }, 
    {{ modkey, mod.shift }, "e"                  , function() awful.layout.suit.carousel.expel_window() end     , "Expel window to new column"  , "Carousel"    },
}

awful.keyboard.append_global_keybindings(helpers.table_to_keybinding(g_keys))

-- @DOC_NUMBER_KEYBINDINGS@
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, mod.ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, mod.shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, mod.ctrl, mod.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})
