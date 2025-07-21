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
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      local dap_config = require("config.dap-config")
      require("dap").configurations.java = dap_config.configurations.java;
    end,
    keys = {
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint"
      },

      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue"
      },

      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor"
      },

      {
        "<leader>dp",
        function() require("dap").pause() end,
        desc = "Pause"
      },

      {
        "<leader>ds",
        function() require("dap").stop() end,
        desc = "Stop"
      },

      {
        "<leader>dT",
        function() require("dap").terminate() end,
        desc = "Terminate"
      },

      {
        "<leader>da",
        function() require("dap").attach() end,
        desc = "Attach"
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI"
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
  }
}
