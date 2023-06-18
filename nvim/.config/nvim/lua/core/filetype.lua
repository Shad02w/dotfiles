-- Set default file type
local function set(pattern, filetype)
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = pattern,
        callback = function()
            vim.cmd('set filetype=' .. filetype)
        end,
    })
end

set({ 'Podfile', '*.podspec' }, 'ruby')
set({ '.swcrc', '.babelrc', 'package.json' }, 'jsonc')
set({ '.plist', '.mobileconfig' }, 'xml')
