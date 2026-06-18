-- @DOC_DEFAULT_APPLICATIONS@
-- This is used later as the default terminal and editor to run.

return {
    terminal    = foot,
    editor      = os.getenv('EDITOR') or 'vi'
    editor_cmd  = terminal .. "-e " .. editor
}
