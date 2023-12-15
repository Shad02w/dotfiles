local M = {}

---@param pattern table<string>
---@return string|nil
local function get_root(pattern)
    local util = require 'lspconfig.util'
    return util.root_pattern(pattern)(vim.loop.cwd())
end

---@type table<string>
M.ensure_installed_server = {
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'biome',
    'jsonls',
}

M.enabled_server = M.ensure_installed_server

M.disable_server_formatter = {
    'lua_ls',
}

---@alias LspMiddleHandler fun(client: lsp.Client, bufnr: number)
---@type table<string,LspMiddleHandler>
M.hander = {
    ['biome'] = function(client)
        local root = get_root { 'biome.json' }
        if not root then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
    end,
}

return M
