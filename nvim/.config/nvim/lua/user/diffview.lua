local saferequire = require 'user.util.saferequire'
local diffview = saferequire 'diffview'
if not diffview then
    return
end

local actions = require 'diffview.actions'

local function close_all()
    vim.api.nvim_exec([[DiffviewClose]], false)
end

diffview.setup {
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
