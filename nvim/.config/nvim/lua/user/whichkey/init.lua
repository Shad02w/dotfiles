local saferequire = require 'user.util.saferequire'
local whichkey = saferequire 'which-key'
if not whichkey then
    return
end

local telescope = require 'user.whichkey.telescope'
local toggleterm = require 'user.whichkey.toggleterm'
local hop = require 'user.whichkey.hop'
local quickfix = require 'user.whichkey.quickfix'
local neo_tree = require 'user.whichkey.neo-tree'
local bufferline = require 'user.whichkey.bufferline'
local general = require 'user.whichkey.general'
local spectre = require 'user.whichkey.spectre'

local setup_opts = {
    window = {
        border = 'rounded',
        margin = { 1, 0, 1, 0 },
    },
}

local mapping_opts = {
    silent = true,
    prefix = '<leader>',
    noremap = true,
    nowait = true,
}

local function cmd(command)
    return function()
        vim.cmd(command)
    end
end

local mappings = {
    b = { telescope.buffers, 'Show all buffer' },
    c = {
        name = 'Close buffer',
        o = { general.close_other, 'Close all buffers except current and pinned' },
    },
    C = { telescope.clipboard, 'Clipboard' },
    d = { cmd 'Bdelete', 'Buffer Delete' },
    e = {
        name = 'Explorer',
        e = { neo_tree.toggle, 'Toggle' },
        f = { neo_tree.focus, 'Focus' },
    },
    f = { telescope.find_files, 'Find files' },
    F = { telescope.find_all_files, 'Find all Files' },
    g = {
        name = 'Git',
        d = { cmd 'DiffviewOpen', 'Diffview' },
        o = { cmd 'DiffviewFileHistory %', 'Diffview of current file' },
        O = { cmd 'DiffviewFileHistory', 'Diffview file history' },
        h = {
            name = 'Hunk',
            s = { cmd 'Gitsigns stage_hunk', 'Stage hunk' },
            S = { cmd 'Gitsigns undo_stage_hunk', 'Undo stage hunk' },
        },
    },
    j = { hop.jump_to_word, 'Jump to word' },
    J = { hop.jump_to_line, 'Jump to line' },
    o = { telescope.recent_files, 'Recent files' },
    p = { bufferline.pin_current_buffer, 'Pin current buffer' },
    q = {
        name = 'close',
        q = { quickfix.toggle_quick_fix, 'Toggle quickfix' },
        h = { cmd 'colder', 'Previous quick fix history' },
        l = { cmd 'cnewer', 'Previous quick fix history' },
    },
    s = { telescope.live_grep_raw, 'Search with args' },
    S = {
        name = 'search',
        s = { telescope.live_grep, 'Search All' },
        y = { telescope.live_grep_with_default, 'Search current 0 register' },
    },
    h = {
        spectre.open,
        'Search and replace',
    },
    H = {
        w = { spectre.search_current_word, 'Search current word and replace' },
        f = { spectre.search_current_file, 'Search current file and replace' },
    },
    t = {
        name = 'Terminal',
        t = { toggleterm.open_bottom_term, 'Default' },
        l = { toggleterm.open_left_term, 'Left' },
        f = { toggleterm.open_float_term, 'Float' },
        n = { toggleterm.open_tab_term, 'tab' },
    },
    x = { cmd 'TroubleToggle', 'Trouble' },
    w = {
        name = 'Window',
        v = { cmd 'vsplit', 'Vertical' },
        h = { cmd 'split', 'Horizontal' },
        m = {
            name = 'Move Current Window',
            l = { cmd 'wincmd L', 'Move to Horizontal Left' },
            r = { cmd 'wincmd R', 'Move to Horizontal Right' },
        },
    },
}

whichkey.setup(setup_opts)
whichkey.register(mappings, vim.tbl_extend('force', { mode = 'n' }, mapping_opts))
whichkey.register(mappings, vim.tbl_extend('force', { mode = 'v' }, mapping_opts))

-- Prevent error when Telescope open
local wk = require 'which-key'
local show = wk.show
wk.show = function(keys, opts)
    if vim.bo.filetype == 'TelescopePrompt' then
        local map = '<c-r>'
        local key = vim.api.nvim_replace_termcodes(map, true, false, true)
        vim.api.nvim_feedkeys(key, 'i', true)
    end
    show(keys, opts)
end
