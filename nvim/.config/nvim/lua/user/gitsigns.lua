local saferequire = require 'user.util.saferequire'
local gitsigns = saferequire 'gitsigns'
if not gitsigns then
    return
end

gitsigns.setup {
    current_line_blame = true,
}
