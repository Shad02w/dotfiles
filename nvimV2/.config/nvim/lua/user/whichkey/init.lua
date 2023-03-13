local function cmd(command)
    return function()
        vim.cmd(command)
    end
end
return {
    'folke/which-key.nvim',
    keys = '<leader>',
    opts = {
        window = {
            border = 'rounded',
            margin = { 1, 0, 1, 0 },
        },
    },
    config = function()
        local whichkey = require 'which-key'

        local toggleterm = require 'user.whichkey.toggleterm'
        local quickfix = require 'user.whichkey.quickfix'
        local general = require 'user.whichkey.general'

        whichkey.setup {
            window = {
                border = 'rounded',
                margin = { 1, 0, 1, 0 },
            },
        }

        local mappings = {
            c = {
                name = 'Close buffer',
                o = { general.close_other, 'Close all buffers except current and pinned' },
            },
            q = {
                name = 'close',
                q = { quickfix.toggle_quick_fix, 'Toggle quickfix' },
                h = { cmd 'colder', 'Previous quick fix history' },
                l = { cmd 'cnewer', 'Previous quick fix history' },
            },
            x = { cmd 'TroubleToggle', 'Trouble' },
            w = {
                name = 'Window',
                v = { cmd 'vsplit', 'Vertical' },
                h = { cmd 'split', 'Horizontal' },
                m = {
                    name = 'Move Current Window',
                    l = { cmd 'wincmd L', 'Move to Horizontal Left' },
                    r = { cmd 'wincmd R', 'Move to Horizontal Right' },
                },
            },
        }

        local mapping_opts = {
            silent = true,
            prefix = '<leader>',
            noremap = true,
            nowait = true,
        }

        whichkey.register(mappings, vim.tbl_extend('force', { mode = 'n' }, mapping_opts))
        whichkey.register(mappings, vim.tbl_extend('force', { mode = 'v' }, mapping_opts))

        -- Prevent error when Telescope open
        local show = whichkey.show
        whichkey.show = function(keys, opts)
            if vim.bo.filetype == 'TelescopePrompt' then
                local map = '<c-r>'
                local key = vim.api.nvim_replace_termcodes(map, true, false, true)
                vim.api.nvim_feedkeys(key, 'i', true)
            end
            show(keys, opts)
        end
    end,
}
