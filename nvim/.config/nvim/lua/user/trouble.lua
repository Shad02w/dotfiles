local saferequire = require 'user.util.saferequire'
local trouble = saferequire 'trouble'
if not trouble then
    return
end

trouble.setup()
