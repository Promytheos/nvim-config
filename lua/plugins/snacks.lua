return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = { enabled = true },
      git = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      layout = { enabled = true },
      lazygit = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Dir" },
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },

      -- find
      { "<leader>b",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fo",      function() Snacks.picker.recent() end,                                  desc = "Recent" },

      -- Grep
      --
      -- git
      { "<leader>gl",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },

      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      -- TODO: Replace with whichkey??
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
      { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
      { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<A-x>",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<A-h>", "<cmd>bp<cr>", desc = "Go to Previous Buffer" },
      { "<A-l>", "<cmd>bn<cr>", desc = "Go to Next Buffer" },
      { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
      { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
      { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
      -- Vim Built-In Functions
      { "<Esc>",   "<cmd>nohlsearch<cr>",       desc = "Clear Highlights" },
      { "<C-s>",   "<cmd>w<cr>",                desc = "Write" },
      { "<C-s>a",  "<cmd>wa<cr>",               desc = "Write All" },
      { "<C-q>b",  "<cmd>confirm bd<cr>",       desc = "Confirm Quit Buffer" },
      { "<C-q>w",  "<cmd>confirm q<cr>",        desc = "Confirm Quit Window" },
      { "<C-q>q",   "<cmd>confirm qall<cr>",    desc = "Confirm Quit All" },
      { "<C-q>f",  "<cmd>qa!<cr>",              desc = "Force Quit" },

      { "|",       "<cmd>vsplit<cr>",           desc = "Vertical Split" },
      { "\\",      "<cmd>split<cr>",            desc = "Horizontal Split" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  }
}
