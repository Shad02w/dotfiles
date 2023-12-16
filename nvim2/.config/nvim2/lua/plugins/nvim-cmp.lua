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

---prevent cmp menu pop up when hitting tab key
local function has_word_before()
    local u = unpack or table.unpack
    local line, col = u(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

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

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup {
            view = {
                entries = 'custom',
            },
            window = {
                completion = cmp.config.window.bordered { winhighlight = highlight },
                documentation = cmp.config.window.bordered { winhighlight = highlight },
            },
            formatting = {
                expandable_indicator = true,
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
            mapping = {
                ['<up>'] = cmp.mapping.select_prev_item(),
                ['<down>'] = cmp.mapping.select_next_item(),
                ['<cr>'] = cmp.mapping.confirm { select = true },
                ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif has_word_before() then
                        cmp.complete()
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
        }

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        ---@diagnostic disable-next-line: missing-fields
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
