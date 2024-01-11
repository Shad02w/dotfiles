local M = {}

---check if file exists
---@param paths string[]
---@return boolean
M.exist = function(paths)
    ---@param path string
    ---@return boolean
    local function check(path)
        local stat = vim.loop.fs_stat(path)
        return stat ~= nil
    end

    for _, path in ipairs(paths) do
        if check(path) then
            return true
        end
    end

    return false
end

---match path with multiple patterns
---@param path string
---@param patterns string[]
---@return boolean
M.match = function(path, patterns)
    for _, pattern in ipairs(patterns) do
        if string.match(path, pattern) then
            return true
        end
    end

    return false
end

return M
