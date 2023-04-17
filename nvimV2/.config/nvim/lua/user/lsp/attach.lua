local format = require 'user.util.formatting'
local M = {}

function M.set_lsp_keymap(bufnr)
    local wk = require 'which-key'
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local mappings = {
        g = {
            d = { vim.lsp.buf.definition, 'Go to Definition' },
            D = { vim.lsp.buf.declaration, 'Go to Declaration' },
            e = { vim.diagnostic.goto_next, 'Next Diagnostic' },
            i = { vim.lsp.buf.implementation, 'Go to Implementation' },
            r = { vim.lsp.buf.references, 'Find All References' },
        },
        K = { vim.lsp.buf.hover, 'Hover' },
        r = {
            n = { vim.lsp.buf.rename, 'Rename' },
        },
        n = {
            name = 'next',
            e = { vim.diagnostic.goto_next, 'Next Diagnostic' },
        },
        p = {
            name = 'prev',
            e = { vim.diagnostic.goto_prev, 'Previous Diagnostic' },
        },
        ['<leader>l'] = {
            name = 'lsp',
            c = { vim.lsp.buf.code_action, 'Code Action' },
            f = { vim.lsp.buf.format, 'Format' },
        },
        ['<leader>k'] = { vim.diagnostic.open_float, 'Open Float' },
    }

    wk.register(mappings, vim.tbl_extend('force', { mode = 'n' }, opts))
    wk.register(mappings, vim.tbl_extend('force', { mode = 'v' }, opts))
end

-- Avoiding LSP formatting conflicts
function M.disable_default_formatting(list, client)
    if vim.tbl_contains(list, client.name) then
        -- following only work on neovim 0.8, change when updated
        client.server_capabilities.document_formatting = false
        client.server_capabilities.documentFormattingProvider = false
    end
end

function M.illuminate(client)
    local status_ok, illuminate = pcall(require, 'illuminate')
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
end

local lsp_formatting_augroup = vim.api.nvim_create_augroup('null_ls_lsp_formatting', {})
function M.enable_format_on_save(_, bufnr)
    -- if not client.supports_method 'textDocument/formatting' then
    --     return
    -- end
    vim.api.nvim_clear_autocmds { group = lsp_formatting_augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = lsp_formatting_augroup,
        buffer = bufnr,
        callback = function()
            format.async_formatting(bufnr)
        end,
    })
end

return M
