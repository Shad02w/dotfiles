return {
    'barrett-ruth/import-cost.nvim',
    enabled = function()
        return vim.fs.root(0, {
            'package.json',
            'yarn.lock',
            'pnpm-lock.yaml',
            'pnpm-workspace.yaml',
            'deno.json',
        })
    end,
    event = { 'CursorHold', 'CursorHoldI' },
    build = 'sh install.sh yarn',
    config = true,
}
