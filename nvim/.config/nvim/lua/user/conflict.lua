local saferequire = require 'user.util.saferequire'
local conflict = saferequire 'git-conflict'
if not conflict then
    return
end

conflict.setup()
