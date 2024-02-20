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
		version = '*',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('nvim-tree').setup {}
		end,
	},
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		}
	},
	{
		'nvim-telescope/telescope.nvim', 
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',			
		}
	},
	{
		'lewis6991/gitsigns.nvim'
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {}
	},
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = true 
	}

})

-- KEYMAP CONFIG --
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
