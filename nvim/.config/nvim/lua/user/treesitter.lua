local saferequire = require 'user.util.saferequire'
local config = saferequire 'nvim-treesitter.configs'
if not config then
    return
end

local MAX_COLUMN = 10000

local function exceeded_max_column(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if #line > MAX_COLUMN then
            return true
        end
    end
    return false
end

config.setup {
    ensure_installed = 'all',
    auto_install = true,
    ignore_install = { 'php', 'phpdoc' },
    highlight = {
        enable = true,
        disable = function(_, bufnr)
            local no_highlight = false
            if exceeded_max_column(bufnr) then
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
    playground = {
        enable = true,
    },
}
