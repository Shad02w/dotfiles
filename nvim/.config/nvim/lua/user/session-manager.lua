local saferequire = require 'user.util.saferequire'

local session = saferequire 'session_manager'
if not session then
    return
end

session.setup {
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
}
