return {
    'kosayoda/nvim-lightbulb',
    event = { 'BufRead' },
    config = function()
        require('nvim-lightbulb').setup()

        local cursor_hold_event = vim.api.nvim_create_augroup('cursor_hold_event', {})
        vim.api.nvim_clear_autocmds { group = cursor_hold_event }
        vim.api.nvim_create_autocmd({ 'BufReadPre', 'CursorHold', 'CursorHoldI' }, {
            group = cursor_hold_event,
            callback = function()
                require('nvim-lightbulb').update_lightbulb()
            end,
        })
    end,
}
