return {
    'luukvbaal/statuscol.nvim',
    event = { 'BufEnter' },
    config = function()
        local builtin = require 'statuscol.builtin'
        require('statuscol').setup {
            relculright = true,
            ft_ignore = { 'DiffviewFiles', 'notify', 'Trouble', 'neo-tree', 'netrw', 'dbui' },
            segments = {
                { text = { ' ' } },
                {
                    text = { builtin.lnumfunc, ' ' },
                    condition = { true, builtin.not_empty },
                    click = 'v:lua.ScLa',
                },
                { sign = { text = { '.*' }, colwidth = 2 } },
                { text = { '%C' }, click = 'v:lua.ScFa' },
                { text = { '  ' } },
            },
        }
    end,
}
