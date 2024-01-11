return {
    'lewis6991/gitsigns.nvim',
    event = { 'CursorMoved' },
    cmd = 'Gitsigns',
    keys = {
        { '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk' },
        { '<leader>ghS', '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo stage hunk' },
        { '[c', '<cmd>silent Gitsigns prev_hunk<cr>', desc = 'Prev Git hunk' },
        { ']c', '<cmd>silent Gitsigns next_hunk<cr>', desc = 'Next Git hunk' },
    },
    config = function()
        require('gitsigns').setup {
            signs = {
                untracked = { text = '│' },
            },
            current_line_blame = true,
        }
        vim.cmd 'hi GitSignsUntracked guifg=#c084fc'
    end,
}
