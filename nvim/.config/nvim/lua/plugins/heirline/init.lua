return {
    'rebelot/heirline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
        'nvim-lua/plenary.nvim',
    },
    init = function()
        vim.o.cmdheight = 0
        vim.o.laststatus = 0
    end,
    event = 'VeryLazy',
    config = function()
        vim.o.laststatus = 3

        local kanagawa = require('kanagawa.colors').setup { theme = 'dragon' }
        local utils = require 'heirline.utils'
        local conditions = require 'heirline.conditions'
        local Statusline = require 'plugins.heirline.statusline'
        local Winbar = require 'plugins.heirline.winbar'

        vim.cmd 'hi StatusLine guibg=NONE guifg=NONE'

        ---@param bufnr number
        ---@return boolean
        local function match_no_winbar_files(bufnr)
            return conditions.buffer_matches({
                buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
                filetype = {
                    '^git.*',
                    'fugitive',
                    'Trouble',
                    'dashboard',
                    'Telescope',
                    'Lazy',
                    'spectre_panel',
                    'netrw',
                },
            }, bufnr)
        end

        require('heirline').setup {
            statusline = Statusline,
            winbar = Winbar,
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
                disable_winbar_cb = function(args)
                    return match_no_winbar_files(args.buf)
                end,
            },
        }

        -- set winbar is open file directly since heirline is loaded after VimEnter
        local wins = vim.api.nvim_list_wins()
        for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local filetype = vim.bo[buf].filetype
            if not match_no_winbar_files(buf) and filetype ~= '' then
                vim.api.nvim_set_option_value('winbar', [[%{%v:lua.require'heirline'.eval_winbar()%}]], {
                    win = win,
                })
            end
        end
    end,
}
