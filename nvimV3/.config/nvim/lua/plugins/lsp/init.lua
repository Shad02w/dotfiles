local servers = require 'plugins.lsp.servers'
return {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        config = function()
            require('mason').setup {}
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            ensure_installed = servers.ensure_installed_servers,
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
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- useful lsp tools
            'RRethy/vim-illuminate',
            'j-hui/fidget.nvim',
            'lukas-reineke/lsp-format.nvim', --

            -- advanced lsp server
            'simrat39/rust-tools.nvim',
            { 'folke/neodev.nvim', config = true },
            'jose-elias-alvarez/typescript.nvim', -- extend usage of typescript
        },
        config = function()
            require 'plugins.lsp.lspconfig'
        end,
    },
}
