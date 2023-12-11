local lspconfig = require 'lspconfig'
local server = require 'plugins.lsp.server'

---@param server string
---@return table|nil
local function get_lsp_server_settings(server)
    local has_settings, settings = pcall(require, 'plugins.lsp.settings.' .. server)
    return has_settings and settings or nil
end

---@param bufnr number
local function assign_keymaps(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gk', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, opts)
end

-- vim.api.nvim_create_autocmd('LspAttach', {
--     pattern = { '*' },
--     callback = function(ev)
--         -- vim.notify 'lsp attached'
--     end,
-- })

lspconfig.gopls.setup {
    on_attach = function(client, bufnr)
        vim.notify 'gopls'
    end,
}
lspconfig.lua_ls.setup {
    on_attach = function(client, bufnr)
        vim.notify 'lua_ls'
    end,
    -- campabilities = require('cmp_nvim_lsp').default_capabilities(),
}

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

-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
--     border = 'rounded',
--     width = 60,
-- })
