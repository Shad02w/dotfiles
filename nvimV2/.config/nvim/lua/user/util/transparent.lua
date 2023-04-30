local M = {}

local term = vim.api.nvim_exec2('echo $TERM', { output = true }).output

function M.use_transparent_theme()
    if string.match(term, '256color') then
        return true
    else
        return false
    end
end

return M
