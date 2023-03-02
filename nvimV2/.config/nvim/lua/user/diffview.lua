local function close_all()
    vim.api.nvim_exec([[DiffviewClose]], false)
end

return {
    'sindrets/diffview.nvim',
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
