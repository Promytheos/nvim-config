local M = {
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
    },
    close_if_last_window = true,
    default_component_configs = {
        git_status = {
            symbols = {
                added     = "",
                deleted   = "",
                modified  = "",
                renamed   = "",
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            },
            align = "right",
        },
    },
}

return M
