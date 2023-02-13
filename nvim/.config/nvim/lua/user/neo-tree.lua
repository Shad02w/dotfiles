local saferequire = require 'user.util.saferequire'
local neo_tree = saferequire 'neo-tree'

if not neo_tree then
    return
end

local path_copied_message = function(path)
    return 'Copied the path:\n' .. path
end

neo_tree.setup {
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            never_show = { -- remains hidden even if visible is toggled to true
                '.DS_Store',
            },
        },
        follow_current_file = true,
    },
    window = {
        position = 'left',
        width = 60,
        mappings = {
            ['z'] = '',
            ['<c-z>'] = 'close_all_nodes',
            ['c'] = function(state)
                local node = state.tree:get_node()
                vim.fn.setreg('*', node.path, 'c')
                vim.notify(path_copied_message(node.path), vim.log.levels.INFO, {
                    title = 'Neo-tree',
                })
            end,
            ['m'] = {
                'move',
                config = {
                    show_path = 'relative',
                },
            },
            ['<c-f>'] = function(state)
                local node = state.tree:get_node()
            end,
        },
    },
}
