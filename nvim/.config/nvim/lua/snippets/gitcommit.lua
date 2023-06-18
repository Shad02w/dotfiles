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
local rep = require('luasnip.extras').rep
local m = require('luasnip.extras').m
local lambda = require('luasnip.extras').l
local postfix = require('luasnip.extras.postfix').postfix

local snippet = {
    s({ trig = 'prefactor', dscr = 'Pinnacle style REFACTOR Message' }, {
        t { '[REFACTOR]: ' },
        i(1, 'scope'),
        t { ': ' },
        i(2, 'message'),
    }),
    s({ trig = 'pfix', dscr = 'Pinnacle style FIX Message' }, {
        t { '[FIX]: ' },
        i(1, 'scope'),
        t { ': ' },
        i(2, 'message'),
    }),
    s({ trig = 'pchore', dscr = 'Pinnacle style CHORE Message' }, {
        t { '[CHORE]: ' },
        i(1, 'scope'),
        t { ': ' },
        i(2, 'message'),
    }),
    s({ trig = 'pupgrade', dscr = 'Pinnacle style UPGRADE Message' }, {
        t { '[UPGRADE]: ' },
        i(1, 'scope'),
        t { ': ' },
        i(2, 'message'),
    }),
}

return snippet
