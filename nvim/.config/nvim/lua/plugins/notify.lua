return {
    'rcarriga/nvim-notify',
    lazy = false,
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
}
