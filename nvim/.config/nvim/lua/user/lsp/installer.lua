local saferequire = require 'user.util.saferequire'
local lsp_installer = saferequire 'nvim-lsp-installer'
if not lsp_installer then
    return
end

lsp_installer.setup {
    ui = {
        border = 'rounded',
    },
}
