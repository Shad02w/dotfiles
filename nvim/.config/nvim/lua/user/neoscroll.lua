local saferequire = require 'user.util.saferequire'
local neoscroll = saferequire 'neoscroll'
if not neoscroll then
    return
end

neoscroll.setup()
