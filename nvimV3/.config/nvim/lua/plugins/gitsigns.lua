return {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    keys = {
        { '<leader>gh', desc = 'Git Hunk' },
        { '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk' },
        { '<leader>ghS', '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo stage hunk' },
    },
    opts = {
        current_line_blame = true,
    },
}
