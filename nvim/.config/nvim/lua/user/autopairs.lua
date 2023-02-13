local saferequire = require 'user.util.saferequire'
local npairs = saferequire 'nvim-autopairs'
if not npairs then
    return
end

npairs.setup()
