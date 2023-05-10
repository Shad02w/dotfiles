return {
    'vuki656/package-info.nvim',
    keys = {
        { '<leader>ns', '<cmd>lua require("package-info").show({force = true})<cr>', desc = 'Show package info' },
    },
    config = function()
        require('package-info').setup {
            colors = {
                outdated = '#d19a66',
            },
            autostart = false,
            icons = {
                enable = true,
                style = {
                    outdated = '    newer version: ',
                },
            },
            hide_up_to_date = true,
            package_manager = 'pnpm',
        }
    end,
}
