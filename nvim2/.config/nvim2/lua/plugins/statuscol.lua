return {
    'luukvbaal/statuscol.nvim',
    event = { 'BufEnter' },
    init = function()
        vim.opt.signcolumn = 'auto:1'
    end,
    config = function()
        local builtin = require 'statuscol.builtin'
        require('statuscol').setup {
            relculright = true,
            ft_ignore = { 'DiffviewFiles', 'notify' },
            segments = {
                { text = { ' ' } },
                {
                    text = { builtin.lnumfunc, ' ' },
                    condition = { true, builtin.not_empty },
                    click = 'v:lua.ScLa',
                },
                { text = { '%s' } },
                { text = { '%C' }, click = 'v:lua.ScFa' },
                { text = { '  ' } },
            },
        }
    end,
}
