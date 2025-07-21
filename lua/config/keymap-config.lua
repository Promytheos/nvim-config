local gs = package.loaded.gitsigns

return {
  { "-", "<cmd>Oil<cr>", desc = "Open Parent Dir" },
  { "<leader><leader>", "<cmd>Alpha<cr>", desc = "Dashboard", icon = '' },

  -- Telescope Functions
  { "<leader>f", group = "Find" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word", mode = "n" },
  { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find String", mode = "n" },
  { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" },
  { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Color Scheme", mode = "n" },
  { "<leader>f*", "<cmd>Telescope builtin<cr>", desc = "All Commands", mode = "n" },

  { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", mode = "n" },
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer", mode = "n" },
  { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undo Tree", mode = "n" },

  { "<A-x>", "<cmd>:lua require(\"mini.bufremove\").delete(0)<cr>", desc = "Delete Current Buffer" },
  { "<A-X>", "<cmd>1,.-bd | .+1,$bd<cr>", desc = "Delete Other Buffers" },
  { "<A-h>", "<cmd>bp<cr>", desc = "Go to Previous Buffer" },
  { "<A-l>", "<cmd>bn<cr>", desc = "Go to Next Buffer" },
  { "<A-o>", "<cmd>b#<cr>", desc = "Toggle Last Active Buffer" },
  { "<A-t>", "<cmd>tabnew<cr>", desc = "Create New Tab" },
  { "<A-w>", "<cmd>tabc<cr>", desc = "Close Tab" },

  -- Plugin Functions
  { "<leader>p", group = "Plugins", icon = "" },
  { "<leader>pm", "<cmd>Mason<cr>", desc = "Open Mason LSP Plugin Manager" },
  { "<leader>pl", "<cmd>Lazy<cr>", desc = "Open Lazy Plugin Manager" },

  -- ToggleTerm Functions
  { "<leader>t", group = "Terminal" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
  { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal" },
  { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical" },
  { "<F7>",       "<cmd>ToggleTermToggleAll<cr>", desc = "Toggle Terminal",          mode = "nt" },

  { "<leader>g",  group = "Git" },
  { "<leader>gb", gs.toggle_current_line_blame,   desc = 'Toggle Current Line Blame' },
  {
    "<leader>gB",
    function()
      gs.blame_line { full = true }
    end,
    desc = 'Toggle Full Line Blame'
  },
  {
    "<leader>gl",
    function()
      local terminal = require("toggleterm.terminal").Terminal
      local lazygit = terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
      lazygit:toggle()
    end,
    desc = "Lazygit"
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
  { "\\",      "<cmd>split<cr>",            desc = "Horizontal Split" }
}
