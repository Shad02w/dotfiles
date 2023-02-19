local lspconfig = require 'lspconfig'
local attach = require 'user.lsp.attach'
local diagnostic = require 'user.lsp.diagnostic'
local handlers = require 'user.lsp.handlers'
local saferequire = require 'user.util.saferequire'

local servers = {
    'gopls',
    'vimls',
    'html',
    'lua_ls',
    'rust_analyzer',
    'cssls',
    'taplo',
    'jsonls',
    'yamlls',
    'lemminx',
    'astro',
    'tailwindcss',
}

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
    local has_extra_opts, extra_opts = pcall(require, 'user.lsp.settings.' .. server)
    if has_extra_opts then
        opts = vim.tbl_deep_extend('force', opts, extra_opts)
    end

    lspconfig[server].setup(opts)
end

-- setup typescript servers
local typescript = saferequire 'typescript'
if typescript then
    local opts = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }

    -- merge extra options
    local has_extra_opts, extra_opts = pcall(require, 'user.lsp.settings.tsserver')
    if has_extra_opts then
        opts = vim.tbl_deep_extend('force', opts, extra_opts)
    end
    typescript.setup {
        server = opts,
    }
end
