local saferequire = require 'user.util.saferequire'
if saferequire 'lspconfig' == nil then
    return
end

require 'user.lsp.config'
