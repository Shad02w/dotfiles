local M = {}

function M.open_float_term()
    vim.api.nvim_exec('ToggleTerm direction=float size=20', false)
end

function M.open_bottom_term()
    vim.api.nvim_exec('ToggleTerm direction=horizontal size=20', false)
end

function M.open_left_term()
    vim.api.nvim_exec('ToggleTerm direction=vertical size=65', false)
end

function M.open_tab_term()
    vim.api.nvim_exec('ToggleTerm direction=tab', false)
end

return M
