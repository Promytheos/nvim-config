return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = require("config.telescope"),
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require('neo-tree').setup(require("config.neotree"))
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    }
}
