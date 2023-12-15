local M = {}

local non_deletable_filetype = { '', 'nofile', 'qf', 'quickfile', 'help', 'notify' }
M.close_other_buffer = function()
    local tab_id = vim.api.nvim_win_get_tabpage(0)
    local wins = vim.api.nvim_tabpage_list_wins(tab_id)

    local current_tab_buffers = {}
    for _, win in ipairs(wins) do
        table.insert(current_tab_buffers, vim.api.nvim_win_get_buf(win))
    end

    local buffer_to_delete = vim.tbl_filter(function(b)
        if vim.tbl_contains(current_tab_buffers, b) then
            return false
        end

        local filetype = vim.bo[b].filetype

        if vim.tbl_contains(non_deletable_filetype, filetype) then
            return false
        end

        return true
    end, vim.api.nvim_list_bufs())

    if #buffer_to_delete == 0 then
        return
    end

    require('bufdelete').bufdelete(buffer_to_delete, true)
end

return M
