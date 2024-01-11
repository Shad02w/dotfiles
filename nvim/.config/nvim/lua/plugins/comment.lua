return {
    'numToStr/Comment.nvim',
    keys = {
        { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
        { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('Comment').setup {
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    end,
}
