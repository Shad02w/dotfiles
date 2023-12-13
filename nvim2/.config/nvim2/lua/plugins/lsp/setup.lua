local lspconfig = require 'lspconfig'
local config = require 'plugins.lsp.config'
local utils = require 'plugins.lsp.utils'

for _, server_name in ipairs(config.enabled_server) do
    local settings = utils.get_settings(server_name) or {}
    local opts = vim.tbl_deep_extend('force', {
        on_attach = utils.on_attach,
        capabilities = utils.capabilities,
    }, settings)

    lspconfig[server_name].setup(opts)
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
    width = 60,
})

-- vim.diagnostic.config {
--     virtual_text = true,
--     -- show signs
--     signs = {
--         active = {
--             { name = 'DiagnosticSignError', text = '' },
--             { name = 'DiagnosticSignWarn', text = '' },
--             { name = 'DiagnosticSignHint', text = '' },
--             { name = 'DiagnosticSignInfo', text = '' },
--         },
--     },
--     severity_sort = true,
--     float = {
--         focusable = false,
--         border = 'rounded',
--         source = 'always',
--     },
-- }
