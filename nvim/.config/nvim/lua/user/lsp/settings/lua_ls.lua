return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            format = {
                enable = false,
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
}
