return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'nvim-telescope/telescope-ui-select.nvim'
      }
    },
    config = function()
      local telescopeConfig = require("config.telescope-config")
      require("telescope").setup(telescopeConfig)
      pcall(require("telescope").load_extension, 'fzf')
      pcall(require("telescope").load_extension, 'ui-select')
    end
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  }
}
