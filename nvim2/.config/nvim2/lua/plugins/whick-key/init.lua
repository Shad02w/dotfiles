---@param command string
---@return fun(command: string)
local function cmd(command)
    return function()
        vim.cmd(command)
    end
end

return {
    'folke/which-key.nvim',
    keys = '<leader>',
    dependencies = {
        'famiu/bufdelete.nvim',
    },
    config = function()
        local wk = require 'which-key'
        local general = require 'plugins.whick-key.general'

        local mappings = {
            c = {
                name = 'Close buffer',
                o = { general.close_other_buffer, 'Close all buffers execpt buffers on current tab' },
            },
            d = { cmd 'Bdelete', 'Delete Current Buffer' },
            w = {
                name = 'Window Layout',
                h = { cmd 'abo vsplit', 'Split left' },
                j = { cmd 'split', 'Split bottom' },
                k = { cmd 'to split', 'Split top' },
                l = { cmd 'vsplit', 'Split right' },
                v = { cmd 'vsplit', 'Split right' },
            },
        }

        wk.setup {
            window = {
                border = 'rounded',
                margin = { 1, 0, 1, 0 },
            },
        }

        local mapping_opts = { silent = true, prefix = '<leader>', noremap = true, nowait = true }

        wk.register(mappings, vim.tbl_extend('force', { mode = 'n' }, mapping_opts))
        wk.register(mappings, vim.tbl_extend('force', { mode = 'v' }, mapping_opts))
    end,
}
