local saferequire = require 'user.util.saferequire'
local catppuccin = saferequire 'catppuccin'
if not catppuccin then
    return
end

vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
catppuccin.setup {
    dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.6,
    },
    nvimtree = {
        enabled = false,
    },
    neotree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
    },
}

vim.cmd [[
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi LspReferenceText guibg=#2e2f3d
    autocmd VimEnter * hi LspReferenceRead guibg=#2e2f3d
    autocmd VimEnter * hi LspReferenceWrite guibg=#2e2f3d
augroup END
]]
