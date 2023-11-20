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

-- Warn when open big file
local file_size_threshold = 50 * 1024 * 1024
local open_big_file_warning = vim.api.nvim_create_augroup('open_big_file_warning', {})
vim.api.nvim_create_autocmd('BufReadPre', {
    pattern = { '*' },
    group = open_big_file_warning,
    callback = function(arg)
        local filepath = vim.api.nvim_buf_get_name(arg.buf)
        local buf_size = vim.fn.getfsize(filepath)

        if buf_size > file_size_threshold or buf_size == -2 then
            local choice = vim.fn.confirm(
                'file size of '
                    .. arg.file
                    .. ' is larger than '
                    .. file_size_threshold
                    .. ' bytes('
                    .. buf_size
                    .. '), Open this file may crash the editor, continue?',
                '&Yes\n&No',
                2
            )
            if choice == 2 then
                vim.cmd('bdelete ' .. arg.buf)
            end
        end
    end,
})
