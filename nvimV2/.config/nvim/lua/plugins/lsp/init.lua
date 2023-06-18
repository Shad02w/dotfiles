local ensure_installed = {
    'gopls',
    'vimls',
    'html',
    'lua_ls',
    'tsserver',
    'rust_analyzer',
    'cssls',
    'taplo',
    'jsonls',
    'yamlls',
    'lemminx',
    'astro',
    'tailwindcss',
    'svelte',
    'cssmodules_ls',
}

return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufRead' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'RRethy/vim-illuminate',
            'ray-x/lsp_signature.nvim',
            'hrsh7th/nvim-cmp',
            'folke/neodev.nvim',
            'jose-elias-alvarez/typescript.nvim', -- extend usage of typescript
            'simrat39/rust-tools.nvim',
            'narutoxy/dim.lua',
            'j-hui/fidget.nvim',
        },
        config = function()
            require 'plugins.lsp.setup'
        end,
    },
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        cmd = 'Mason',
        config = true,
    },
    { 'williamboman/mason-lspconfig.nvim', opts = { ensure_installed = ensure_installed } },
    {
        'ray-x/lsp_signature.nvim',
        opts = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            floating_window = false,
            hint_enable = true, -- virtual hint enable
            handler_opts = {
                border = 'rounded',
            },
        },
    },
    { 'narutoxy/dim.lua', config = true },
    { 'folke/neodev.nvim', config = true },
    {
        'j-hui/fidget.nvim',
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
