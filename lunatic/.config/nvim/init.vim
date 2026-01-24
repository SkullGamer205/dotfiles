lua require('plugins')

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

"Base Things
syntax on
set number relativenumber

"Tab
set tabstop=4
set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0

" Color scheme
colorscheme base16
set notermguicolors

" HJKL -> JKIL
" vim.api.nvim_set_keymap('n', 'i', 'k', {noremap = true, silent = true})
" vim.api.nvim_set_keymap('n', 'j', 'h', {noremap = true, silent = true})
" vim.api.nvim_set_keymap('n', 'k', 'j', {noremap = true, silent = true})
" vim.api.nvim_set_keymap('n', 'l', 'l', {noremap = true, silent = true})

" vim.api.nvim_set_keymap('n', 'h', 'i', {noremap = true, silent = true})
" vim.api.nvim_set_keymap('n', 'H', 'I', {noremap = true, silent = true})

" tmux navigator stuff
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <c-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <c-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <c-w>l :TmuxNavigateRight<cr>
nnoremap <silent> <c-w>; :TmuxNavigatePrevious<cr>
