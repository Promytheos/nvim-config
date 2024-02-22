return {
	{
		'lewis6991/gitsigns.nvim'
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = { theme = 'horizon' }
		}
	},
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {}
	},
	{
		'folke/which-key.nvim',
		opts = {}
	}
}
