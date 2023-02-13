local M = {}
local saferequire = require 'user.util.saferequire'
local hop = saferequire 'hop'
local hint = saferequire 'hop.hint'
if not (hop and hint) then
    return M
end
function M.jump_to_word()
    hop.hint_words()
end

function M.jump_to_line()
    vim.cmd 'HopLine'
end

return M
