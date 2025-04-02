local modalawesome = require("module.modalawesome")

modalawesome.init{
  modkey       = "Mod4",
  default_mode = "tag",
  -- modes        = require("module.modalawesome.modes"),
  modes = require(... ..".modes"),
  stop_name    = "client",
  keybindings  = {}
}
