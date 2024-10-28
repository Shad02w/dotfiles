local M = {}

---@param client vim.lsp.Client
---@param bufnr number
local function keymaps(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    if client.name == 'elixirls' then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    else
        vim.keymap.set('n', 'gd', '<cmd>Trouble lsp_definitions<cr>', opts)
    end
    vim.keymap.set('n', 'gk', '<cmd>Trouble lsp_type_definitions<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>Trouble lsp_implementations<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>Trouble lsp_references<cr>', opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'ge', function()
        vim.diagnostic.jump {
            severity = vim.diagnostic.severity.ERROR,
            count = 1,
            float = true,
        }
    end, opts)
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>le', function()
        vim.diagnostic.jump { count = -1, float = true }
    end, opts)
    vim.keymap.set('n', '<leader>ne', function()
        vim.diagnostic.jump { count = 1, float = true }
    end, opts)
    vim.keymap.set('n', '<leader>lc', function()
        require('lazy').load { plugins = { 'telescope.nvim' } }
        vim.lsp.buf.code_action()
    end, opts)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()
-- enable code folding, related to nvim-ufo
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

---@param client vim.lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
    keymaps(client, bufnr)
end

---@param server_name string
---@return table|nil
M.get_settings = function(server_name)
    local has_settings, settings = pcall(require, 'plugins.lsp.settings.' .. server_name)
    return has_settings and settings or nil
end

return M
