return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre' },
    config = function()
        local null_ls = require 'null-ls'
        null_ls.setup {
            sources = {
                null_ls.builtins.formatting.stylua,
            },
        }
    end,
}
