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

local saferequire_snippet = [[
local saferequire = require 'user.util.saferequire'
local {} = saferequire '{}'
if not {} then
    return
end
]]

local snippets = {
    s('sreq', fmt(saferequire_snippet, { i(2), i(1), rep(2) })),
    s('log', fmta('vim.notify(vim.inspect(<>))', { i(1) })),
}

return snippets
