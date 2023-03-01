local M = {}

function M.toggle()
    vim.cmd [[NeoTreeShowToggle]]
end

function M.focus()
    vim.cmd [[NeoTreeFocusToggle]]
end

return M
