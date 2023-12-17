return {
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        cmd = 'Copilot',
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
    },
}
