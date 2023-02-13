local saferequire = require 'user.util.saferequire'
local signature = saferequire 'lsp_signature'
if not signature then
    return
end

signature.setup {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window = false,
    hint_enable = true, -- virtual hint enable
    handler_opts = {
        border = 'rounded',
    },
}
