return {
    'akinsho/toggleterm.nvim',
    version = '*',
    lazy = true,
    keys = {
        '<c-t>',
        { '<leader>t', desc = 'Terminal' },
        { '<leader>tt', '<cmd>ToggleTerm direction=horizontal size=20<cr>', desc = 'Open Bottom Term' },
        { '<leader>tl', '<cmd>ToggleTerm direction=vertical size=65<cr>', desc = 'Open Left Term' },
        { '<leader>tf', '<cmd>ToggleTerm direction=float size=20<cr>', desc = 'Open Float Term' },
        { '<leader>tn', '<cmd>ToggleTerm direction=tab<cr>', desc = 'Open Tab Term' },
    },
    -- lazy = false,
    config = function()
        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', [[<C-\><C-n>]], opts)
        end
        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

        require('toggleterm').setup {
            size = 20,
            open_mapping = [[<c-t>]],
            hide_number = true,
            direction = 'float',
            close_on_exit = true,
            insert_mappings = true,
            terminal_mappings = true,
            float_opts = {
                border = 'curved',
            },
        }
    end,
}
