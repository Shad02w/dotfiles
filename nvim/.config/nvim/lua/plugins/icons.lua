return {
    -- 'nvim-tree/nvim-web-devicons',
    -- opts = {
    --     override = {
    --         -- override toml since Jetbrain Mono do not support toml icon since https://github.com/nvim-tree/nvim-web-devicons/pull/350
    --         ['toml'] = {
    --             icon = '',
    --             color = '#6d8086',
    --             cterm_color = '66',
    --             name = 'Toml',
    --         },
    --     },
    -- },
    {
        'echasnovski/mini.icons',
        specs = {
            { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
        },
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
        opts = {},
    },
}
