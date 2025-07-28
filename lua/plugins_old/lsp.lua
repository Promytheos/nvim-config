return {
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
