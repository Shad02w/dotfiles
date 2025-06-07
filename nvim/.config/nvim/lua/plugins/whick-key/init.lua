---@param command string
---@return fun(command: string)
local function cmd(command)
    return function()
        vim.cmd(command)
    end
end

return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = {
        'famiu/bufdelete.nvim',
        { 'echasnovski/mini.icons', version = false },
    },
    config = function()
        local wk = require 'which-key'
        local general = require 'plugins.whick-key.general'

        local mappings = {
            {
                mode = { 'n', 'v' },
                { '<leader>c', group = 'Close' },
                { '<leader>co', general.close_other_buffer, desc = 'Close all buffers execpt buffers on current tab' },

                { '<leader>d', cmd 'Bdelete', desc = 'Delete Current Buffer' },

                { '<leader>w', group = 'Window Layout' },
                { '<leader>wh', cmd 'abo vsplit', desc = 'Split left' },
                { '<leader>wj', cmd 'split', desc = 'Split bottom' },
                { '<leader>wk', cmd 'to split', desc = 'Split top' },
                { '<leader>wl', cmd 'vsplit', desc = 'Split right' },
                { '<leader>wv', cmd 'vsplit', desc = 'Split right' },

                { '<leader>g', group = 'Git' },
                { '<leader>gh', group = 'Git Hunk' },
                { '<leader>l', group = 'LSP' },
            },
        }

        wk.setup {
            win = {
                border = 'rounded',
                padding = { 1, 0, 1, 0 },
            },
        }

        wk.add(mappings)
    end,
}
