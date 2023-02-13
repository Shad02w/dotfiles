-- Put all override vim.lsp.handlers logic here
local M = {}

function M.override()
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
        width = 60,
    })
end

return M
