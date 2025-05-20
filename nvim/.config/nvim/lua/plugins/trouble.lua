return {
    'folke/trouble.nvim',
    opts = {
        auto_preview = false,
        focus = true,
        auto_refresh = false,
    },
    keys = {
        { '<leader>qq', require('trouble').close, desc = 'Toggle quickfix' },
        {
            '<leader>qr',
            function()
                require('trouble').toggle 'lsp_references'
            end,
            desc = 'Toggle LSP References list',
        },
        {
            '<leader>qd',
            function()
                require('trouble').toggle 'lsp_definitions'
            end,
            desc = 'Toggle LSP Definitions list',
        },
        {
            '<leader>qd',
            function()
                require('trouble').toggle 'lsp_definitions'
            end,
            desc = 'Toggle LSP Definitions list',
        },
        {
            '<leader>qo',
            function()
                require('trouble').toggle 'diagnostics'
            end,
            desc = 'Toggle diagnostics',
        },
        {
            '<leader>qs',
            function()
                require('trouble').toggle 'lsp_document_symbols'
            end,
            desc = 'Toggle LSP Document Symbols',
        },
    },
    cmd = 'Trouble',
}
