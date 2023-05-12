local keys = require 'plugins.telescope.keys'

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'AckslD/nvim-neoclip.lua', config = true },
    },
    cmd = { 'Telescope' },
    keys = {
        { '<leader>b', keys.buffers, desc = 'Show all buffer' },
        { '<leader>C', keys.clipboard, desc = 'Clipboard' },
        { '<leader>f', keys.find_files, desc = 'Find files' },
        { '<leader>F', keys.find_all_files, desc = 'Find all Files' },
        { '<leader>o', keys.recent_files, desc = 'Recent files' },
        -- { '<leader>s', keys.live_grep_raw, desc = 'Search with args' },
        { '<leader>S', desc = 'Search' },
        { '<leader>Ss', keys.live_grep, desc = 'Search All' },
        { '<leader>Sy', keys.live_grep_with_default, desc = 'Search current 0 register' },
        { '<leader>lc', desc = 'Code Action' },
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
        }

        telescope.load_extension 'ui-select'
        -- telescope.load_extension 'fzf'
        -- telescope.load_extension 'live_grep_args'
        telescope.load_extension 'neoclip'
        -- telescope.load_extension 'notify'
        -- telescope.load_extension 'yasks'
    end,
}
