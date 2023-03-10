local servers = require 'user.lsp.servers'

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
        { 'narutoxy/dim.lua', config = true }, -- dimmed unused variable
        require 'user.lsp.dependencies.fidget',
    },
    config = function()
        require 'user.lsp.config'
    end,
}
