local config = require 'plugins.lsp.config'
local format = require 'plugins.lsp.format'
local M = {}

---@param client lsp.Client
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
    vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>lc', function()
        require('lazy').load { plugins = { 'telescope.nvim' } }
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set('n', '<leader>lf', format, opts)
end

---@param bufnr number
local function command(bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        format(bufnr)
    end, {})
end

local attach_format_on_save = vim.api.nvim_create_augroup('attach_format_on_save', {})
---@param bufnr number
local function format_on_save(bufnr)
    -- to make sure trigger only format on save only once at a buffer
    vim.api.nvim_clear_autocmds { group = attach_format_on_save, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = attach_format_on_save,
        buffer = bufnr,
        callback = function()
            format(bufnr)
        end,
    })
end

---@param client lsp.Client
local function disable_formatter(client)
    if vim.tbl_contains(config.disable_server_formatter, client.name) then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()
-- enable code folding, related to nvim-ufo
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

---@param client lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
    disable_formatter(client)
    keymaps(client, bufnr)
    command(bufnr)
    format_on_save(bufnr)
end

---@param server_name string
---@return table|nil
M.get_settings = function(server_name)
    local has_settings, settings = pcall(require, 'plugins.lsp.settings.' .. server_name)
    return has_settings and settings or nil
end

return M
