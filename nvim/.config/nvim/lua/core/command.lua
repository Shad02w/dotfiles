function Save_without_format()
    vim.api.nvim_command 'noautocmd :w'
end

vim.api.nvim_command [[ command! save_without_format :lua Save_without_format() ]]
