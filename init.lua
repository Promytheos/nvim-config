-- INIT CONFIG --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Added for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colours. TODO: Check this again
vim.opt.termguicolors = true

-- LAZY SETUP ---[[ - ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob::none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS CONFIG --
require('lazy').setup({
	{ 'folke/which-key.nvim', opts = {} },
	{ 'numToStr/Comment.nvim', opts = {} },
	{ 
		'nvim-tree/nvim-tree.lua', 
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},
	{
		'nvim-telescope/telescope.nvim', 
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
})

-- KEYMAP CONFIG --
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
