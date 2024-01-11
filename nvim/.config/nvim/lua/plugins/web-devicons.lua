return {
    'nvim-tree/nvim-web-devicons',
    opts = {
        override = {
            -- override toml since Jetbrain Mono do not support toml icon since https://github.com/nvim-tree/nvim-web-devicons/pull/350
            ['toml'] = {
                icon = '',
                color = '#6d8086',
                cterm_color = '66',
                name = 'Toml',
            },
        },
    },
}
