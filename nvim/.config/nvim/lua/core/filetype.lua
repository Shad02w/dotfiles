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
    },
}
