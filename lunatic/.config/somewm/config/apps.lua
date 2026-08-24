-- @DOC_DEFAULT_APPLICATIONS@
-- This is used later as the default terminal and editor to run.

local apps = {}
    apps.terminal    = 'foot'     or os.getenv("TERMINAL")
    apps.fileman     = 'pcmanfm'  or 'xdg-open .'
    apps.browser     = 'firefox'  or 'xdg-open https://'
    apps.editor      = os.getenv('EDITOR') or 'vi'
    apps.editor_cmd  = apps.terminal .. " -e " .. apps.editor

    -- Menubar configuration
    require('menubar').utils.terminal = apps.terminal -- Set the terminal for applications that require it
return apps
