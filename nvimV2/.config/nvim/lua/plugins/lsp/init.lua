local servers = require 'plugins.lsp.servers'

return {
    'neovim/nvim-lspconfig',
    event = { 'BufRead' },
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        { 'williamboman/mason-lspconfig.nvim', opts = { ensure_installed = servers } },
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
        'jose-elias-alvarez/typescript.nvim', -- extend usage of typescript
        'simrat39/rust-tools.nvim',
        'folke/which-key.nvim',
        { 'zbirenbaum/neodim', branch = 'v2', opts = { alpha = 0.50 } },
        require 'plugins.lsp.dependencies.fidget',
    },
    config = function()
        require 'plugins.lsp.config'
    end,
}
