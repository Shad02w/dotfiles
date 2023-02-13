local saferequire = require 'user.util.saferequire'
local hop = saferequire 'hop'
if not hop then
    return
end

hop.setup {}
