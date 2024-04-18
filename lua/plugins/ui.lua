return {
    {
        'goolord/alpha-nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup(require("config.gitsigns-config"))
        end
    },
    {
        'stevearc/dressing.nvim', opts = {},
    },
    {
        'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons', opts = {}
    },
    {
        'b0o/incline.nvim',
        config = function()
            require('incline').setup()
        end,
        -- Optional: Lazy load Incline
        event = 'VeryLazy',
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/noice.nvim' },
        config = function()
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            vim.o.laststatus = vim.g.lualine_laststatus
            require('lualine').setup(require("config.lualine-config"))
        end
    },
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup(require("config.catppuccin-config"))
        end
    },
    {
        'folke/noice.nvim',
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                },
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                    throttle = 1000 / 10,
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,     -- use a classic bottom cmdline for search
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,       -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,   -- add a border to hover docs and signature help
                },
            })
        end
    },
    {
        'rcarriga/nvim-notify',
        event = "VeryLazy",
        config = function ()
            require("notify").setup({
                stages="static",
            })
        end
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {}
    },
    {
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        opts = {
            signs = false
        }
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {},
    },
}
