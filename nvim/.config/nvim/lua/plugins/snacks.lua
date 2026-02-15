return {
    'folke/snacks.nvim',
    event = { 'BufEnter', 'BufNewFile' },
    ---@type snacks.Config
    opts = {
        input = { enabled = true },
        bigfile = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false },
        picker = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
}
