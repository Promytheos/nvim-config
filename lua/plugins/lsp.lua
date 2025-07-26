return {
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = {
          enabled = true,
          runtime = true,
          types = true,
          plugins = true,
          -- plugins = {} add list of stuffs like plenary and nui
        },
        lspconfig = true
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      local mason_config = require("config.mason-config")
      require("mason-lspconfig").setup(mason_config)
    end
  },
  { "mfussenegger/nvim-jdtls" },
}
