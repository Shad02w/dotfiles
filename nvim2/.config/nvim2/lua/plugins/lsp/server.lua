local M = {}

M.ensure_installed_server = {
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'biome',
    "jsonls"
}

M.enabled_server = M.ensure_installed_server

M.disable_server_formatter = {
    'lua_ls'
}

return M
