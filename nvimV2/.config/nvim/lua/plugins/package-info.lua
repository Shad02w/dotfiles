return {
    'vuki656/package-info.nvim',
    event = { 'BufRead package.json' },
    config = function()
        require('package-info').setup {
            colors = {
                outdated = '#d19a66',
            },
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
