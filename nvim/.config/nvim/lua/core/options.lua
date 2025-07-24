function Get_title()
    local filename = vim.fn.expand '%:t'
    if filename == '' then
        filename = '[No Name]'
    end
    local cwd = vim.fn.getcwd()
    local last_two = vim.fn.fnamemodify(cwd, ':h:t') .. '/' .. vim.fn.fnamemodify(cwd, ':t')
    return last_two .. ' (' .. filename .. ')' .. ' - NVIM'
end

local opt = {
    relativenumber = true,
    number = true,

    -- editor
    hidden = true, -- navigate buffers without losing unsaved work
    mouse = 'a', -- Enable mouse support
    fileencoding = 'utf-8',
    linespace = 10,
    numberwidth = 5,
    list = true,
    termguicolors = true,
    autoread = true,
    laststatus = 3,

    -- tab
    tabstop = 4, -- set width of a TAB to 4
    shiftwidth = 4, -- indents will have a width of 4
    softtabstop = 4, -- set number of column of a TAB
    expandtab = true, -- expand tab to spaces

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

    title = true,
    titlestring = '%{v:lua.Get_title()}',
}

for key, value in pairs(opt) do
    vim.opt[key] = value
end

vim.wo.cursorline = true
vim.wo.wrap = false
