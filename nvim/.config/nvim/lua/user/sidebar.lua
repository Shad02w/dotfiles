local saferequire = require 'user.util.saferequire'
local sidebar = saferequire 'sidebar-nvim'
if not sidebar then
    return
end

sidebar.setup {
    side = 'right',
    hide_statusline = true,
}
