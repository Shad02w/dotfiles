return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPost' },
    config = function()
        local null_ls = require 'null-ls'
        local cspell = require('plugins.null-ls.cspell')
        null_ls.setup {
            sources = {
                null_ls.builtins.formatting.stylua,
                cspell.create_diagnostics_source()
            },
        }
    end,
}
