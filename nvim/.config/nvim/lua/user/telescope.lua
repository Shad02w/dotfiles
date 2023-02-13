local saferequire = require 'user.util.saferequire'
local telescope = saferequire 'telescope'
if not telescope then
    return
end
local actions = require 'telescope.actions'

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-n>'] = actions.cycle_history_next,
                ['<C-p>'] = actions.cycle_history_prev,
                ['<C-h>'] = actions.which_key,
                ['<C-c>'] = actions.close,
            },
            n = {
                ['<C-n>'] = actions.cycle_history_next,
                ['<C-p>'] = actions.cycle_history_prev,
                ['<C-h>'] = actions.which_key,
                ['<C-c>'] = actions.close,
            },
        },
    },
    pickers = {
        find_files = {
            -- fd v0.8.3 above required
            find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
        },
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_ivy {},
        },
    },
}

telescope.load_extension 'ui-select'
telescope.load_extension 'fzf'
telescope.load_extension 'live_grep_args'
telescope.load_extension 'neoclip'
telescope.load_extension 'notify'
telescope.load_extension 'yasks'
