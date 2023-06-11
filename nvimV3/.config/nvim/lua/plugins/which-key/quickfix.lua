local M = {}

local function is_quick_fixed_opened()
    local wininfo = vim.fn.getwininfo()
    for _, win in ipairs(wininfo) do
        if win.quickfix == 1 then
            return true
        end
    end
    return false
end

function M.toggle_quick_fix()
    if is_quick_fixed_opened() then
        vim.cmd 'cclose'
    else
        vim.cmd 'copen'
    end
end

return M
