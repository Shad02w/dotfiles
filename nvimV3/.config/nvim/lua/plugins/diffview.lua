local function close_all()
    vim.api.nvim_exec([[DiffviewClose]], false)
end

return {
    'sindrets/diffview.nvim',
    commit = '6bebefbc4c90e6d2b8c65e65b055d284475d89f8',
    keys = {
        { '<leader>g', desc = 'Git' },
        { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview' },
        { '<leader>go', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview Current File History' },
        { '<leader>gO', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview Files History' },
    },
    config = function()
        local actions = require 'diffview.actions'

        require('diffview').setup {
            enhanced_diff_hl = true,
            keymaps = {
                view = {
                    ['gf'] = actions.goto_file_tab,
                    ['<c-c>'] = close_all,
                },
                file_panel = {
                    ['gf'] = actions.goto_file_tab,
                    ['<c-c>'] = close_all,
                    ['s'] = actions.toggle_stage_entry,
                },
            },
        }
    end,
}
