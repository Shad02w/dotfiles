local saferequire = require 'user.util.saferequire'
local autopairs = saferequire 'nvim-autopairs'
if not autopairs then
    return
end

autopairs.setup()
