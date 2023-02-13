local saferequire = require 'user.util.saferequire'
local neogit = saferequire 'neogit'
if not neogit then
    return
end

neogit.setup()
