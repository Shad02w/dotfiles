local kind_icons = {
    Class = ' ',
    Color = ' ',
    Constant = 'ﲀ ',
    Constructor = ' ',
    Enum = '練',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = '',
    Folder = ' ',
    Function = ' ',
    Interface = 'ﰮ ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Operator = '',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = '塞',
    Value = ' ',
    Variable = ' ',
}

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path', -- path completion
        'hrsh7th/cmp-buffer', -- search completion
        'hrsh7th/cmp-cmdline', -- cmd completion
        'saadparwaiz1/cmp_luasnip', -- snippet completion
    },
    config = function()
        local cmp = require 'cmp'
        cmp.setup {
            mapping = {
                ['<cr>'] = cmp.mapping.confirm { select = true },
                ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'path' },
            }, {
                { name = 'buffer' },
            }),
            snippet = {
                expand = function(args)
                    vim.notify(vim.inspect(args))
                end,
            },
            experimental = {
                native_menu = false,
            },
        }

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'cmdline' },
            }, {
                { name = 'path' },
            }),
        })
    end,
}
