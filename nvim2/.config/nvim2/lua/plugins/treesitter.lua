return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'VeryLazy' },
    dependencies = {
        { 'JoosepAlviste/nvim-ts-context-commentstring', commit = '6c30f3c8915d7b31c3decdfe6c7672432da1809d' },
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- HACK: remove when https://github.com/windwp/nvim-ts-autotag/issues/125 closed.
        -- Bugs with self closing tags
        { 'windwp/nvim-ts-autotag', opts = { enable_close_on_slash = false } },
    },
    cmd = {
        'TSBufDisable',
        'TSBufEnable',
        'TSBufToggle',
        'TSDisable',
        'TSEnable',
        'TSToggle',
        'TSInstall',
        'TSInstallInfo',
        'TSInstallSync',
        'TSModuleInfo',
        'TSUninstall',
        'TSUpdate',
        'TSUpdateSync',
    },
    build = ':TSUpdate',
    init = function(plugin)
        -- Copy from AstroNvim, not really sure what this does, but it seems important
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
        require('lazy.core.loader').add_to_rtp(plugin)
        require 'nvim-treesitter.query_predicates'
    end,
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'c',
                'cpp',
                'lua',
                'typescript',
                'javascript',
                'tsx',
                'svelte',
                'go',
                'rust',
                'json',
                'yaml',
                'toml',
                'vim',
                'css',
                'dockerfile',
                'git_rebase',
                'graphql',
                'python',
                'bash',
                'astro',
            },
            highlight = {
                enable = true,
            },
        }
    end,
}
