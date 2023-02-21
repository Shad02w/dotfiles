local saferequire = require 'user.util.saferequire'
local eslint = require 'user.null-ls.eslint'
local cspell = require 'user.null-ls.cspell'
local null_ls = saferequire 'null-ls'
local prettier_d = require 'user.null-ls.prettier'
if not null_ls then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- custom null-ls sources
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
