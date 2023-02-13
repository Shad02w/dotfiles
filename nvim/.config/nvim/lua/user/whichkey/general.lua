local M = {}

local function get_listed_bufnr()
    return vim.tbl_map(function(buf)
        return buf.bufnr
    end, vim.fn.getbufinfo { buflisted = true })
end

M.close_other = function()
    local current_bufnr = vim.api.nvim_get_current_buf()

    if vim.bo.filetype == 'qf' then
        return
    end

    for _, bufnr in ipairs(get_listed_bufnr()) do
        if bufnr == current_bufnr then
        elseif vim.bo[bufnr].filetype == 'qf' then
        else
            vim.cmd(string.format('bdelete %s', bufnr))
        end
    end
end

return M
