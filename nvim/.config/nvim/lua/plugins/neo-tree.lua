return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        keys = {
            { '<leader>ee', '<cmd>Neotree toggle<cr>', desc = 'Toggle NeoTree and focus' },
            { '<leader>ef', '<cmd>Neotree show filesystem right toggle<cr>', desc = 'Show NeoTree' },
            { '<leader>eb', '<cmd>Neotree show buffers right toggle<cr>', desc = 'Show NeoTree' },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'echasnovski/mini.icons',
            'MunifTanjim/nui.nvim',
        },
        cmd = 'Neotree',
        config = function()
            local events = require 'neo-tree.events'
            local on_move = function(data)
                vim.notify(vim.inspect(data))
                Snacks.rename.on_rename_file(data.source, data.destination)
            end
            ---@module 'neo-tree'
            ---@type neotree.Config
            local opts = {
                default_component_configs = {
                    indent = {
                        with_markers = false,
                    },
                    ---@diagnostic disable-next-line: missing-fields
                    icon = {
                        provider = function(icon, node)
                            if node.type == 'file' or node.type == 'terminal' then
                                local success, mini_icons = pcall(require, 'mini.icons')
                                if success then
                                    local file_icon, file_hl = mini_icons.get('file', node.name)
                                    return {
                                        text = file_icon,
                                        highlight = file_hl,
                                    }
                                end
                            elseif node.type == 'directory' then
                                local success, mini_icons = pcall(require, 'mini.icons')
                                if success then
                                    local dir_icon, dir_hl = mini_icons.get('directory', node.name)
                                    return {
                                        text = dir_icon,
                                        highlight = dir_hl,
                                    }
                                end
                            end
                            return icon
                        end,
                    },
                },
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
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true, -- use libnv watcher, do not need to press 'R' to manually refresh
                },
                window = {
                    position = 'left',
                    width = 60,
                    mappings = {
                        ['z'] = '',
                        ['<c-z>'] = 'close_all_nodes',
                        ['c'] = function(state)
                            local node = state.tree:get_node()
                            vim.fn.setreg('*', node.path)
                            vim.notify(
                                'Copied path' .. node.path,
                                vim.log.levels.INFO,
                                { title = 'Neo-tree copy path' }
                            )
                        end,
                        ['m'] = {
                            'move',
                            config = {
                                show_path = 'relative',
                            },
                        },
                    },
                },
                source_selector = {
                    winbar = false,
                    truncation_character = '…',
                },
                event_handlers = {
                    { event = events.FILE_RENAMED, handler = on_move },
                    { event = events.FILE_MOVED, handler = on_move },
                },
            }
            require('neo-tree').setup(opts)
        end,
    },
}
