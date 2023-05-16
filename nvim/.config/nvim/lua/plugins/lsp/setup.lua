local lspconfig = require 'lspconfig'
local attach = require 'plugins.lsp.attach'

local servers = {
    'gopls',
    'vimls',
    'html',
    'lua_ls',
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

local disable_default_formatting_servers = {
    'html',
    'lua_ls',
    'tsserver',
    'cssls',
    'jsonls',
}

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

-- get lsp capabilities
local on_attach = function(client, bufnr)
    attach.keymap(bufnr)
    attach.illuminate(client)
    attach.disable_default_formatting(disable_default_formatting_servers, client)
    attach.enable_format_on_save(client, bufnr)
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
