return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = 'f1168feada93c0154ede4d1fe9183bf69bac54ea',
    cmd = {
        'Trouble',
        'TroubleToggle',
        'TroubleRefresh',
        'TroubleClose',
    },
    keys = {
        { '<leader>q', '<CMD>TroubleToggle<CR>', desc = 'Toggle Trouble' },
    },
    opts = {
        auto_preview = false,
    },
}
