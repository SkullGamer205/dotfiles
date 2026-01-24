require('pckr').add{
    
    -- Tmux
    { 'christoomey/vim-tmux-navigator',
        lazy = true
    };

    -- Directory changer
    { 'notjedi/nvim-rooter.lua',
    config = function() require'nvim-rooter'.setup() end
    };
    
    -- VIfm
    { 'vifm/vifm.vim' };

    --Wild menu
    { 'gelguy/wilder.nvim',
    config = function()
        local wilder = require('wilder')
        wilder.setup({modes = {':', '/', '?'}})
        wilder.set_option('renderer', wilder.popupmenu_renderer(
            wilder.popupmenu_palette_theme({
                border = 'rounded',
                max_height = '75%',
            })
            --            pumblend = 20,
        ))
    end,
    };

    -- Fuzzy Finder
    { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim',
                 'nvim-telescope/telescope-file-browser.nvim' }
    };

    -- Dashboard
    { 'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup{}
    end,

    requires = { 'nvim-tree/nvim-web-devicons' }
    };

    -- Scroll view
    { 'dstein64/nvim-scrollview' };

    -- Smart column
    { 'm4xshen/smartcolumn.nvim',
    config = function()
        require('smartcolumn').setup{
            colorcolumn = {'80', '100'},
            disabled_filetypes = {'help', 'text', 'markdown', 'typst',
                'asciidoc', 'NvimTree', 'lazy', 'meson', 'checkhealth',
                'lspinfo', 'noice', 'Trouble', 'fish', 'zsh' },
            }
    end,
    };

    -- Center view
    {
        'shortcuts/no-neck-pain.nvim',
        config = function()
            require('no-neck-pain').setup({
                autocmds = {
                    enableOnVimEnter = false,
                    reloadOnColorSchemeChange = true,
                    skipEnteringNoNeckPainBuffer = true,
                },
                width = 140,
                buffers = {
                    scratchpad = {
                        enabled = true,
                    },
                    bo = {
                        filetype = "md"
                    }
                }
            })
        end,
    };

    -- Markups
    -- -- AsciiDoc
    { 'marioortizmanero/adoc-pdf-live.nvim',
    config = function()
        require('adoc_pdf_live').setup()
    end 
    };

    -- -- Typst
    { 'kaarmu/typst.vim', ft = {'typst'} };
    
    -- Markdown
    { 'iamcco/markdown-preview.nvim',
    run = "cd app && npm install",
    setup = function()
        vim.g.mkdp_filetypes = { "markdown" },
        vim.g.nkdp_echo_preview_url == 1,
        vim.g.mkdp_browser == "librewolf"
    end,
    ft = { 'markdown' },
    };

    -- Org-mode
    { 'nvim-orgmode/orgmode',
    requires = { 'danilshvalov/org-modern.nvim',
                 'akinsho/org-bullets.nvim',
                 'nvim-orgmode/telescope-orgmode.nvim' },
    config = function()
        local daily_h = io.popen("date +%Y/%Y-%m-%d", 'r')
        local daily_s = daily_h:read("*l")
        daily_h:close()

        require('orgmode').setup({
            org_agenda_files = '~/Documents/Notes/daily/**',
            org_default_notes_file = string.format(
                '~/Documents/Notes/daily/%s.org', tostring(daily_s)),
            org_todo_keywords = {'TODO(t)', 'WAITING(w)', 'NEXT(n)',
                                 '|', 'DONE(d)' },
            org_log_done = true,
            ui = {
                menu = {
                    handler = function(data)
                        require('org-modern.menu'):new({
                            window = {
                                margin = {1, 0, 1, 0},
                                padding = {0, 1, 0, 1},
                                title_pos = "center",
                                border = "single",
                                zindex = 1000,
                            },
                            icons = {
                                separator = "",
                            },
                        }):open(data)
                    end,
                },
            },
        })
        require('org-bullets').setup({
            concealcursor = false,
            symbols = {
                list = "",
                 headlines = { "", "", "", "" },
                 checkboxes = {
                    half = { "󱦒", "@org.checkbox.halfchecked" },
                    done = { "", "@org.keyword.done" },
                    todo = { "", "@org.keyword.todo" },
                },
            },
        })

        require("telescope").load_extension("orgmode")
--[[
        require('nvim-treesitter.configs').setup({
            ignore_install = { 'org' },
        })
--]]
    end,
    };
}

