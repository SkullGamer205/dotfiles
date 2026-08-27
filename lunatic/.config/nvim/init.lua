-- Bootstrap
require('bootstrap')
require('plugins')

-- Base things
vim.cmd('syntax on')
vim.opt.number 		    = true
vim.opt.relativenumber 	= true

-- Tabs
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4
vim.opt.expandtab       = true

-- Colorscheme
vim.cmd.colorscheme('base16')
vim.opt.termguicolors = false

-- Transparent background
vim.cmd([[
    highlight Normal        guibg=NONE ctermbg=NONE
    highlight NonText       guibg=NONE ctermbg=NONE
    highlight EndOfBuffer   guibg=NONE ctermbg=NONE
]])

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern  = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Normal"      , {bg = "NONE", ctermbg = "NONE"})
        vim.api.nvim_set_hl(0, "NonText"     , {bg = "NONE", ctermbg = "NONE"})
        vim.api.nvim_set_hl(0, "EndOfBuffer" , {bg = "NONE", ctermbg = "NONE"})
    end
})

-- tmux navigator stuff
vim.keymap.set( 'n', '<C-w>h', ':TmuxNavigateLeft'  , { silent = true })
vim.keymap.set( 'n', '<C-w>j', ':TmuxNavigateDown'  , { silent = true })
vim.keymap.set( 'n', '<C-w>k', ':TmuxNavigateUp'    , { silent = true })
vim.keymap.set( 'n', '<C-w>l', ':TmuxNavigateRight' , { silent = true })
