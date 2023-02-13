local saferequire = require 'user.util.saferequire'
local lualine = saferequire 'lualine'
if not lualine then
    return
end

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

lualine.setup {
    sections = {
        lualine_c = {
            -- [[vim.fn.bufname '%']],
        },
    },
    options = {
        section_separators = { left = '', right = '' },
    },
    -- section_separators = { left = '', right = ''},
    extensions = { 'quickfix', 'neo-tree', 'toggleterm' },
    inactive_winbar = winbar,
    winbar = winbar,
}
