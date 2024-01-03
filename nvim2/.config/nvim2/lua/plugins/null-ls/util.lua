local M = {}

-- TODO: Remove this, use core.utils.file
-- check a file is exists
---@param path string
---@return boolean
function M.exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat ~= nil
end

return M
