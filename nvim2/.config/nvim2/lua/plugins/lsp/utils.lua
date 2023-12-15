local config = require 'plugins.lsp.config'
local M = {}

---@bufnr number
local function keymaps(bufnr)
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
    vim.keymap.set('n', '<leader>lf', M.format, opts)
end

---@param bufnr number
local function command(bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        M.format(bufnr)
    end, {})
end

local attach_format_on_save = vim.api.nvim_create_augroup('attach_format_on_save', {})
---@param bufnr number
local function format_on_save(bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = attach_format_on_save,
        buffer = bufnr,
        callback = function()
            M.format(bufnr)
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

local function async_format(bufnr)
    vim.lsp.buf_request(
        bufnr,
        'textDocument/formatting',
        vim.lsp.util.make_formatting_params(),
        function(err, result, context)
            if err then
                vim.notify('Format Error: ' .. err.message, vim.log.levels.ERROR)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
                return
            end

            if result then
                local client = vim.lsp.get_client_by_id(context.client_id)
                vim.lsp.util.apply_text_edits(result, bufnr, client and client.offset_encoding or 'utf-16')
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd 'silent noautocmd update'
                end)
            end
        end
    )
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

---@param client lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
    disable_formatter(client)
    keymaps(bufnr)
    command(bufnr)
    format_on_save(bufnr)
end

---@param server_name string
---@return table|nil
M.get_settings = function(server_name)
    local has_settings, settings = pcall(require, 'plugins.lsp.settings.' .. server_name)
    return has_settings and settings or nil
end

---@param bufnr number
M.format = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- get all clients with formatting capabilities
    ---@type table<lsp.Client>
    local formatable_clients = {}

    for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        if client.server_capabilities.documentFormattingProvider ~= false then
            table.insert(formatable_clients, client)
        end
    end

    if vim.tbl_isempty(formatable_clients) then
        return
    end

    -- if there are more than one formatter, notify me
    if #formatable_clients > 1 then
        vim.notify(
            'Have more than one formatter: '
                .. table.concat(
                    vim.tbl_map(function(_)
                        return _.name
                    end, formatable_clients),
                    ', '
                )
                .. '\nPlease disable the others, leave only one',
            vim.log.levels.WARN,
            { title = 'More than one formatter' }
        )
        return
    end

    async_format(bufnr)
end

return M
