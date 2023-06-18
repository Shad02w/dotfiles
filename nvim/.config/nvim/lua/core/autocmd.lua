-- Restore cursor position
local preserve_cursor_position_group = vim.api.nvim_create_augroup('preserve_cursor_position_group', {})
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    group = preserve_cursor_position_group,
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
        vim.fn.timer_start(1, function()
            vim.api.nvim_exec('silent! normal! zz', false)
        end)
    end,
})

-- Automatically Split Help window to the left
vim.cmd [[
    augroup help_window_to_left
        autocmd!
        autocmd FileType help wincmd L
    augroup END
]]

-- Automatically reload kitty when kitty.conf changed
local kitty_conf_auto_load_group = vim.api.nvim_create_augroup('kitty_conf_auto_load_group', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { 'kitty.conf' },
    group = kitty_conf_auto_load_group,
    callback = function()
        -- '-a' is need for mac
        vim.cmd [[silent !kill -SIGUSR1 $(pgrep -a kitty)]]
    end,
})

-- auto reload file if checked
local auto_reload_group = vim.api.nvim_create_augroup('auto_reload_group', {})
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHoldI', 'CursorHold' }, {
    pattern = { '*' },
    group = auto_reload_group,
    callback = function()
        vim.cmd 'checktime'
    end,
})
