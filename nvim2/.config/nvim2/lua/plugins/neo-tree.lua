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
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
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
        filesystem= {
            follow_current_file = {
                enabled = true
            }
        },
        window = {
            position = 'right',
            width = 60
        },
    },
}
