local saferequire = require 'user.util.saferequire'
local neoclip = saferequire 'neoclip'
if not neoclip then
    return
end

neoclip.setup {}
