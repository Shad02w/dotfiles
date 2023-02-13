local options = {
    relativenumber = true,
    number = true,

    -- editor
    -- clipboard = 'unnamedplus',
    hidden = true, -- navigate buffers without losing unsaved work
    mouse = 'a', -- Enable mouse support
    fileencoding = 'utf-8',
    tabstop = 4, -- set width of a TAB to 4
    shiftwidth = 4, -- indents will have a width of 4
    softtabstop = 4, -- set number of column of a TAB
    expandtab = true, -- expand tab to spaces
    linespace = 10,
    numberwidth = 5,
    guifont = 'FiraMono Nerd Font:h13',
    list = true,
    termguicolors = true,
    -- listchars = { lead = '⋅', tab = '|  ' },
    autoread = true,

    -- search
    ignorecase = true,
    smartcase = true,
    hlsearch = true,

    -- cmp
    pumheight = 10,
    modifiable = true,
    timeoutlen = 1000,

    -- foldmethod = 'expr',
    -- foldexpr = 'nvim_treesitter#foldexpr()',
    --
    fillchars = vim.opt.fillchars + 'diff:╱',
}

vim.wo.cursorline = true
vim.wo.wrap = false

for key, value in pairs(options) do
    vim.opt[key] = value
end
