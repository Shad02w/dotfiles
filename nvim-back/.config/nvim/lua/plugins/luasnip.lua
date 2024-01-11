return {
    'L3MON4D3/LuaSnip', -- snippet engine
    event = { 'InsertEnter' },
    dependencies = {
        { 'rafamadriz/friendly-snippets', enabled = false },
    },
    config = function()
        local ls = require 'luasnip'
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

        -- file extension extend
        ls.filetype_extend('typescript', { 'javascript' })
        ls.filetype_extend('typescriptreact', { 'typescript', 'javascript' })
        ls.filetype_extend('javascriptreact', { 'javascript' })
        ls.filetype_extend('astro', { 'typescriptreact', 'typescript', 'javascript' })
        ls.filetype_extend('svelte', { 'typescript', 'javascript' })
        ls.filetype_extend('jsonc', { 'json' })

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
    end,
}
