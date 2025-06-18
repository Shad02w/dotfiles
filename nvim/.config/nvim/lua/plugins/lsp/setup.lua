local lspconfig = require 'lspconfig'
local config = require 'plugins.lsp.config'
local utils = require 'plugins.lsp.utils'

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field override default hover
vim.lsp.buf.hover = function()
    hover {
        border = 'rounded',
    }
end

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
        },
    },
    severity_sort = true,
    virtual_text = true,
    float = {
        focusable = true,
        border = 'rounded',
        source = true,
    },
}

-- use round border in lspconfig ui
require('lspconfig.ui.windows').default_options.border = 'rounded'

utils.create_lsp_attach_autocmd('lsp_attach_group', function(client, bufnr)
    utils.on_attach(client, bufnr)

    local client_config = config.lsp_server_config[client.name]

    if client_config and type(client_config) == 'table' and client_config.on_attach then
        client_config.on_attach(client, bufnr)
    end
end)

for server_name, c in pairs(config.lsp_server_config) do
    if not c then
        goto continue
    end

    if type(c) == 'table' then
        if c.enabled ~= nil and not c.enabled then
            goto continue
        end

        if c.cond and not c.cond() then
            goto continue
        end
    end

    local settings = utils.get_settings(server_name) or {}
    local opts = vim.tbl_deep_extend('force', {
        capabilities = utils.capabilities,
    }, settings)

    lspconfig[server_name].setup(opts)
    ::continue::
end

vim.lsp.enable 'cspell_lsp'
