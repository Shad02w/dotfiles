-- require 'user.plugins'
-- require 'user.hop'

-- Disable auto session
local saferequire = require 'user.util.saferequire'
local session = saferequire 'session_manager'
if session then
    session.setup {
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
        autosave_last_session = false,
    }
end

vim.opt.ignorecase = true
vim.opt.hlsearch = true

-- keymap
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

local showWhichKeyCommand = [[<Cmd>call VSCodeNotify('whichkey.show')<CR>]]
set('n', '<Space>', showWhichKeyCommand, opts)
set('x', '<Space>', showWhichKeyCommand, opts)

set('n', '<Tab>', [[:Tabnext<CR>]], opts)
set('n', '<S-Tab>', [[:Tabp<CR>]], opts)

set('n', 'gd', [[<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>]], opts)
set('n', 'gr', [[<Cmd>call VSCodeNotify('references-view.findReferences')<CR>]], opts)
set('n', 'rn', [[<Cmd>call VSCodeNotify('editor.action.rename')<CR>]], opts)

set('v', 'gc', [[<Plug>VSCodeCommentary]])
set('n', 'gc', [[<Plug>VSCodeCommentary]])
set('n', 'gcc', [[<Plug>VSCodeCommentaryLine]])

-- set('n', ';j', [[<Plug>(easymotion-bd-w)]])
