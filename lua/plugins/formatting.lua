return {
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      local miniConfig = require("config.mini-config");
      -- TODO: Look at moving extensions into config
      require('mini.surround').setup()
      require("mini.ai").setup(miniConfig.ai)
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {}
  },
}
