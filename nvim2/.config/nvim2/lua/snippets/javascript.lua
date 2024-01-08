---@diagnostic disable: unused-local
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
local file = require 'core.utils.file'

local forof_snippet = [[
for (const <> of <>) {
    <>
}<>
]]

local fori_snippet = [[
for (let <> = 0; <> << <>; <>++) {
    <>
}<>
]]

local jest_test_table_snippet = [[
test.each`
  a<>    | b    | expected
  ${1} | ${1} | ${2}
`('returns $expected when $a is added $b', ({a, b, expected}) =>> {
  expect(a + b).toBe(expected);
});
]]

local doc = [[
/**
 * <>
 */
]]

local component_snippet = [[
export function {}() {{
    return {}
}}
]]

local async_component_snippet = [[
export async function {}() {{
    return {}
}}
]]

local default_component_snippet = [[
export default function {}() {{
    return {}
}}
]]

local default_async_component_snippet = [[
export default async function {}() {{
    return {}
}}
]]

local get_component_name = function()
    local cwd = vim.fn.getcwd()
    local is_next_project = file.exist { cwd .. '/next.config.js', cwd .. '/next.config.ts' }

    ---@type string
    local filename = vim.fn.expand '%:t'

    if
        (is_next_project and file.match(filename, { 'page.tsx', 'page.js', 'page.jsx' }))
        or string.match(filename, 'index.ts')
    then
        return vim.fn.expand '%:h:t'
    end

    return vim.fn.expand '%:t:r'
end

local snippests = {
    -- general
    s('clg', fmta('console.log(<>)', { i(1) })),
    s('ci', fmta('console.info(<>)', { i(1) })),
    s('ce', fmta('console.error(<>)', { i(1) })),
    s('imp', fmta([[import {<>} from '<>']], { i(2), i(1) })),
    s('afn', fmta([[(<>) =>> {<>}]], { i(1), i(2) })),
    s('try', fmta([[try {<>} catch() {<>}]], { i(1), i(2) })),

    -- for loop
    s('forin', fmta([[for (const <> in <>) {<>}} ]], { i(2), i(1), i(3) })),
    s('forof', fmta(forof_snippet, { i(2), i(1), i(3), i(4) })),
    s(
        'fori',
        fmta(
            fori_snippet,
            { i(2, 'i'), rep(2), c(1, { sn(1, { i(1), t '.length' }), i(1, 'variable') }), rep(2), i(3), i(4) }
        )
    ),

    -- testing
    s('testt', fmta(jest_test_table_snippet, { i(1) })),
    -- jsdoc
    s('doc', fmta(doc, { i(1) })),

    -- for dynamic_node
    s(
        { trig = '([%w_.]+).for', regTrig = true, hidden = true },
        fmta([[<>]], {
            d(1, function(_, snip)
                return sn(
                    nil,
                    c(1, {
                        fmta([[for (const <> of <>) {<>} ]], { i(1), t(snip.captures[1]), i(2) }),
                        fmta([[for (const <> in <>) {<>} ]], { i(1), t(snip.captures[1]), i(2) }),
                        fmta(fori_snippet, {
                            i(1, 'i'),
                            rep(1),
                            f(function()
                                return snip.captures[1] .. '.length'
                            end),
                            rep(1),
                            i(2),
                            i(3),
                        }),
                    })
                )
            end),
        })
    ),

    -- Component Snippet
    s({ trig = 'rfc', desc = 'function component' }, fmt(component_snippet, { f(get_component_name), i(1) })),
    s(
        { trig = 'rfca', desc = 'async function component' },
        fmt(async_component_snippet, { f(get_component_name), i(1) })
    ),
    s(
        { trig = 'rfcd', desc = 'default export function component' },
        fmt(default_component_snippet, { f(get_component_name), i(1) })
    ),
    s(
        { trig = 'rfcda', desc = 'default export async function component' },
        fmt(default_async_component_snippet, { f(get_component_name), i(1) })
    ),
}

return snippests
