local ls = require 'luasnip'

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local m = require('luasnip.extras').m
local lambda = require('luasnip.extras').l
local postfix = require('luasnip.extras.postfix').postfix

local prettier_snippet = [[
{
    "tabWidth": 4,
    "semi": false,
    "singleQuote": false,
    "trailingComma": "none",
    "printWidth": 120,
    "arrowParens": "avoid"<>
}
]]

local tsconfig_snippet = [[
{
    "compilerOptions": {
        "checkJs": true,
        "useDefineForClassFields": true,

        /* Import & Export */
        "allowSyntheticDefaultImports": true,
        "esModuleInterop": true,
        "isolatedModules": true,

        /* Linting */
        "strict": true,
        "noImplicitOverride": true,
        "noImplicitAny": true,
        "verbatimModuleSyntax": true,
        "noUnusedLocals": true,
        "noUnusedParameters": true,
        "forceConsistentCasingInFileNames": true,
        "noFallthroughCasesInSwitch": true,
        "strictPropertyInitialization": true<>
    }
}
]]

local snippet = {
    s({
        trig = 'prettier',
        dscr = 'my favorite prettier config',
        show_condition = function()
            return string.find(vim.fn.expand '%', 'prettier') ~= nil
        end,
    }, fmta(prettier_snippet, { i(1) })),
    s({
        trig = 'tsconfig',
        dscr = 'my favorite tsconfig config',
        show_condition = function()
            return string.find(vim.fn.expand '%', 'tsconfig') ~= nil
        end,
    }, fmta(tsconfig_snippet, { i(1) })),
}

return snippet
