local server = require 'plugins.lsp.server'

return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
        dependencies = {
            { 'folke/neodev.nvim', config = true },
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- useful lsp tools
            'j-hui/fidget.nvim',
        },
        config = function()
            require 'plugins.lsp.config'
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
            ensure_installed = server.ensure_installed_server,
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
