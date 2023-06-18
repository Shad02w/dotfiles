local winbar = {
    lualine_c = {
        {
            'filename',
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 1, -- 0: Just the filename
            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            symbols = {
                modified = '[+]', -- Text to show when the file is modified.
                readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                newfile = '[New]', -- Text to show for new created file before first writting
            },
        },
    },
}

local function get_file_path()
    local filename = vim.fn.expand '%:p'
    if filename == '' then
        return '😴 no file'
    end
    local cwd = vim.loop.cwd()
    if cwd then
        return string.sub(filename, cwd:len() + 1)
    else
        return filename
    end
end

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        local themes = require 'lualine.themes.gruvbox-material'
        themes.normal.c.bg = '#181616'

        require('lualine').setup {
            sections = {
                lualine_c = {
                    get_file_path,
                },
            },
            options = {
                -- section_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
                -- component_separators = { left = '', right = '' },
                theme = themes,
                disabled_filetypes = {
                    statusline = {
                        'neo-tree',
                    },
                },
            },
            -- section_separators = { left = '', right = '' },
            extensions = { 'quickfix', 'neo-tree', 'toggleterm' },
            inactive_winbar = winbar,
            winbar = winbar,
        }
    end,
}
