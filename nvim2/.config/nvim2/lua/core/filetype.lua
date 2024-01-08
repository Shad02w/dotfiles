-- set default file type for file pattern

vim.filetype.add {
    pattern = {
        -- jsonc
        ['package.json'] = 'jsonc',
        ['.swcrc'] = 'jsonc',
        ['.babelrc'] = 'jsonc',
        -- xml
        ['.plist'] = 'xml',
        ['.mobileconfig'] = 'xml',

        -- ruby
        ['Podfile'] = 'ruby',
        ['*.podspec'] = 'ruby',

        -- docker
        ['.dockerignore'] = 'gitignore',
    },
}

local set_file_type_gropup = vim.api.nvim_create_augroup('set_file_type_gropup', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = set_file_type_gropup,
    pattern = { 'docker-compose.yaml', 'compose.yaml' },
    command = 'set filetype=yaml.docker-compose',
})
