local awful     = require('awful')
local helpers   = require('binds.helpers') 

local mod = require('binds.mod')
local modkey = mod.modkey

local local_helpers = {
    toggle_fullscreen = function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,

    toggle_maximized = function(c)
        c.maximized = not c.maximized
        c:raise()
    end,
    
    toggle_maximized_v = function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end,

    toggle_maximized_h = function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end,

    minimize = function(c)
        c.minimized = true
    end,

    toggle_on_top = function(c)
        c.ontop = not c.ontop
    end,
}

-- @DOC_CLIENT_KEYBINDINGS@
local c_keys = {
     -- Mod      / Key                            / Action                                                       / Description                   / Category
     --{{        }, ""                            ,                                                              , ""                            , ""            },

     -- Client
     {{ modkey, mod.shift  }, "q"                 , function(c) c:kill() end                                     , "Close window"                , "Client"      },
     {{ modkey,            }, "n"                 , local_helpers.minimize                                       , "Minimize"                    , "Client"      },
     {{ modkey,            }, "m"                 , local_helpers.toggle_maximized                               , "(Un)maximize"                , "Client"      },
     {{ modkey, mod.shift  }, "m"                 , local_helpers.toggle_maximized_h                             , "(Un)maximize horizontally"   , "Client"      },
     {{ modkey, mod.ctrl   }, "m"                 , local_helpers.toggle_maximized_v                             , "(Un)maximize vertically"     , "Client"      },
     {{ modkey,            }, "f"                 , local_helpers.toggle_fullscreen                              , "Toggle fullscreen"           , "Client"      },
     {{ modkey,            }, "Space"             , awful.client.floating.toggle                                 , "Toggle floating"             , "Client"      },
     {{ modkey,            }, "f"                 , local_helpers.toggle_fullscreen                              , "Toggle fullscreen"           , "Client"      },
     {{ modkey,            }, "t"                 , local_helpers.toggle_on_top                                  , "Toggle keep on top"          , "Client"      },
     {{ modkey, mod.ctrl   }, "Return"            , function(c) c:swap(awful.client.getmaster()) end             , "Move to master"              , "Client"      },
     {{ modkey,            }, "o"                 , function(c) c:move_to_screen() end                           , "Move to screen"              , "Client"      },

}

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings(helpers.table_to_keybinding(c_keys))
end)
