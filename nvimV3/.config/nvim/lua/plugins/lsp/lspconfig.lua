local attach = require 'plugins.lsp.attach'
local lspconfig = require 'lspconfig'
local servers = require 'plugins.lsp.servers'

local auto_setup_servers_list = vim.tbl_filter(function(server)
    return not vim.tbl_contains(servers.skip_default_setup_servers, server)
end, servers.ensure_installed_servers)

local function on_attach(client, bufnr)
    attach.keymaps(bufnr)
    attach.illuminate(client)
    attach.disable_default_formatting(servers.disable_default_formatting_servers, client)
    attach.enable_format_on_save(client, bufnr)
end

local function get_lsp_server_opts(server_name)
    local opts = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }
    local has_extra_opts, extra_opts = pcall(require, 'plugins.lsp.settings.' .. server_name)
    if has_extra_opts then
        return vim.tbl_deep_extend('force', opts, extra_opts)
    end
    return opts
end

vim.diagnostic.config {
    virtual_text = true,
    -- show signs
    signs = {
        active = {
            { name = 'DiagnosticSignError', text = '' },
            { name = 'DiagnosticSignWarn', text = '' },
            { name = 'DiagnosticSignHint', text = '' },
            { name = 'DiagnosticSignInfo', text = '' },
        },
    },
    severity_sort = true,
    float = {
        focusable = false,
        border = 'rounded',
        source = 'always',
    },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
    width = 60,
})

-- setup all lsp server at once
for _, server in ipairs(auto_setup_servers_list) do
    lspconfig[server].setup(get_lsp_server_opts(server))
end

-- setup tsserver
require('typescript').setup {
    server = get_lsp_server_opts 'tsserver',
}

-- setup rust_analyzer
require('rust-tools').setup {
    server = get_lsp_server_opts 'rust_analyzer',
}

-- setup nvim lua_ls
lspconfig.lua_ls.setup(get_lsp_server_opts 'lua_ls')
