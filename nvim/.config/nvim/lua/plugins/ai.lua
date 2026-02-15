return {
    {
        'supermaven-inc/supermaven-nvim',
        event = 'InsertEnter',
        cmd = {
            'SupermavenStart',
            'SupermavenStop',
            'SupermavenRestart',
            'SupermavenToggle',
            'SupermavenStatus',
            'SupermavenUseFree',
            'SupermavenUsePro',
            'SupermavenLogout',
            'SupermavenShowLog',
            'SupermavenClearLog',
        },
        config = function()
            require('supermaven-nvim').setup {
                keymaps = {
                    accept_suggestion = '<C-;>',
                },
            }
        end,
    },
    {
        'NickvanDyke/opencode.nvim',
        event = { 'CursorMoved', 'InsertEnter' },
        keys = {
            {
                '<leader>ao',
                function()
                    require('opencode').toggle()
                end,
                desc = 'Open code',
            },
            {
                '<leader>al',
                function()
                    require('opencode').ask('@this: ,', { submit = true })
                end,
                desc = 'Ask opencode...',
                mode = { 'n', 'v' },
            },
            {
                '<leader>as',
                function()
                    require('opencode').select()
                end,
                desc = 'Execute opencode action...',
            },
        },
        dependencies = {
            -- Recommended for `ask()` and `select()`.
            -- Required for `snacks` provider.
            ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
            { 'folke/snacks.nvim' },
        },
    },
}
