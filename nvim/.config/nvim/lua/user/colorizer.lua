local saferequire = require 'user.util.saferequire'
local colorizer = saferequire 'colorizer'
if not colorizer then
    return
end

colorizer.setup {
    'lua',
    'less',
    'scss',
    'css',
    'html',
    'javascript',
    'typescriptreact',
    'typescript',
}
