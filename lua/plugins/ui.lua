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
    -- {
    --     'nvim-lualine/lualine.nvim',
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    --     opts = require("config.lualine-config")
    -- },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {}
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
