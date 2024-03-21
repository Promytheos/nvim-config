return {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },

    current_line_blame = true,
    current_line_blame_opts = {},
    on_attach = function (bufnr)
        local gs = package.loaded.gitsigns
        local gitGroup = require("utils.mappings").get_group_prefix('<leader>', 'l')

        gitGroup['b'] = { gs.toggle_current_line_blame, 'Toggle Current Line Blame' }
        gitGroup['B'] = { function ()
            gs.blame_line{full=true}
        end, 'Toggle Full Line Blame'}

        require('utils.mappings').register_keymaps()
    end
}
