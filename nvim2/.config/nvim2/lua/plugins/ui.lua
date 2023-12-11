return {
    {
        'rcarriga/nvim-notify',
        cmd = 'Notifications',
        init = function()
            vim.notify = function(...)
                require('lazy').load { plugins = { 'nvim-notify' } }
                vim.notify(...)
            end
        end,
        config = function()
            local notify = require 'notify'
            vim.notify = notify
            notify.setup {
                stages = 'fade',
                timeout = 5000,
                on_open = function(win)
                    vim.api.nvim_win_set_option(win, 'wrap', true)
                end,
            }
        end,
    },
}
