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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "folke/neodev.nvim",
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      luasnip.setup {}

      local cmp_config = require("config.cmp-config")
      require("cmp").setup(cmp_config)
    end
  },
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    config = function()
      local treesitter_config = require("config.treesitter-config")
      require("nvim-treesitter.configs").setup(treesitter_config)
    end,
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
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = require("config.lsp-keymaps").register_lsp_keymaps,
    },
  },
}
