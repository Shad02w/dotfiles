local MAX_COLUMN = 10000
local MAX_LINE = 5000

local function exceeded_max_column(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if #line > MAX_COLUMN then
            return true
        end
    end
    return false
end

local function exceeded_max_line(bufnr)
    local count = vim.api.nvim_buf_line_count(bufnr)
    if count > MAX_LINE then
        return true
    end
    return false
end

return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
        'JoosepAlviste/nvim-ts-context-commentstring',
        -- 'nvim-treesitter/playground'
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'c',
                'cpp',
                'lua',
                'typescript',
                'javascript',
                'svelte',
                'go',
                'rust',
                'json',
                'yaml',
                'toml',
                'vim',
                'css',
                'dockerfile',
                'git_rebase',
                'graphql',
                'bash',
                'astro',
            },
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(_, bufnr)
                    local no_highlight = false
                    if exceeded_max_column(bufnr) then
                        vim.notify 'treesitter highlight disable: max column'
                        no_highlight = true
                    end

                    if exceeded_max_line(bufnr) then
                        vim.notify 'treesitter highlight disable: max line'
                        no_highlight = true
                    end

                    if no_highlight then
                        vim.api.nvim_buf_set_option(bufnr, 'syntax', 'off')
                    end

                    return no_highlight
                end,
            },
            indent = {
                enable = true,
                disable = { 'yaml' },
            },
            context_commentstring = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['aa'] = '@call.outer',
                        ['ia'] = '@call.outer',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    -- set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']q'] = '@parameter.inner',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['}q'] = '@parameter.inner',
                        ['}f'] = '@function.outer',
                    },
                    swap_previous = {
                        ['{q'] = '@parameter.inner',
                        ['{f'] = '@function.outer',
                    },
                },
            },
            -- playground = {
            --     enable = true,
            -- },
        }
    end,
}
