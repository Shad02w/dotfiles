-- gruvbox-material
-- local colorscheme = 'gruvbox-material'
-- vim.g.gruvbox_material_background = 'soft'
-- vim.g.gruvbox_material_foreground = 'mix'

-- mellow
-- local colorscheme = 'mellow'
-- vim.g.mellow_bold_functions = true

-- tundra
-- vim.opt.background = 'dark'

-- kanagawa-dragon
local colorscheme = 'kanagawa-dragon'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    print('colorscheme: ' .. colorscheme .. ' can not be set')
end

-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

-- changed default colorscheme for diffview
vim.cmd [[hi DiffAdd guifg=NONE guibg=#4b5632]]
vim.cmd [[hi DiffChange guifg=NONE guibg=#523e07]]
vim.cmd [[hi DiffDelete guifg=NONE guibg=#68271c]]
vim.cmd [[hi DiffText guifg=NONE guibg=#947726]]

vim.cmd [[hi NonText guifg=#c2c2c2]]

vim.cmd [[set termguicolors]]
