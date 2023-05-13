-- format
vim.cmd('command LspFormat lua LspFormat()')

function LspFormat()
    vim.notify('Formatting...')
end
