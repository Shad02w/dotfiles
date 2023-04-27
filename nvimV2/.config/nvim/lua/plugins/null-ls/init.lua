return {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufRead',
    config = function()
        local null_ls = require 'null-ls'

        local eslint = require 'plugins.null-ls.eslint'
        local cspell = require 'plugins.null-ls.cspell'
        local prettier_d = require 'plugins.null-ls.prettier'

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        null_ls.setup {
            debug = true,
            sources = {
                -- Lua
                formatting.stylua,

                -- JS, why JS have so many things to setup, it sucks
                prettier_d.create_prettier_source 'formatting',
                eslint.create_eslint_d_source 'formatting',
                eslint.create_eslint_d_source 'diagnostics',
                eslint.create_eslint_d_source 'code_actions',
                formatting.stylelint,
                diagnostics.stylelint,

                cspell.create_diagnostics_source(),
                code_actions.cspell,
            },
        }
    end,
}
