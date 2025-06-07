local file = require 'core.utils.file'
-- Restore cursor position
local preserve_cursor_position_group = vim.api.nvim_create_augroup('preserve_cursor_position_group', {})
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    group = preserve_cursor_position_group,
    callback = function()
        vim.cmd [[silent! normal! g`"zv]]
        vim.schedule(function()
            vim.cmd [[silent! normal! zz]]
        end)
    end,
})

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

-- Automatically Split Help window to the left
local set_help_keymap_group = vim.api.nvim_create_augroup('set_help_keymap', {})
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help' },
    group = set_help_keymap_group,
    command = 'wincmd L',
})

-- Disable syntax for large file
local disable_syntax_for_large_file_group = vim.api.nvim_create_augroup('disable_syntax_for_large_file', {})
vim.api.nvim_create_autocmd('BufReadPre', {
    pattern = { '*' },
    group = disable_syntax_for_large_file_group,
    callback = function(args)
        local buf = args.buf
        if file.is_large_file(buf) then
            vim.api.nvim_set_option_value('syntax', 'off', { buf = buf })
        end
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

-- auto reload file if when focus gained, buffer enter, and cursor hold
-- local auto_reload_group = vim.api.nvim_create_augroup('auto_reload_group', {})
-- vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
--     pattern = { '*' },
--     group = auto_reload_group,
--     callback = function()
--         vim.cmd 'checktime'
--     end,
-- })
