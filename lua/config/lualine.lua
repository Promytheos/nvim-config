local M = {
    options = {
        icons_enabled = true,
        theme = 'horizon',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'neo-tree' },
            winbar = { 'neo-tree' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress', 'location' },
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {
        lualine_a = {},
        lualine_b = {
            {
                'buffers',
                show_filename_only = true,       -- Shows shortened relative path when set to false.
                hide_filename_extension = false, -- Hide filename extension when set to true.
                show_modified_status = true,     -- Shows indicator when the buffer is modified.

                mode = 0,                        -- 0: Shows buffer name
                -- 1: Shows buffer index
                -- 2: Shows buffer name + buffer index
                -- 3: Shows buffer number
                -- 4: Shows buffer name + buffer number

                max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                -- it can also be a function that returns
                -- the value of `max_length` dynamically.
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    packer = 'Packer',
                    fzf = 'FZF',
                    alpha = 'Alpha'
                }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                -- Automatically updates active buffer color to match color of omther components (will be overidden if buffers_color is set)
                use_mode_colors = false,

                -- buffers_color = {
                --     -- Same values as the general color option can be used here.
                --     active = 'lualine_{section}_normal', -- Color for active buffer.
                --     inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
                -- },

                symbols = {
                    modified = ' ●', -- Text to show when the buffer is modified
                    alternate_file = '#', -- Text to show to identify the alternate file
                    directory = '', -- Text to show when the buffer is a directory
                },
            }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            { 'datetime', style = '%H:%M' },
            { 'datetime', style = '%d-%m-%y' }
        },
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {}
}

return M
