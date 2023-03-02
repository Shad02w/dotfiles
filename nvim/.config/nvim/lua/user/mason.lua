local saferequire = require 'user.util.saferequire'
local mason = saferequire 'mason'
local masonlspconfig = saferequire 'mason-lspconfig'
if not mason then
    return
end

if not masonlspconfig then
    return
end

mason.setup()
masonlspconfig.setup {
    ensure_installed = {
        'gopls',
        'vimls',
        'html',
        'lua_ls',
        'rust_analyzer',
        'cssls',
        'taplo',
        'jsonls',
        'yamlls',
        'lemminx',
        'astro',
        'tailwindcss',
    },
}
