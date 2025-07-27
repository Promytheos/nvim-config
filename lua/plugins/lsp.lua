return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "ts_ls" },
      automatic_enable = {
        exclude = { "jdtls" }
      }
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "neovim/nvim-lspconfig",
        config = function()
          require("lspconfig").lua_ls.setup {}
        end
      },
    },
  },
  { "mfussenegger/nvim-jdtls" },
}
