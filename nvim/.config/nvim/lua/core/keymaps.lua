local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

-- use <space> as leader key
set('', '<Space>', '<Nop>', opts)

-- commonly use
set('n', '0p', [["0p]], opts)

-- set('i', '<esc>', '<Nop>', opts)
set('i', 'jk', '<esc>', opts)

-- batter split window navigation
set('n', '<C-h>', '<C-w>h', opts)
set('n', '<C-l>', '<C-w>l', opts)
set('n', '<C-k>', '<C-w>k', opts)
set('n', '<C-j>', '<C-w>j', opts)

-- better scoll
set('n', '<C-u>', '<C-u>zz', opts)
set('v', '<C-u>', '<C-u>zz', opts)
set('n', '<C-d>', '<C-d>zz', opts)
set('v', '<C-d>', '<C-d>zz', opts)
set('n', 'n', 'nzz', opts)

-- resize window
set('n', '<C-S-o>', ':vertical resize -2<CR>', opts)
set('n', '<C-S-p>', ':vertical resize +2<CR>', opts)

set('n', '<tab>', [[:bn<cr>]], opts)
set('n', '<s-tab>', [[:bN<cr>]], opts)

set('n', '<c-s-/>', function()
    vim.cmd [[Lazy]]
end, opts)

-- gitsigns
-- set('n', ']c', ':Gitsigns next_hunk<cr>zz', opts)
-- set('n', '[c', ':Gitsigns prev_hunk<cr>zz', opts)
