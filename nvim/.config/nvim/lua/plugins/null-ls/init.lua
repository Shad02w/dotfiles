return {
    'nvimtools/none-ls.nvim',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre' },
    -- eslintd and eslint is deprecated in null-ls, use eslint-lsp or none-ls-extras instead
    config = function()
        local null_ls = require 'null-ls'
        local cspell = require 'plugins.null-ls.cspell'

        null_ls.setup {
            sources = {
                cspell.create_code_actions_source(),
                cspell.create_diagnostics_source(),
            },
        }
    end,
}
