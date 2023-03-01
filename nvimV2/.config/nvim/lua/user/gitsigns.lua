return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
        { '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk' },
        { '<leader>ghS', '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo stage hunk' },
    },
    config = function()
        require('gitsigns').setup {
            current_line_blame = true,
        }
    end,
}
