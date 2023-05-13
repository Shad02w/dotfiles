return {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = '<C-S-;>',
                },
            },
            panel = {
                auto_refresh = true,
            },
        }
    end,
}
