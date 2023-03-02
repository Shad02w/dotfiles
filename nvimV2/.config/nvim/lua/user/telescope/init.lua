local keys = require 'user.telescope.keys'
return {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'AckslD/nvim-neoclip.lua',
        -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { dir = '~/yasks.nvim' },
    },
    keys = {
        { '<leader>b', keys.buffers, 'Show all buffer' },
        { '<leader>C', keys.clipboard, 'Clipboard' },
        { '<leader>f', keys.find_files, 'Find files' },
        { '<leader>F', keys.find_all_files, 'Find all Files' },
        { '<leader>o', keys.recent_files, 'Recent files' },
    },
    config = function()
        local telescope = require 'telescope'
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
        -- telescope.load_extension 'fzf'
        telescope.load_extension 'live_grep_args'
        telescope.load_extension 'neoclip'
        telescope.load_extension 'notify'
        telescope.load_extension 'yasks'
    end,
}
