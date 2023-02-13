local saferequire = require 'user.util.saferequire'
local M = {}

local function get_listed_bufnr()
    return vim.tbl_map(function(buf)
        return buf.bufnr
    end, vim.fn.getbufinfo { buflisted = true })
end

local function bufferline_groups()
    local groups = saferequire 'bufferline.groups'
    if not groups then
        return nil
    end
    return groups
end

function M.smart_close_other()
    local groups = bufferline_groups()
    local current_bufnr = vim.api.nvim_get_current_buf()

    if vim.bo.filetype == 'qf' then
        return
    end

    for _, bufnr in ipairs(get_listed_bufnr()) do
        if bufnr == current_bufnr then
        elseif groups and groups.is_pinned { id = bufnr } then
        elseif vim.bo[bufnr].filetype == 'qf' then
        else
            vim.cmd(string.format('BufDel %s', bufnr))
        end
    end
end

function M.pin_current_buffer()
    vim.cmd 'BufferLineTogglePin'
end

return M
