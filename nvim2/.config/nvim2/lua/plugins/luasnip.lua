return {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    config = function()
        local ls = require 'luasnip'
        local types = require 'luasnip.util.types'

        ls.setup {
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
        ls.filetype_extend('typescriptreact', { 'typescript', 'javascript', 'javascriptreact' })
        ls.filetype_extend('javascriptreact', { 'javascript' })
        ls.filetype_extend('astro', { 'typescriptreact', 'typescript', 'javascript' })
        ls.filetype_extend('svelte', { 'typescript', 'javascript' })
        ls.filetype_extend('jsonc', { 'json' })

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

        -- load snippets
        require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath 'config' .. '/lua/snippets' }
    end,
}
