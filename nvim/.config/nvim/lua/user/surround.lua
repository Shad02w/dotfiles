local saferequire = require 'user.util.saferequire'
local surround = saferequire 'nvim-surround'
if not surround then
    return
end

surround.setup()
