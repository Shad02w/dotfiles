local saferequire = require 'user.util.saferequire'
local nvimtree = saferequire 'nvim-tree'
if not nvimtree then
    return
end

nvimtree.setup {
    update_cwd = true,
    git = {
        enable = false,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    renderer = {
        icons = {
            glyphs = {
                folder = {
                    default = '',
                    open = '',
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    view = {
        side = 'left',
        width = 60,
    },
}
