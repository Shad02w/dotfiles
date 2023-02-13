local saferequire = require 'user.util.saferequire'
local notify = saferequire 'notify'
if not notify then
    return
end

vim.notify = notify

notify.setup {
    stages = 'fade',
    timeout = 5000,
    -- max_width = 60,
    on_open = function(win)
        vim.api.nvim_win_set_option(win, 'wrap', true)
    end,
}
