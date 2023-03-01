local M = {}

function M.open()
    require('spectre').open()
end

function M.search_current_word()
    require('spectre').open_visual { select_word = true }
end

function M.search_current_file()
    require('spectre').open_file_search()
end

return M
