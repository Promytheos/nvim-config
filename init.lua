---@diagnostic disable: missing-fields
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
	{ 'folke/which-key.nvim',  opts = {} },
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
			{ 'j-hui/fidget.nvim',       opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},
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
		'akinsho/toggleterm.nvim',
		version = '*',
		config = true
	},
	{
		'mfussenegger/nvim-jdtls'
	},
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {}
	}

})

-- VIM CONFIG --
vim.o.undofile = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.completeopt = 'menuone,noselect'
vim.wo.signcolumn = 'no'
vim.cmd[[colorscheme tokyonight-night]]

-- KEYMAP CONFIG --
-- [[
-- mode = { leader = { prefix = { key = { command, desc } } } }
-- ]]
local keymaps = {
	n = {}
}

local groups = {
	f = { desc = " Find" },
	p = { desc = '󰏓 Manage Packages' },
	l = { desc = ' LSP' },
	u = { desc = ' UI' },
	b = { desc = '󰓩 Buffers' },
	d = { desc = ' Debugger' },
	t = { desc = ' Terminal' },
}

-- Telescope
local builtin = require('telescope.builtin')
keymaps.n['<leader>'] = {}
groups.f['f'] = { builtin.find_files, "Find Files" }
groups.f['g'] = { builtin.live_grep, "Live Grep" }
groups.f['b'] = { builtin.buffers, 'Find Buffers' }
groups.f['h'] = { builtin.help_tags, 'Help Tags' }
keymaps.n['<leader>'].f = groups.f

-- NvimTree
keymaps.n['<leader>'].e = { '<cmd>NvimTreeToggle<cr>', '󱏒 Toggle NvimTree' }


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup {
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = { 'c', 'cpp', 'go', 'java', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = false,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<c-space>',
				node_incremental = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<M-space>',
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		},
	}
end, 0)

-- Oil
keymaps.n['-'] = { '<cmd>Oil<cr>', '󰏇 Open Parent Dir in Oil' }

-- ToggleTerm
require("toggleterm").setup {}
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', hiddent = true, direction = 'float' })
function lazygit_toggle()
	lazygit:toggle()
end

groups.t['l'] = { '<cmd>lua lazygit_toggle()<cr>', 'ToggleTerm lazygit' }
groups.t['f'] = { '<cmd>ToggleTerm direction=float<cr>', 'ToggleTerm float' }
keymaps.n['<leader>'].t = groups.t

-- [[ Configure LSP ]]
-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

local on_attach = function(_)
	groups.l['r'] = { vim.lsp.buf.rename, 'LSP Rename' }
	groups.l['a'] = { vim.lsp.buf.code_action, 'Code Action' }
	groups.l['f'] = { vim.lsp.buf.format, 'Format Buffer' }
	keymaps.n['gd'] = { vim.lsp.buf.definition, 'Goto Definition' }
	keymaps.n['gr'] = { require('telescope.builtin').lsp_references, 'Goto References' }
	keymaps.n['gI'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' }
	groups.l['T'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' }
	groups.l['s'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' }
	groups.l['w'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' }

	keymaps.n['K'] = { vim.lsp.buf.hover, 'Hover Documentation' }
	groups.l['h'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }

	-- Lesser used LSP functionality
	keymaps.n['gD'] = { vim.lsp.buf.declaration, 'Goto Declaration' }

	keymaps.n['<leader>'].l = groups.l
	require("plugins.mappings").setMappings(keymaps.n)
	require("plugins.mappings").registerKeymaps()
end

groups.l['r'] = { vim.lsp.buf.rename, 'LSP Rename' }
groups.l['a'] = { vim.lsp.buf.code_action, 'Code Action' }
groups.l['f'] = { vim.lsp.buf.format, 'Format Buffer' }
keymaps.n['gd'] = { vim.lsp.buf.definition, 'Goto Definition' }
keymaps.n['gr'] = { require('telescope.builtin').lsp_references, 'Goto References' }
keymaps.n['gI'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' }
groups.l['T'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' }
groups.l['s'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' }
groups.l['w'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' }

keymaps.n['K'] = { vim.lsp.buf.hover, 'Hover Documentation' }
groups.l['h'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }

-- Lesser used LSP functionality
keymaps.n['gD'] = { vim.lsp.buf.declaration, 'Goto Declaration' }

keymaps.n['<leader>'].l = groups.l
-- Neodev
require("neodev").setup()

-- CMP
local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false }
		}
	}
}

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers)
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end,
	['jdtls'] = function()
	end
}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
	},
}


-- Vim Built-In Functions
keymaps.n['<C-s>'] = { '<cmd>w<cr>', 'Write' }
keymaps.n['<C-q>q'] = { '<cmd>confirm qall<cr>', 'Confirm Quit All' }
keymaps.n['<C-q>w'] = { '<cmd>confirm q<cr>', 'Confirm Quit Buffer' }
keymaps.n['<C-q>f'] = { '<cmd>qa!<cr>', 'Force Quit' }
keymaps.n['|'] = { '<cmd>vsplit<cr>', 'Vertical Split' }
keymaps.n['\\'] = { '<cmd>split<cr>', 'Horizontal Split' }
keymaps.n['<Esc>'] = { '<cmd>noh<cr>', 'Clear Highlights' }
keymaps.n['<C-h>'] = { '<C-w>h', 'Window Left' }
keymaps.n['<C-l>'] = { '<C-w>l', 'Window Right' }
keymaps.n['<C-k>'] = { '<C-w>k', 'Window Up' }
keymaps.n['<C-j>'] = { '<C-w>j', 'Window Down' }
keymaps.n['<C-A-j>'] = { ':t.<cr>k', 'Copy Line Down' }
keymaps.n['<C-A-k>'] = { ':t.<cr>', 'Copy Line Up' }
keymaps.n['<C-S-j>'] = { ':m .+1<cr>', 'Move Line Down' }
keymaps.n['<C-S-k>'] = { ':m .-2<cr>', 'Move Line Up' }

require("plugins.mappings").setMappings(keymaps.n)
require("plugins.mappings").registerKeymaps()
