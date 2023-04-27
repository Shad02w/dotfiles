local lspconfig = require 'lspconfig'
local attach = require 'plugins.lsp.attach'
local diagnostic = require 'plugins.lsp.diagnostic'
local handlers = require 'plugins.lsp.handlers'
local servers = require 'plugins.lsp.servers'

local disable_default_formatting_servers = {
    'html',
    'lua_ls',
    'tsserver',
    'cssls',
    'jsonls',
}

diagnostic.setup()
handlers.override()

-- get lsp capabilities
local on_attach = function(client, bufnr)
    attach.set_lsp_keymap(bufnr)
    attach.enable_format_on_save(client, bufnr)
    attach.disable_default_formatting(disable_default_formatting_servers, client)
    attach.illuminate(client)
end

-- setup all lsp server at once
for _, server in ipairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }

    -- merge extra options
    local has_extra_opts, extra_opts = pcall(require, 'plugins.lsp.settings.' .. server)
    if has_extra_opts then
        opts = vim.tbl_deep_extend('force', opts, extra_opts)
    end

    lspconfig[server].setup(opts)
end

-- setup typescript servers
local status_ok, typescript = pcall(require, 'typescript')
if status_ok then
    local opts = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }

    -- merge extra options
    local has_extra_opts, extra_opts = pcall(require, 'plugins.lsp.settings.tsserver')
    if has_extra_opts then
        opts = vim.tbl_deep_extend('force', opts, extra_opts)
    end
    typescript.setup {
        server = opts,
    }
end

-- setup rust-analyzer using rust-tools
local rt = require 'rust-tools'
rt.setup {
    server = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    },
}
