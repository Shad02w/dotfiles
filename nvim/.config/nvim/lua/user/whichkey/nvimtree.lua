local M = {}

function M.toggle()
    vim.api.nvim_exec('NvimTreeToggle', false)
end

function M.focus()
    vim.api.nvim_exec('NvimTreeFocus', false)
end

return M
