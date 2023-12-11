local opt = {
    relativenumber = true,
    number = true,

    -- editor
    hidden = true, -- navigate buffers without losing unsaved work
    mouse = 'a', -- Enable mouse support
    fileencoding = 'utf-8',
    tabstop = 4, -- set width of a TAB to 4
    shiftwidth = 4, -- indents will have a width of 4
    softtabstop = 4, -- set number of column of a TAB
    expandtab = true, -- expand tab to spaces
    linespace = 10,
    numberwidth = 5,
    list = true,
    termguicolors = true,
    autoread = true,

    -- search
    ignorecase = true,
    smartcase = true,
    hlsearch = true,

    -- cmp
    pumheight = 10,
    modifiable = true,
    timeoutlen = 500,

    fillchars = vim.opt.fillchars + 'diff:╱' + 'eob: ',
    -- listchars = { lead = '⋅', tab = '|  ' },
    listchars = vim.opt.listchars + 'tab:▸ ',
}

for key, value in pairs(opt) do
    vim.opt[key] = value
end

vim.wo.cursorline = true
vim.wo.wrap = false
