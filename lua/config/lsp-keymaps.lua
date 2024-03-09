local M = {}
M.register_lsp_keymaps = function()
    local mappings = require("utils.mappings")
    local lsp_group = mappings.get_group_prefix('<leader>', 'l')
    local go_group = mappings.create_group('Go To', 'g')

    lsp_group['r'] = { vim.lsp.buf.rename, 'LSP Rename' }
    lsp_group['a'] = { vim.lsp.buf.code_action, 'Code Action' }
    lsp_group['f'] = { vim.lsp.buf.format, 'Format Buffer' }
    lsp_group['T'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' }
    lsp_group['s'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' }
    lsp_group['w'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' }
    lsp_group['i'] = { '<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<cr>',
        'Toggle Inlay Hints' }
    lsp_group['h'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }
    lsp_group['d'] = { vim.diagnostic.open_float, 'Open Diagnostics' }
    lsp_group['q'] = { vim.diagnostic.setloclist, 'Add Buffer Diagnostics to Quickfix' }
    lsp_group['Q'] = { vim.diagnostic.setqflist, 'Add All Diagnostics to Quickfix' }

    mappings.register_key('K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

    go_group.maps['d'] = { vim.lsp.buf.definition, 'Goto Definition' }
    go_group.maps['r'] = { require('telescope.builtin').lsp_references, 'Goto References' }
    go_group.maps['I'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' }
    go_group.maps['D'] = { vim.lsp.buf.declaration, 'Goto Declaration' }
    go_group.maps['j'] = { vim.diagnostic.goto_next, 'Goto Next Diagnostic' }
    go_group.maps['k'] = { vim.diagnostic.goto_prev, 'Goto Prev Diagnostic' }

    require("utils.mappings").register_keymaps()
end
return M
