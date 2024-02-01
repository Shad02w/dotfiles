local M = {}

---get max columns number of the buffer
---@param bufnr integer
---@param num_lines integer
---@return integer
local function get_max_column_of_buffer(bufnr, num_lines)
    local max_col = 0
    for i = 1, num_lines do
        local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
        max_col = math.max(max_col, #line)
    end
    return max_col
end

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

local max_columns = 300
local max_line = 4000

---check if file is large file
---@param buf number
---@return boolean
M.is_large_file = function(buf)
    local num_lines = vim.api.nvim_buf_line_count(buf)

    if num_lines > max_line or get_max_column_of_buffer(buf, num_lines) > max_columns then
        vim.api.nvim_set_option_value('syntax', 'off', { buf = buf })
        return true
    end
    return false
end

return M
