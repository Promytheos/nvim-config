---@diagnostic disable: missing-fields
require("config.neovim")
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
    { import = 'plugins' },
    { 'numToStr/Comment.nvim', opts = {} },
})

vim.cmd [[colorscheme tokyonight-night]]

local mappings = require("utils.mappings")

-- Telescope
local builtin = require('telescope.builtin')
local findGroup = mappings.getGroupPrefix('<leader>', 'f')

findGroup['f'] = { builtin.find_files, "Find Files" }
findGroup['g'] = { builtin.live_grep, "Live Grep" }
findGroup['b'] = { builtin.buffers, 'Find Buffers' }
findGroup['h'] = { builtin.help_tags, 'Help Tags' }

-- NeoTree
mappings.registerKey('<leader>e','<cmd>Neotree toggle<cr>',{  desc = '󱏒 Toggle NeoTree' })

-- Buffers
local bufferGroup = mappings.getGroupPrefix('<leader>', 'b')
bufferGroup['d'] = { '<cmd>bd<cr>', 'Delete Current Buffer'}
bufferGroup['p'] = { '<cmd>bp<cr>', 'Go to Previous Buffer'}
bufferGroup['n'] = { '<cmd>bn<cr>', 'Go to Next Buffer'}
bufferGroup['t'] = { '<cmd>b#<cr>', 'Toggle Last Active Buffer'}
bufferGroup['D'] = { '<cmd>1,.-bd | .+1,$bd<cr>', 'Delete Other Buffers'}

mappings.registerKey('<A-h>', '<cmd>bp<cr>', 'Go to Previous Buffer')
mappings.registerKey('<A-o>', '<cmd>b#<cr>', 'Toggle Last Active Buffer')
mappings.registerKey('<A-l>', '<cmd>bn<cr>', 'Go to Next Buffer')
mappings.registerKey('<A-t>', '<cmd>tabnew<cr>', 'Create New Tab')
mappings.registerKey('<A-w>', '<cmd>tabc<cr>', 'Close Tab')


-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = {
            'java',
            'lua',
            'rust',
            'javascript',
            'typescript',
            'vimdoc',
            'vim',
            'bash'
        },

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
                lookahead = true,
                keymaps = {
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
                set_jumps = true,
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
        },
    }
end, 0)

-- Oil
mappings.registerKey('-', '<cmd>Oil<cr>', { desc = '󰏇 Open Parent Dir in Oil' })

-- ToggleTerm
require("toggleterm").setup {}
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', hiddent = true, direction = 'float' })
function lazygit_toggle()
    lazygit:toggle()
end

local terminalGroup = mappings.getGroupPrefix('<leader>', 't')
terminalGroup['l'] = { '<cmd>lua lazygit_toggle()<cr>', 'ToggleTerm lazygit' }
terminalGroup['f'] = { '<cmd>ToggleTerm direction=float<cr>', 'ToggleTerm float' }
terminalGroup['h'] = { '<cmd>ToggleTerm direction=horizontal<cr>', 'ToggleTerm Horizontal' }
terminalGroup['v'] = { '<cmd>ToggleTerm direction=vertical<cr>', 'ToggleTerm Vertical' }
mappings.registerKey('<F7>', '<cmd>ToggleTermToggleAll<cr>', { desc = 'Toggle Terminal' })
mappings.registerKey('<F7>', '<cmd>ToggleTermToggleAll<cr>', { desc = 'Toggle Terminal', mode = 't' })

-- [[ Configure LSP ]]
-- Neodev
require("neodev").setup()
-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- CMP
local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true }
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
            on_attach = require("config.lsp-keymaps").registerLspKeymaps,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
    ['jdtls'] = function()
    end,
    ['tsserver'] = function()
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
mappings.registerKey('<C-s>', '<cmd>w<cr>', { desc = 'Write' })
mappings.registerKey('<C-q>q', '<cmd>confirm qall<cr>', { desc = 'Confirm Quit All' })
mappings.registerKey('<C-q>w', '<cmd>confirm q<cr>', { desc = 'Confirm Quit Buffer' })
mappings.registerKey('<C-q>f', '<cmd>qa!<cr>', { desc = 'Force Quit' })
mappings.registerKey('|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
mappings.registerKey('\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })
mappings.registerKey('<Esc>', '<cmd>noh<cr>', { desc = 'Clear Highlights' })
mappings.registerKey('<C-h>', '<C-w>h', { desc = 'Window Left' })
mappings.registerKey('<C-l>', '<C-w>l', { desc = 'Window Right' })
mappings.registerKey('<C-k>', '<C-w>k', { desc = 'Window Up' })
mappings.registerKey('<C-j>', '<C-w>j', { desc = 'Window Down' })
mappings.registerKey('<C-A-j>', ':t.<cr>k', { desc = 'Copy Line Down' })
mappings.registerKey('<C-A-k>', ':t.<cr>', { desc = 'Copy Line Up' })
mappings.registerKey('<C-S-j>', ':m .+1<cr>', { desc = 'Move Line Down' })
mappings.registerKey('<C-S-k>', ':m .-2<cr>', { desc = 'Move Line Up' })

require("utils.mappings").registerKeymaps()
