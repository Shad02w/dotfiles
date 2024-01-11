return {
    'kevinhwang91/nvim-ufo',
    event = { 'CursorMoved', 'CursorMovedI' },
    dependencies = {
        'kevinhwang91/promise-async',
    },
    cmd = {
        'UfoEnable',
        'UfoDisable',
        'UfoInspect',
        'UfoAttach',
        'UfoDetach',
        'UfoEnableFold',
        'UfoDisableFold',
    },
    init = function()
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldcolumn = '1'
        vim.o.foldenable = true
        vim.opt.fillchars:append { fold = ' ', foldsep = ' ', foldopen = '', foldclose = '' }

        -- to remove the fold level index, you need to custom build neovim,
        -- ref: https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1500423577
    end,
    config = function()
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

        ---@diagnostic disable-next-line: missing-fields
        require('ufo').setup {
            provider_selector = function()
                return { 'lsp', 'indent' }
            end,
        }
    end,
}
