local saferequire = require 'user.util.saferequire'
local ls = saferequire 'luasnip'
if not ls then
    return {}
end

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

local snippests = {
    -- console
    s('clg', fmta('console.log(<>)', { i(1) })),
    s('ci', fmta('console.info(<>)', { i(1) })),
    s('ce', fmta('console.error(<>)', { i(1) })),

    -- common
    s('imp', fmta([[import {<>} from '<>']], { i(2), i(1) })),
    s('afn', fmta([[(<>) =>> {<>}]], { i(1), i(2) })),
    s('try', fmta([[try {<>} catch() {<>}]], { i(1), i(2) })),

    -- for loop
    s('forin', fmta([[for (const <> in <>) {<>}} ]], { i(2), i(1), i(3) })),
    s('forof', fmta([[for (const <> of <>) {<>} ]], { i(2), i(1), i(3) })),
    s(
        'fori',
        fmta(
            [[
for (let <> = 0; <> << <>; <>++) {
    <>
}<>
]],
            { i(2, 'i'), rep(2), c(1, { sn(1, { i(1), t '.length' }), i(1, 'variable') }), rep(2), i(3), i(4) }
        )
    ),

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
                        fmta(
                            [[
for (let <> = 0; <> << <>; <>++) {
    <>
}<>
]],
                            {
                                i(1, 'i'),
                                rep(1),
                                f(function()
                                    return snip.captures[1] .. '.length'
                                end),
                                rep(1),
                                i(2),
                                i(3),
                            }
                        ),
                    })
                )
            end),
        })
    ),

    -- testing
    s(
        'testt',
        fmta(
            [[
test.each`
  a<>    | b    | expected
  ${1} | ${1} | ${2}
`('returns $expected when $a is added $b', ({a, b, expected}) =>> {
  expect(a + b).toBe(expected);
});
]],
            { i(1) }
        )
    ),

    -- jsdoc
    s(
        'doc',
        fmta(
            [[
/**
 * <>
 */
]],
            { i(1) }
        )
    ),
}

return snippests
