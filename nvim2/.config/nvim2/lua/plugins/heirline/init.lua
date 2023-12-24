return {
    '/rebelot/heirline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
    },
    init = function()
        vim.o.cmdheight = 0
        vim.o.laststatus = 0
        vim.cmd 'hi StatusLine guibg=NONE guifg=NONE'
    end,
    event = { 'BufEnter' },
    config = function()
        vim.o.laststatus = 3

        local kanagawa = require('kanagawa.colors').setup { theme = 'dragon' }
        local utils = require 'heirline.utils'
        local Statusline = require 'plugins.heirline.statusline'

        require('heirline').setup {
            ---@diagnostic disable-next-line: missing-fields
            -- statusline = { provider = 'hi123' },
            statusline = Statusline,
            opts = {
                colors = {
                    line_highlight = kanagawa.palette.roninYellow,
                    text = kanagawa.palette.oldWhite,
                    dark_text = kanagawa.palette.sumiInk4,
                    text_secondary = kanagawa.palette.sumiInk4,
                    yellow = kanagawa.palette.roninYellow,
                    white = kanagawa.palette.oldWhite,
                    green = kanagawa.palette.waveAqua1,
                    cyan = kanagawa.palette.lightBlue,
                    orange = kanagawa.palette.dragonOrange,
                    purple = kanagawa.palette.springViolet1,
                    red = kanagawa.palette.samuraiRed,
                    git_text = kanagawa.palette.surimiOrange,
                    diagnostic_error = kanagawa.palette.samuraiRed,
                    diagnostic_warn = kanagawa.palette.roninYellow,
                    diagnostic_info = kanagawa.palette.waveAqua1,
                    diagnostic_hint = kanagawa.palette.dragonBlue,
                    git_add = utils.get_highlight('GitSignsAdd').fg,
                    git_change = utils.get_highlight('GitSignsChange').fg,
                    git_delete = utils.get_highlight('GitSignsDelete').fg,
                },
            },
        }
    end,
}
