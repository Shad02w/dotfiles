local config = require 'plugins.lsp.config'

return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
        dependencies = {
            { 'folke/neodev.nvim', config = true },
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
        cmd = 'Mason',
        build = ':MasonUpdate',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            ensure_installed = config.ensure_installed,
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
    { 'pmizio/typescript-tools.nvim' },
}
