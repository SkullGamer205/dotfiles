-- This is used later as the default terminal and editor to run.
local apps = {}
apps.browser    = 'zen-browser'
apps.office     = 'libreoffice'
apps.terminal   = 'uxterm'
apps.editor     = os.getenv('EDITOR') or 'vim'
apps.editor_cmd = apps.terminal .. ' -e ' .. apps.editor

-- Set the terminal for the menubar.
require('menubar').utils.terminal = apps.terminal

return apps
