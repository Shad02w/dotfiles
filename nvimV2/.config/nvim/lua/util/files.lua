local M = {}

-- check a file is exists
---@param path string
---@return boolean
function M.exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat ~= nil
end

--- gets the line ending for the given buffer based on fileformat
---@param path string
---@param files string[]
---@return boolean
function M.path_have_files(path, files)
    local result = false
    for _, file in ipairs(files) do
        if M.exists(path .. '/' .. file) then
            result = true
            break
        end
    end
    return result
end

return M
