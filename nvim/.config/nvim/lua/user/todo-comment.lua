local saferequire = require 'user.util.saferequire'
local todo = saferequire 'todo-comments'
if not todo then
    return
end

todo.setup {
    highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
    },
    colors = {
        info = { '#56f00e' },
    },
}
