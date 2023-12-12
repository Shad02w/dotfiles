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
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path', -- path completion
        'hrsh7th/cmp-buffer', -- search completion
        'hrsh7th/cmp-cmdline', -- cmd completion
        { 'saadparwaiz1/cmp_luasnip', dependencies = { 'L3MON4D3/LuaSnip' } }, -- snippet completion
    },
    config = function()
        local cmp = require 'cmp'
        local highlight = 'Normal:Normal,FloatBorder:None,CursorLine:Visual,Search:None'
        cmp.setup {
            view = {
                entries = 'custom',
            },
            window = {
                completion = cmp.config.window.bordered { winhighlight = highlight },
                documentation = cmp.config.window.bordered { winhighlight = highlight },
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snippet]',
                        path = '[Path]',
                        buffer = '[Buffer]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
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
                { name = 'luasnip' },
            }, {
                { name = 'path' },
            }, {
                { name = 'buffer' },
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- },
            -- experimental = {
            --     native_menu = true,
            -- },
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
