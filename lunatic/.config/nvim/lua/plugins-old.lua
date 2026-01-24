-- Load libs


-- Plugins
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)

-- Main plugin
    use {'wbthomason/packer.nvim'}
    use {
        'christoomey/vim-tmux-navigator',
        lazy = false
    }

    -- Sudo
    use {'onicue/root-edit'}

-- Customization

    -- File Manager
    use 'vifm/vifm.vim'

    -- Wildmenu
    use {
        'gelguy/wilder.nvim',
        config = function()
        -- config goes here
        end,
        }

    -- Base16
--    use {
--        'RRethy/base16-nvim',
--            require('base16-colorscheme').setup({
--                base00 = '#1e2326', base01 = '#343f44', base02 = '#4f5b58', base03 = '#5d6b66',
--                base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
--                base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
--                base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
--            }),
--        }

    -- Fuzzy Finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-file-browser.nvim"}
        }
    }

    -- Dashboard    
    use {
        'nvimdev/dashboard-nvim',
            event = 'VimEnter',
            config = function()
            require('dashboard').setup {
            -- config
            --[[
                theme = 'dashboard',
                hide = {
                    statusline = true,
                    tabline = true,
                    winbar = true,
                },
                preview = {
                    file_height = 140,
                }
            --]]
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }
   
    -- Scrollview
    use {'dstein64/nvim-scrollview'}
   

    -- Smart collumn
    use {
        'm4xshen/smartcolumn.nvim',
        config = function()
            require("smartcolumn").setup {
                colorcolumn = {"80", "100"},
                disabled_filetypes = { "help", "text", "markdown", "typst",
                "asciidoc", "NvimTree", "lazy", "mason", "help", "checkhealth",
                "lspinfo", "noice", "Trouble", "fish", "zsh" },
            }
        end,
    }

--[[
    -- Center view
    use {
        'shortcuts/no-neck-pain.nvim',
        function()
            require("no-neck-pain").setup({
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
        -- vim.cmd("NoNeckPain")
    }

-- Code highlight
    -- Tree Sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "asm", "bash", "c", "c_sharp", "cmake", "cpp",
                    "css", "desktop", "diff", "elm", "git_config", "git_rebase", 
                    "gitattributes", "gitcommit", "gitignore", "glsl", "gpg", 
                    "http", "ini", "lua", "luadoc", "luap", "luau", "cmake",
                    "meson", "regex", "java", "json", "tmux", "todotxt",
                    "xml", "vim" },
                -- ignore_install = { 'org' },
                -- Install parsers synchronously (only applied to `ensure_installed`)
    	        sync_install = true,
    	        auto_install = true,
    	        highlight = {
    		    enable = true,
	        },
            }
      end,
    }
--]]
-- Markup highlight

    -- ASCIIDoc
    use {
        'marioortizmanero/adoc-pdf-live.nvim',
        config = "require('adoc_pdf_live').setup()"
    }

    -- Typst
    use {
        'kaarmu/typst.vim',
        ft = {'typst'}
    }
   
    -- Markdown
   --[[
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    --]]
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() 
            vim.g.mkdp_filetypes = { "markdown" },
            vim.g.mkdp_echo_preview_url == 1,
            vim.g.mkdp_browser == 'zen-browser'
        end,
            ft = { "markdown" }, 
        })

    -- org-mode
    use {
        'nvim-orgmode/orgmode',
        requires = {'danilshvalov/org-modern.nvim', 'akinsho/org-bullets.nvim',
        "nvim-orgmode/telescope-orgmode.nvim"
    },
        config = function()
            local daily_h = io.popen("date +%Y/%Y-%m-%d", 'r')
            local daily_s = daily_h:read("*l")
            daily_h:close()

            require('orgmode').setup({
                org_agenda_files = '~/documents/Notes/daily/**',
                org_default_notes_file = string.format(
                    '~/documents/Notes/daily/%s.org', tostring(daily_s)
                ),
                org_todo_keywords = {'TODO(t)', 'WAITING(w)', 'NEXT(n)', '|', 'DONE(d)'},
                org_log_done = true,
                ui = {
                    menu = {
                        handler = function(data)
                            require('org-modern.menu'):new({
                            window = {
                            margin = { 1, 0, 1, 0 },
                            padding = { 0, 1, 0, 1 },
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
    }

    -- Sounds
    use {
        'jackplus-xyz/player-one.nvim',
        config = {
            run = 'asciidoc-pdf ./%f',
            is_enabled = false, -- Start with sounds disabled until explicitly enabled
            min_interval = 0.1, -- Increase delay between sounds to 100ms
            theme = "synth",    -- Use the synthesizer sound theme
            }
        }

      -- Git integrations
--    use 'lewis6991/gitsigns.nvim'
end)
