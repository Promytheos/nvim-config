---@diagnostic disable: missing-fields
require("config.neovim-config")
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

vim.cmd [[colorscheme catppuccin-mocha]]

local wk = require("which-key")
local keymaps = require("config.keymap-config")
local lsp_keymaps = require("config.lsp-keymaps")

wk.add(keymaps)
wk.add(lsp_keymaps)

-- [[ Configure LSP ]]
local capabilities = vim.lsp.protocol.make_client_capabilities()
require("cmp_nvim_lsp").default_capabilities(capabilities)
require("luasnip.loaders.from_vscode").lazy_load()
