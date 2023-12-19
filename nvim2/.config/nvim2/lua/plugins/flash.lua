return {
    'folke/flash.nvim',
    keys = {
        {
            'm',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        {
            'M',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },
        '/',
    },
    ---@type Flash.Config
    opts = {
        search = {
            multi_window = false,
        },
        modes = {
            char = {
                enabled = false,
            },
        },
    },
}
