local saferequire = require 'user.util.saferequire'
local ls = saferequire 'luasnip'
if not ls then
    return
end
local types = require 'luasnip.util.types'

ls.config.set_config {
    history = true,
    update_events = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged,InsertLeave',
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { '👈 have choices 🤗' } },
            },
        },
    },
}

-- file extension
require('luasnip').filetype_extend('typescript', { 'javascript' })
require('luasnip').filetype_extend('typescriptreact', { 'typescript', 'javascript' })
require('luasnip').filetype_extend('javascriptreact', { 'javascript' })
require('luasnip').filetype_extend('astro', { 'typescriptreact', 'typescript', 'javascript' })

-- load snippets
require('luasnip.loaders.from_lua').load { paths = vim.fn.stdpath 'config' .. '/lua/snippets' }

local opts = { noremap = true, silent = true }
-- keymap
vim.keymap.set({ 'i', 's' }, '<c-l>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    else
        ls.jump(1)
    end
end, opts)

vim.keymap.set({ 'i', 's' }, '<c-h>', function()
    if ls.jumpable() then
        ls.jump(-1)
    end
end, opts)

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, opts)

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end, opts)
