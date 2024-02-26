return {
    {
        'lewis6991/gitsigns.nvim'
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = require("config.lualine")
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {}
    },
    {
        'folke/which-key.nvim',
        opts = {}
    }
}
