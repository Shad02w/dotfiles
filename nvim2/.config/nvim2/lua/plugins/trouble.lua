return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
