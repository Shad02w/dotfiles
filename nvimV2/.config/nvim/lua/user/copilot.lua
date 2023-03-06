vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<c-s-l>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

return {
    'github/copilot.vim',
    event = 'InsertEnter',
}
