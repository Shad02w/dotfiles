vim.api.nvim_create_user_command('SaveWithoutFormat', function()
    vim.cmd [[silent noautocmd update]]
end, {desc = 'Save file without trigger LSP formatting'})
