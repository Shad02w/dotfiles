local saferequire = require 'user.util.saferequire'
local fn = vim.fn

-- Set packer bootstrap is packer are not currently installed
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer...'
    vim.cmd [[packadd packer.nvim]]
end

-- PackageSync after writing to plugins.lua
local packer_user_config_group = vim.api.nvim_create_augroup('packer_user_config_group', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { 'plugins.lua' },
    group = packer_user_config_group,
    callback = function()
        vim.api.nvim_exec([[ source <afile> | PackerSync ]], false)
    end,
})

-- Safely require packer, if packer not install then return
local packer = saferequire 'packer'
if not packer then
    return
end

return packer.startup {
    function(use)
        -- Packer
        use 'wbthomason/packer.nvim'

        -- system
        -- use 'akinsho/bufferline.nvim'
        use 'famiu/bufdelete.nvim'
        -- use 'ojroques/nvim-bufdel' -- solve :bd problem, delete buffer in correct way
        use 'kyazdani42/nvim-web-devicons'
        use 'akinsho/toggleterm.nvim'
        use 'rcarriga/nvim-notify'
        use 'nvim-lua/plenary.nvim'
        use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x', requires = { 'MunifTanjim/nui.nvim' } }
        -- use 'folke/trouble.nvim'

        -- Telescope
        use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
        use 'nvim-telescope/telescope-ui-select.nvim'
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use 'nvim-telescope/telescope-live-grep-args.nvim'
        use 'AckslD/nvim-neoclip.lua'

        -- treesitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use 'nvim-treesitter/nvim-treesitter-textobjects'
        -- use 'nvim-treesitter/playground'
        use 'windwp/nvim-ts-autotag'
        use 'JoosepAlviste/nvim-ts-context-commentstring'

        use 'folke/which-key.nvim'
        use 'sindrets/diffview.nvim'
        use 'nvim-lualine/lualine.nvim'
        use 'windwp/nvim-spectre'
        use 'Shatur/neovim-session-manager'

        -- git
        use { 'lewis6991/gitsigns.nvim', commit = 'd7e0bcbe45bd9d5d106a7b2e11dc15917d272c7a' }
        use 'TimUntersberger/neogit'
        use { 'akinsho/git-conflict.nvim', tag = 'v1.0.0' }

        -- Editor
        use 'jose-elias-alvarez/null-ls.nvim'
        use 'numToStr/Comment.nvim'
        use {
            'tpope/vim-commentary',
            cond = function()
                return vim.g.vscode ~= nil
            end,
        }
        use 'windwp/nvim-autopairs'
        use 'RRethy/vim-illuminate'
        use 'phaazon/hop.nvim'
        use {
            'asvetliakov/vim-easymotion',
            cond = function()
                return vim.g.vscode ~= nil
            end,
        }
        use 'folke/todo-comments.nvim' -- highlight todo
        use { 'kylechui/nvim-surround', tag = '*' }
        -- use 'anuvyklack/pretty-fold.nvim' -- fold code

        -- auto complete
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp' -- lsp compeletion
        use 'hrsh7th/cmp-path' -- path completion
        use 'hrsh7th/cmp-buffer' -- search completion
        use 'hrsh7th/cmp-cmdline'
        use 'saadparwaiz1/cmp_luasnip' -- snippet completion

        -- snippet
        use 'L3MON4D3/LuaSnip' -- snippet engine
        use 'rafamadriz/friendly-snippets'

        -- LSP
        use 'neovim/nvim-lspconfig' -- lsp config
        use 'williamboman/mason.nvim' -- lsp installer v2
        use 'williamboman/mason-lspconfig.nvim'
        use 'fladson/vim-kitty' -- kitty.conf syntax highlight
        use 'ray-x/lsp_signature.nvim'
        use 'jose-elias-alvarez/typescript.nvim' -- extend usage of typescript

        -- experience improvements
        use 'norcalli/nvim-colorizer.lua' -- highlight color string
        use 'narutoxy/dim.lua' -- dimmed unused variable
        use 'karb94/neoscroll.nvim' -- smooth scroll
        use 'sudormrfbin/cheatsheet.nvim' -- vim cheatsheet
        use 'https://gitlab.com/yorickpeterse/nvim-pqf' -- better quick fix
        use 'j-hui/fidget.nvim' -- show lsp progress

        -- util
        use 'dstein64/vim-startuptime'

        -- color scheme
        use 'savq/melange'
        use 'sainnhe/gruvbox-material'
        use 'rebelot/kanagawa.nvim'
        use 'sainnhe/everforest'

        use '/Users/alvistse/Documents/dev/yasks.nvim'

        if PACKER_BOOTSTAP then
            require('packer').sync()
        end
    end,
    -- Have packer use a popup window
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float { border = 'rounded' }
            end,
        },
    },
}
