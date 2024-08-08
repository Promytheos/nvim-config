require("toggleterm").setup {}
local terminal = require("toggleterm.terminal").Terminal
local lazygit = terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function Lazygit_Toggle()
  lazygit:toggle()
end

return {
  { "-",                "<cmd>Oil<cr>",                   desc = "Open Parent Dir in Oil" },
  { "<leader><leader>", "<cmd>Alpha<cr>",                 desc = "Open Dashboard" },

  { "<leader>f",        group = "file" }, -- group
  { "<leader>ff",       "<cmd>Telescope find_files<cr>",  desc = "Find File",             mode = "n" },
  { "<leader>fg",       "<cmd>Telescope grep_string<cr>", desc = "Find String",           mode = "n" },
  { "<leader>fh",       "<cmd>Telescope help_tags<cr>",   desc = "Help Tags",             mode = "n" },
  { "<leader>fh",       "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files",          mode = "n" },
  { "<leader>f?",       "<cmd>Telescope builtin<cr>",     desc = "All Commands",          mode = "n" },

  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  { "<A-x>",      "<cmd>:lua require(\"mini.bufremove\").delete(0)<cr>", desc = "Delete Current Buffer" },
  { "<A-X>",      "<cmd>1,.-bd | .+1,$bd<cr>",                           desc = "Delete Other Buffers" },
  { "<A-h>",      "<cmd>bp<cr>",                                         desc = "Go to Previous Buffer" },
  { "<A-l>",      "<cmd>bn<cr>",                                         desc = "Go to Next Buffer" },
  { "<A-o>",      "<cmd>b#<cr>",                                         desc = "Toggle Last Active Buffer" },
  { "<A-t>",      "<cmd>tabnew<cr>",                                     desc = "Create New Tab" },
  { "<A-w>",      "<cmd>tabc<cr>",                                       desc = "Close Tab" },

  { "<leader>p",  group = "plugins" },
  { "<leader>pm", "<cmd>Mason<cr>",                                      desc = "Open Mason LSP Plugin Manager" },
  { "<leader>pl", "<cmd>Lazy<cr>",                                       desc = "Open Lazy Plugin Manager" },

  { "<leader>t",  group = "terminal" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",                 desc = "ToggleTerm float" },
  { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>",            desc = "ToggleTerm horizontal" },
  { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",              desc = "ToggleTerm vertical" },
  { "<leader>tl", "<cmd>lua Lazygit_Toggle()<cr>",                       desc = "ToggleTerm lazygit" },
  { "<F7>",       "<cmd>ToggleTermToggleAll<cr>",                        desc = "Toggle Terminal",              mode = "nt" },


  -- Vim Built-In Functions
  { "<Esc>",      "<cmd>nohlsearch<cr>",                                 desc = "Clear Highlights" },
  { "<C-s>",      "<cmd>w<cr>",                                          desc = "Write" },
  { "<C-S-s>",    "<cmd>wa<cr>",                                         desc = "Write All" },
  { "<C-q>q",     "<cmd>confirm qall<cr>",                               desc = "Confirm Quit All" },
  { "<C-q>w",     "<cmd>confirm q<cr>",                                  desc = "Confirm Quit Window" },
  { "<C-q>b",     "<cmd>confirm bd<cr>",                                 desc = "Confirm Quit Buffer" },
  { "<C-q>f",     "<cmd>qa!<cr>",                                        desc = "Force Quit" },

  { "|",          "<cmd>vsplit<cr>",                                     desc = "Vertical Split" },
  { "\\",         "<cmd>split<cr>",                                      desc = "Horizontal Split" },

  { "<C-A-k>",    ":t .-1<cr>",                                          desc = "Copy Line Up" },
  { "<C-A-k>",    ":'<,'>t '<-1<cr>gv",                                  desc = "Copy Lines Up",                mode = 'v' },
  { "<C-A-j>",    ":t .<cr>",                                            desc = "Copy Line Down" },
  { "<C-A-j>",    ":'<,'>t '><cr>gv",                                    desc = "Copy Lines Down",              mode = 'v' },

  { "<C-S-k>",    ":m .-2<cr>",                                          desc = "Move Line Up" },
  { "<C-S-k>",    ":'<,'>m '<-2<cr>gv",                                  desc = "Move Lines Up",                mode = 'v' },
  { "<C-S-j>",    ":m .+1<cr>",                                          desc = "Move Line Down" },
  { "<C-S-j>",    ":'<,'>m '>+1<cr>gv",                                  desc = "Move Lines Down",              mode = 'v' },

  { "<C-i>",      "<cmd>Precognition peek<cr>" },


}
