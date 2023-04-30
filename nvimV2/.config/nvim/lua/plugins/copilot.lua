-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap('i', '<c-s-k>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

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
