---@diagnostic disable: missing-fields
require("config.neovim")
-- LAZY SETUP ---[[ - ]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob::none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS CONFIG --
require("lazy").setup({
    { import = "plugins" },
})

vim.cmd [[colorscheme tokyonight-night]]

-- TODO: Move to mappings file
local mappings = require("utils.mappings")

-- Telescope
local builtin = require("telescope.builtin")
local find_group = mappings.get_group_prefix("<leader>", "f")

find_group["f"] = { builtin.find_files, "Find Files" }
find_group["g"] = { builtin.live_grep, "Live Grep" }
find_group["b"] = { builtin.buffers, "Find Buffers" }
find_group["h"] = { builtin.help_tags, "Help Tags" }

-- NeoTree
mappings.register_key("<leader>e", "<cmd>Neotree toggle reveal_force_cwd<cr>", { desc = "󱏒 Toggle NeoTree" })

-- Buffers
local buffer_group = mappings.get_group_prefix("<leader>", "b")
buffer_group["d"] = { "<cmd>bd<cr>", "Delete Current Buffer (Alt-x)" }
buffer_group["D"] = { "<cmd>1,.-bd | .+1,$bd<cr>", "Delete Other Buffers (Alt-X)" }
buffer_group["p"] = { "<cmd>bp<cr>", "Go to Previous Buffer (Alt-j)" }
buffer_group["n"] = { "<cmd>bn<cr>", "Go to Next Buffer (Alt-l)" }
buffer_group["t"] = { "<cmd>b#<cr>", "Toggle Last Active Buffer (Alt-o)" }

mappings.register_key("<A-x>", "<cmd>bd<cr>", { desc = "Delete Current Buffer" })
mappings.register_key("<A-X>", "<cmd>1,.-bd | .+1,$bd<cr>", { desc = "Delete Other Buffers" })
mappings.register_key("<A-h>", "<cmd>bp<cr>", { desc = "Go to Previous Buffer" })
mappings.register_key("<A-l>", "<cmd>bn<cr>", { desc = "Go to Next Buffer" })
mappings.register_key("<A-o>", "<cmd>b#<cr>", { desc = "Toggle Last Active Buffer" })
mappings.register_key("<A-t>", "<cmd>tabnew<cr>", { desc = "Create New Tab" })
mappings.register_key("<A-w>", "<cmd>tabc<cr>", { desc = "Close Tab" })

-- Plugin Manager
local plugin_group = mappings.get_group_prefix("<leader>", "p")
plugin_group["m"] = { "<cmd>Mason<cr>", "Open Mason LSP Plugin Manager" }
plugin_group["l"] = { "<cmd>Lazy<cr>", "Open Lazy Plugin Manager" }

mappings.register_key("<leader>h", "<cmd>Alpha<cr>", { desc = "Open Dashboard" })

-- Oil
mappings.register_key("-", "<cmd>Oil<cr>", { desc = "󰏇 Open Parent Dir in Oil" })

-- ToggleTerm
require("toggleterm").setup {}
local terminal = require("toggleterm.terminal").Terminal
local lazygit = terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function Lazygit_Toggle()
    lazygit:toggle()
end

local terminal_group = mappings.get_group_prefix("<leader>", "t")
terminal_group["l"] = { "<cmd>lua lazygit_toggle()<cr>", "ToggleTerm lazygit" }
terminal_group["f"] = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" }
terminal_group["h"] = { "<cmd>ToggleTerm direction=horizontal<cr>", "ToggleTerm Horizontal" }
terminal_group["v"] = { "<cmd>ToggleTerm direction=vertical<cr>", "ToggleTerm Vertical" }
mappings.register_key("<F7>", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle Terminal" })
mappings.register_key("<F7>", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle Terminal", mode = "t" })

-- [[ Configure LSP ]]

-- CMP
local capabilities = vim.lsp.protocol.make_client_capabilities()
require("cmp_nvim_lsp").default_capabilities(capabilities)
require("luasnip.loaders.from_vscode").lazy_load()


-- Vim Built-In Functions
mappings.register_key("<C-s>", "<cmd>w<cr>", { desc = "Write" })
mappings.register_key("<C-q>q", "<cmd>confirm qall<cr>", { desc = "Confirm Quit All" })
mappings.register_key("<C-q>w", "<cmd>confirm q<cr>", { desc = "Confirm Quit Window" })
mappings.register_key("<C-q>b", "<cmd>confirm bd<cr>", { desc = "Confirm Quit Buffer" })
mappings.register_key("<C-q>f", "<cmd>qa!<cr>", { desc = "Force Quit" })
mappings.register_key("|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
mappings.register_key("\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
mappings.register_key("<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlights" })
mappings.register_key("<C-h>", "<C-w>h", { desc = "Window Left" })
mappings.register_key("<C-l>", "<C-w>l", { desc = "Window Right" })
mappings.register_key("<C-k>", "<C-w>k", { desc = "Window Up" })
mappings.register_key("<C-j>", "<C-w>j", { desc = "Window Down" })
mappings.register_key("<C-A-j>", ":t.<cr>k", { desc = "Copy Line Down" })
mappings.register_key("<C-A-k>", ":t.<cr>", { desc = "Copy Line Up" })
mappings.register_key("<C-S-j>", ":m .+1<cr>", { desc = "Move Line Down" })
mappings.register_key("<C-S-k>", ":m .-2<cr>", { desc = "Move Line Up" })

mappings.register_keymaps()
