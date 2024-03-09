return {
    defaults = {
        border = false,
        layout_strategy = 'vertical'
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        }
    }
}
