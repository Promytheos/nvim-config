local M = {}
M.registerLspKeymaps = function()
    local keymaps = { n = {} }
    local groups = require("utils.mappings").setGroup('l')
    groups['r'] = { vim.lsp.buf.rename, 'LSP Rename' }
    groups['a'] = { vim.lsp.buf.code_action, 'Code Action' }
    groups['f'] = { vim.lsp.buf.format, 'Format Buffer' }
    keymaps.n['gd'] = { vim.lsp.buf.definition, 'Goto Definition' }
    keymaps.n['gr'] = { require('telescope.builtin').lsp_references, 'Goto References' }
    keymaps.n['gI'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' }
    groups['T'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' }
    groups['s'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' }
    groups['w'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' }
    groups['i'] = { '<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<cr>',
        'Toggle Inlay Hints' }

    keymaps.n['K'] = { vim.lsp.buf.hover, 'Hover Documentation' }
    groups['h'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }

    keymaps.n['gD'] = { vim.lsp.buf.declaration, 'Goto Declaration' }
    keymaps.n['<leader>'] = {};
    keymaps.n['<leader>'].l = groups;
    require("utils.mappings").setMappings(keymaps.n)
    require("utils.mappings").registerKeymaps()
end
return M
