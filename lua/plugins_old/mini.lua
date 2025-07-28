return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    opts = {
      ai = {
        n_lines = 500
      },
    },
    config = function()
      local miniConfig = require("config.mini-config");
      require('mini.surround').setup()
      require("mini.ai").setup(miniConfig.ai)
    end
  },
}
