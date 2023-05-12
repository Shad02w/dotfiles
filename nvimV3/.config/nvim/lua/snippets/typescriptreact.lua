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

local snippets = {}

local pinnalce_react_memo_template = [[
import React from "react";
import {{ReactUtil}} from "@pinnacle0/web-ui/util/ReactUtil"

export const {} = ReactUtil.memo("{}", () => {{
    return <div{}/>
}})
]]

local get_component_name = function()
    local filename = vim.fn.expand '%'
    if not string.match(filename, 'index.ts') then
        return vim.fn.expand '%:p:t:r'
    else
        return vim.fn.expand '%:h:t'
    end
end

table.insert(
    snippets,
    s('pfc', fmt(pinnalce_react_memo_template, { f(get_component_name), f(get_component_name), i(1) }))
)

local react_props_type_template = [[
interface Props {{
    {}
}}
]]
table.insert(snippets, s('propst', fmt(react_props_type_template, { i(1) })))

return snippets
