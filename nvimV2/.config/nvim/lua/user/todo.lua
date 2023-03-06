return {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    config = function()
        require('todo-comments').setup {
            highlight = {
                pattern = [[.*<(KEYWORDS)\s*]],
            },
            colors = {
                info = { '#56f00e' },
            },
        }
    end,
}
