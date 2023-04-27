local M = {}

function M.jump_to_word()
    require('hop').hint_words()
end

function M.jump_to_line()
    vim.cmd 'HopLine'
end

return M
