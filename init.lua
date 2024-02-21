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
	}

})

-- VIM CONFIG --
vim.o.undofile = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.completeopt = 'menuone,noselect'

-- KEYMAP CONFIG --
-- [[
-- mode = { leader = { prefix = { key = { command, desc } } } } 
-- ]]
local whichKeyMappings = {
	n = {
	},
}

local function bindKey(binding, command, opts)
	opts = opts or { mode = 'n', silent = true, desc = '', noremap = true }
	opts.mode = opts.mode or 'n'
	local config = {}
	config.silent = opts.silent or true
	config.desc = opts.desc or ''
	config.noremap = opts.noremap or true
	vim.keymap.set(opts.mode, binding, command, config)
end


-- Telescope
local builtin = require('telescope.builtin')
whichKeyMappings.n['<leader>'] = {};
whichKeyMappings.n['<leader>'].f = {
	desc = "Telescope",
	f = { builtin.find_files, "Find Files" },
	g = { builtin.live_grep, "Live Grep" },
	b = { builtin.buffers, 'Find Buffers' },
	h = { builtin.help_tags, 'Help Tags' }
}

-- NvimTree 
whichKeyMappings.n['<leader>'].e = { '<cmd>NvimTreeToggle<cr>', 'Toggle NvimTree' }
whichKeyMappings.n['<leader>'].o = { '<cmd>NvimTreeFocus<cr>', 'Focus NvimTree' }

require('which-key').register(whichKeyMappings.n)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

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
bindKey('-', '<CMD>Oil<CR>', { desc = "Oil open parent dir" })

-- ToggleTerm
require("toggleterm").setup {}
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', hiddent = true, direction = 'float' })
function lazygit_toggle()
	lazygit:toggle()
end

bindKey('<leader>tl', '<cmd>lua lazygit_toggle()<cr>', { desc = 'ToggleTerm lazygit' })
bindKey('<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'ToggleTerm float' })

-- [[ Configure LSP ]]
-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

local servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false }
		}
	}
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('<leader>lf', vim.lsp.buf.format, 'Format Buffer')
  nmap('gd', vim.lsp.buf.definition,'[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Neodev
require("neodev").setup()

-- CMP
local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').default_capabilities(capabilities)

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
bindKey('<C-s>', '<cmd>w<cr>', { desc = 'Write' })
bindKey('<C-q>q', '<cmd>confirm qall<cr>', { desc = 'Confirm Quit All' })
bindKey('<C-q>w', '<cmd>confirm q<cr>', { desc = 'Confirm Quit Buffer' })
bindKey('<C-q>f', '<cmd>qa!<cr>', { desc = 'Force Quit' })
bindKey('|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
bindKey('\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })
bindKey('<Esc>', '<cmd>noh<cr>', { desc = 'Clear Highlights' })
bindKey('<C-h>', '<C-w>h', { desc = 'Window Left'})
bindKey('<C-l>', '<C-w>l', { desc = 'Window Right'})
bindKey('<C-k>', '<C-w>k', { desc = 'Window Up'})
bindKey('<C-j>', '<C-w>j', { desc = 'Window Down'})
bindKey('<C-A-j>', ':t.<cr>k', { desc = 'Copy Line Down' })
bindKey('<C-A-k>', ':t.<cr>', { desc = 'Copy Line Up' })
bindKey('<C-S-j>', ':m .+1<cr>', { desc = 'Move Line Down' })
bindKey('<C-S-k>', ':m .-2<cr>', { desc = 'Move Line Up' })
