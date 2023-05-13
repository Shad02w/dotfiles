return {
    'phaazon/hop.nvim',
    keys = {
        { 'm', ':HopChar2<cr>', desc = 'Hop Char 2' },
        { '<leader>j', ':HopWord<cr>', desc = 'Jump to word' },
        { '<leader>J', ':HopLine<cr>', desc = 'Jump to line' },
    },
    config = true,
}
