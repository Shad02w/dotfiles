return {
    'sindrets/diffview.nvim',
    cmd = {
        'DiffviewOpen',
        'DiffviewFileHistory',
    },
    keys = {
        { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open diff view' },
        { '<leader>go', '<cmd>DiffviewFileHistory<cr>', 'Open File History' },
        { '<leader>gO', '<cmd>DiffviewFileHistory %<cr>', 'Open Current File History' },
    },
    config = function()
        local actions = require 'diffview.actions'
        local function close_all()
            vim.cmd 'DiffviewClose'
        end

        require('diffview').setup {
            enhanced_diff_hl = true,
            keymaps = {
                view = {
                    { 'n', 'gf', actions.goto_file_tab, { desc = 'Go to file' } },
                    { 'n', '<c-c>', close_all, { desc = 'Close Diffview' } },
                },
                file_panel = {
                    { 'n', 'gf', actions.goto_file_tab, { desc = 'Go to file' } },
                    { 'n', '<c-c>', close_all, { desc = 'Close Diffview' } },
                },
            },
        }
    end,
}
