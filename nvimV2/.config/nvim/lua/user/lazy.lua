local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    -- system
    require 'user.bufdelete',

    require 'user.notify',
    require 'user.neo-tree',
    require 'user.toggleterm',

    require 'user.treesitter',
    require 'user.telescope',

    -- tool
    require 'user.lualine',
    require 'user.spectre',
    require 'user.session',
    require 'user.whichkey',

    -- git
    require 'user.diffview',
    require 'user.gitsigns',
    { 'TimUntersberger/neogit', enabled = false },
    { 'akinsho/git-conflict.nvim', tag = 'v1.0.0', enabled = false },

    -- editor
    { 'windwp/nvim-autopairs', event = { 'TextChanged', 'TextChangedI', 'InsertEnter' }, config = true },
    'RRethy/vim-illuminate',
    { 'kylechui/nvim-surround', version = '*', config = true, lazy = false },
    require 'user.hop',
    require 'user.todo', -- highlight todo
    require 'user.copilot',
    { 'numToStr/Comment.nvim', config = true, keys = { { 'gc', mode = { 'n', 'v' } } } },

    -- lsp
    require 'user.luasnip',
    require 'user.cmp',
    require 'user.lsp',
    require 'user.null-ls',
    { 'fladson/vim-kitty', ft = 'kitty' }, -- kitty.conf syntax highlight

    -- experience improvements
    require 'user.colorizer',
    { 'karb94/neoscroll.nvim', keys = { 'zz', '<c-u>', '<c-d>' }, config = true }, -- smooth scroll
    { 'sudormrfbin/cheatsheet.nvim', enabled = false }, -- vim cheatsheet
    { url = 'https://gitlab.com/yorickpeterse/nvim-pqf', config = true, lazy = false }, -- better quick fix

    -- color scheme
    -- 'sainnhe/everforest',
    -- 'sainnhe/gruvbox-material',
    -- { 'embark-theme/vim', name = 'embark' },
    { 'sam4llis/nvim-tundra', opts = { transparent_background = true } },
    -- {
    --     'rose-pine/neovim',
    --     name = 'rose-pine',
    --     config = function()
    --         require('rose-pine').setup {
    --             variant = 'moon',
    --             dark_variant = 'moon',
    --             dim_nc_background = true,
    --             disable_italics = true,
    --         }
    --     end,
    -- },
    -- { 'kvrohit/mellow.nvim' },
    -- { 'frenzyexists/aquarium-vim' },
}, {
    defaults = {
        lazy = true,
    },
})
