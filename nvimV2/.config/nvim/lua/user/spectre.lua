local function open()
    require('spectre').open()
end

local function search_current_word()
    require('spectre').open_visual { select_word = true }
end

local function search_current_file()
    require('spectre').open_file_search()
end

return {
    'windwp/nvim-spectre',
    commit = '1d8b7a40677fd87da7648d246c4675c3612a7582',
    keys = {
        { '<leader>h', open, desc = 'Search and replace' },
        { '<leader>H', desc = 'Search and replace (current)' },
        { '<leader>Hw', search_current_word, desc = 'Search current word and replace' },
        { '<leader>Hf', search_current_file, desc = 'Search current file and replace' },
    },
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
