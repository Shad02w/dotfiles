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
    keys = {
        { '<leader>h', open, 'Search and Replace' },
        { '<leader>Hw', search_current_file, 'Search current file and replace' },
        { '<leader>Hf', search_current_word, 'Search current word and replace' },
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
