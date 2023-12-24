return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    keys = {
        { '<leader>ee', '<cmd>Neotree toggle<cr>', desc = 'Toggle NeoTree and focus' },
        { '<leader>ef', '<cmd>Neotree show filesystem right toggle<cr>', desc = 'Show NeoTree' },
        { '<leader>eb', '<cmd>Neotree show buffers right toggle<cr>', desc = 'Show NeoTree' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    cmd = 'Neotree',
    opts = {
        default_component_configs = {
            indent = {
                with_markers = false,
            },
        },
        filesystem = {
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false, -- only works on Windows for hidden files/directories
                never_show = { -- remains hidden even if visible is toggled to true
                    '.DS_Store',
                },
            },
            follow_current_file = {
                enabled = true,
            },
            use_libuv_file_watcher = true, -- use libnv watcher, do not need to press 'R' to manually refresh
        },
        window = {
            position = 'left',
            width = 60,
            mappings = {
                ['z'] = '',
                ['<c-z>'] = 'close_all_nodes',
                ['c'] = function(state)
                    local node = state.tree:get_node()
                    vim.fn.setreg('*', node.path)
                    vim.notify('Copied path' .. node.path, vim.log.levels.INFO, { title = 'Neo-tree copy path' })
                end,
                ['m'] = {
                    'move',
                    config = {
                        show_path = 'relative',
                    },
                },
            },
        },
        source_selector = {
            winbar = true,
        },
    },
}
