local M = {}
M.registerLspKeymaps = function()
    local mappings = require("utils.mappings")
    local lspGroup = mappings.getGroupPrefix('<leader>', 'l')
    local goGroup = mappings.createGroup('Go To', 'g')

    lspGroup['r'] = { vim.lsp.buf.rename, 'LSP Rename' }
    lspGroup['a'] = { vim.lsp.buf.code_action, 'Code Action' }
    lspGroup['f'] = { vim.lsp.buf.format, 'Format Buffer' }
    lspGroup['T'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' }
    lspGroup['s'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' }
    lspGroup['w'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' }
    lspGroup['i'] = { '<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<cr>',
        'Toggle Inlay Hints' }
    lspGroup['h'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }

    mappings.registerKey('K', 'Hover Documentation' )

    goGroup.maps['d'] = { vim.lsp.buf.definition, 'Goto Definition' }
    goGroup.maps['r'] = { require('telescope.builtin').lsp_references, 'Goto References' }
    goGroup.maps['I'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' }
    goGroup.maps['D'] = { vim.lsp.buf.declaration, 'Goto Declaration' }

    require("utils.mappings").registerKeymaps()
end
return M
