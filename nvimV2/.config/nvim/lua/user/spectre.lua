return {
    'windwp/nvim-spectre',
    commit = '1d8b7a40677fd87da7648d246c4675c3612a7582',
    config = function()
        require('spectre').setup {
            find_engine = {
                -- rg is map with finder_cmd
                ['rg'] = {
                    cmd = 'rg',
                    -- default args
                    args = {
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                    },
                    options = {
                        ['ignore-case'] = {
                            value = '--ignore-case',
                            icon = '[I]',
                            desc = 'ignore case',
                        },
                        ['hidden'] = {
                            value = '--hidden',
                            desc = 'hidden file',
                            icon = '[H]',
                        },
                        ['vsc'] = {
                            value = '--no-ignore-vcs',
                            desc = 'allow .ignore',
                            icon = '[G]',
                        },
                    },
                },
            },
        }
    end,
}
