local config = require 'plugins.lsp.config'

return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
        dependencies = {
            'SmiteshP/nvim-navic',
            'folke/lazydev.nvim',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- useful lsp tools
            'j-hui/fidget.nvim',
        },
        config = function()
            require 'plugins.lsp.setup'
        end,
    },
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            ensure_installed = config.ensure_installed,
            automatic_enable = false,
            automatic_installation = true,
        },
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
            text = {
                spinner = 'moon',
            },
            align = {
                bottom = true,
            },
            window = {
                relative = 'editor',
            },
        },
    },
}
