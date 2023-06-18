return {
    'sam4llis/nvim-tundra',
    config = function()
        require('nvim-tundra').setup {
            plugins = {
                lsp = true,
                treesitter = true,
                telescope = true,
                gitsigns = true,
            },
        }
    end,
}
