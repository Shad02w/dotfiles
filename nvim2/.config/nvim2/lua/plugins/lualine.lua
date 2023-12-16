return {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
        local function get_file_path()
            local filename = vim.fn.expand '%'
            if filename == '' or type(filename) == 'table' then
                return '😴 no file'
            end
            return filename
        end

        -- hide cmdline
        vim.o.cmdheight = 0

        -- modify theme
        local themes = require 'lualine.themes.gruvbox-material'
        themes.normal.c.bg = '#181616'

        require('lualine').setup {
            options = {
                theme = themes,
                disabled_filetypes = {
                    statusline = {
                        'neo-tree',
                        'DiffviewFiles',
                    },
                },
            },
            sections = {
                lualine_c = {
                    get_file_path,
                },
            },
            -- section_separators = { left = '', right = '' },
            extensions = { 'quickfix', 'neo-tree', 'toggleterm' },
            -- inactive_winbar = winbar,
            -- winbar = winbar,
        }
    end,
}
