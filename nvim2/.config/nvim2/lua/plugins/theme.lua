return {
    {
        'rebelot/kanagawa.nvim',
        config = function()
            local palette = require('kanagawa.colors').setup({ theme = 'dragon' }).palette
            require('kanagawa').setup {
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = 'none',
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = 'none' },
                        FloatBorder = { bg = 'none' },
                        FloatTitle = { bg = 'none' },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MsgArea = { bg = 'none' },
                        NonText = { fg = palette.fujiGray },

                        -- cmp
                        -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        -- PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
                        -- PmenuSbar = { bg = theme.ui.bg_m1 },
                        -- PmenuThumb = { bg = theme.ui.bg_p2 },
                        -- telescope
                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                    }
                end,
            }
        end,
    },
    -- {
    --     'kvrohit/rasmus.nvim',
    -- },
}
