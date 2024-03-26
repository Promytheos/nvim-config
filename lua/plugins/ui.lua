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
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup(require("config.catppuccin-config"))
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
