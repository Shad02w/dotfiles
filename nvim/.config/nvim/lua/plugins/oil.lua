return {
    'stevearc/oil.nvim',
    keys = {
        { '-', '<cmd>Oil<cr>', desc = 'Oil' },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
    },
    dependencies = { { 'echasnovski/mini.icons', opts = {} }, 'folke/snacks.nvim' },
    config = function()
        require('oil').setup {
            lsp_file_methods = {
                enabled = false,
            },
            view_options = { show_hidden = true },
        }

        local parse_url = function(url)
            return url:match '^.*://(.*)$'
        end

        local oil_action_post_group = vim.api.nvim_create_augroup('oil_action_post_group', {})
        vim.api.nvim_create_autocmd('User', {
            pattern = 'OilActionsPost',
            group = oil_action_post_group,
            callback = function(event)
                if event.data.actions == nil then
                    return
                end
                for _, action in ipairs(event.data.actions) do
                    if action.type == 'move' then
                        Snacks.rename.on_rename_file(parse_url(action.src_url), parse_url(action.dest_url))
                    end
                end
            end,
        })
    end,
}
