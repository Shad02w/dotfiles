local saferequire = require 'user.util.saferequire'
local bufferline = saferequire 'bufferline'
if not bufferline then
    return
end

bufferline.setup {
    options = {
        numbers = function(opts)
            return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
        close_command = 'BufDel %d',
        right_mouse_command = 'BufDel %d',
        offsets = {
            {
                filetype = 'neo-tree',
                text = '',
                text_align = 'left',
                highlight = 'Directory',
            },
        },
        diagnostics = 'nvim_lsp',
        custom_filter = function(buf)
            if vim.bo[buf].filetype == 'qf' then
                return false
            end
            return true
        end,
    },
}
