local M = {}

M.ensure_installed_server = {
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'biome',
}

M.enabled_server = M.ensure_installed_server

return M
