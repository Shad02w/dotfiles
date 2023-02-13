local saferequire = require 'user.util.saferequire'
local dim = saferequire 'dim'
if not dim then
    return
end

dim.setup()
