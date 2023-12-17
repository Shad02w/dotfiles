return {
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
        ---@diagnostic disable-next-line: missing-fields
        notify.setup {
            stages = 'fade',
            timeout = 5000,
            render = 'wrapped-compact',
            max_width = 80,
        }
    end,
}
