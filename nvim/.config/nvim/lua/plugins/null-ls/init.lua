return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre' },
    -- eslintd and eslint is deprecated in null-ls, use eslint-lsp or none-ls-extras instead
    commit = 'fbdcbf8e152529af846b3a333f039751829b84c2',
    config = function()
        local null_ls = require 'null-ls'
        local cspell = require 'plugins.null-ls.cspell'
        local prettier = require 'plugins.null-ls.prettier'
        local eslint = require 'plugins.null-ls.eslint'

        null_ls.setup {
            sources = {
                cspell.create_code_actions_source(),
                cspell.create_diagnostics_source(),

                -- lua
                null_ls.builtins.formatting.stylua,

                -- prettier
                prettier.create_prettier_source 'formatting',

                -- eslint
                eslint.create_eslint_d_source 'diagnostics',
                eslint.create_eslint_d_source 'code_actions',
                eslint.create_eslint_d_source 'formatting',
            },
        }
    end,
}
