local keys = require 'plugins.telescope.keys'
return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.8', -- disable tag util lsp_dynamic_workspace_symbol issue fixed https://github.com/nvim-telescope/telescope.nvim/issues/3438
    cmd = 'Telescope',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'AckslD/nvim-neoclip.lua', config = true },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'echasnovski/mini.icons',
        'folke/trouble.nvim',
    },
    keys = {
        { '<leader>b', keys.buffers, desc = 'Show all buffer' },
        { '<leader>C', keys.clipboard, desc = 'Clipboard' },
        { '<leader>f', keys.find_files, desc = 'Find files' },
        { '<leader>F', keys.find_all_files, desc = 'Find all Files' },
        { '<leader>o', keys.recent_files, desc = 'Recent files' },
        { '<leader>s', keys.live_grep_raw, desc = 'Search with args' },
        { '<leader>Sy', keys.live_grep_with_default, desc = 'Search current 0 register' },
        { '<leader>Ss', keys.live_grep, desc = 'Search All' },
        { '<leader>\\', keys.lsp_workspace_symbols, desc = 'Search symbols using LSP across workspace' },
        { '<leader>lc', desc = 'Code Action' },
        { '<leader>S', desc = 'Search' },
    },
    config = function()
        local telescope = require 'telescope'
        local actions = require 'telescope.actions'
        local open_with_trouble = require('trouble.sources.telescope').open

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-n>'] = actions.cycle_history_next,
                        ['<C-p>'] = actions.cycle_history_prev,
                        ['<C-h>'] = actions.which_key,
                        ['<C-c>'] = actions.close,
                        ['<C-q>'] = open_with_trouble,
                    },
                    n = {
                        ['<C-n>'] = actions.cycle_history_next,
                        ['<C-p>'] = actions.cycle_history_prev,
                        ['<C-h>'] = actions.which_key,
                        ['<C-c>'] = actions.close,
                        ['<C-q>'] = open_with_trouble,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ['ui-select'] = {
                    require('telescope.themes').get_ivy {},
                },
            },
        }

        telescope.load_extension 'live_grep_args'
        telescope.load_extension 'fzf'
        telescope.load_extension 'neoclip'
        telescope.load_extension 'ui-select'
    end,
}
