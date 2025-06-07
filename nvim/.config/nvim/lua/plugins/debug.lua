return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                '<leader>/b',
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = 'Toggle Breakpoint',
            },
        },
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
}
