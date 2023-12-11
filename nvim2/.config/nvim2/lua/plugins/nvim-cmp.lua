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
        -- 'hrsh7th/cmp-buffer', -- search completion
        -- 'hrsh7th/cmp-cmdline', -- cmd completion
        -- 'saadparwaiz1/cmp_luasnip', -- snippet completion
    },
    config = function()
        local cmp = require 'cmp'
        cmp.setup {
            sources = cmp.config.sources {
                -- { name = 'nvim_lsp' },
                { name = 'path' },
            },
            experimental = {
                native_menu = false,
            },
        }
    end,
}
