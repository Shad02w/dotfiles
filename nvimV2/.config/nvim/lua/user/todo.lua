return {
    'folke/todo-comments.nvim',
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
