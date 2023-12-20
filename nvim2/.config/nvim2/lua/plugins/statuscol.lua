return {
    'luukvbaal/statuscol.nvim',
    event = { 'BufEnter' },
    init = function()
        vim.opt.signcolumn = 'auto:1-3'
    end,
    config = function()
        local builtin = require 'statuscol.builtin'
        require('statuscol').setup {
            relculright = true,
            segments = {
                { text = { '%s' } },
                {
                    text = { builtin.lnumfunc, ' ' },
                    condition = { true, builtin.not_empty },
                    click = 'v:lua.ScLa',
                },
                { text = { '%C' }, click = 'v:lua.ScFa' },
                { text = { '  ' } },
            },
        }
    end,
}
