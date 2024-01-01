local M = {}

---@param pattern string[]
---@return boolean
local function has_root(pattern)
    local util = require 'lspconfig.util'
    return util.root_pattern(pattern)(vim.loop.cwd()) ~= nil
end

---@param filetypes string[]
---@param formatter string | LspDefaultFormatterFilter
local function set_default_formatter(filetypes, formatter)
    for _, filetype in ipairs(filetypes) do
        M.default_formatter[filetype] = formatter
    end
end

---@type string[]
M.ensure_installed_server = {
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'biome',
    'tsserver',
    'yamlls',
    'cssls',
    'jsonls',
    'tailwindcss',
}

---@class LspEnabledServerConfig
---@field [1] string
---@field cond fun(): boolean
---@field setup nil|fun(): boolean

---@type (LspEnabledServerConfig | string)[]
M.enabled_server = {
    'jsonls',
    'yamlls',
    'lua_ls',
    'cssls',
    'tailwindcss',
    {
        'tsserver',
        cond = function()
            return has_root { 'package.json' }
        end,
    },
    {
        'gopls',
        cond = function()
            return has_root { 'go.mod' }
        end,
    },
    {
        'rust_analyzer',
        cond = function()
            return has_root { 'Cargo.toml' }
        end,
    },
    {
        'biome',
        cond = function()
            return has_root { 'biome.json' }
        end,
    },
}

M.disable_server_formatter = {
    'lua_ls',
    -- disable copilot formatting capability
    'copilot',
    'tailwindcss',
}

---@alias LspDefaultFormatterFilter fun(): string
---@type table<string, string | LspDefaultFormatterFilter>
M.default_formatter = {}

set_default_formatter({ 'lua' }, 'null-ls')
set_default_formatter({ 'go' }, 'gopls')
set_default_formatter({ 'json', 'jsonc' }, function()
    if has_root { 'biome.json' } then
        return 'biome'
    end
    return 'null-ls'
end)

set_default_formatter({ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }, function()
    if has_root { 'biome.json' } then
        return 'biome'
    end
    return 'null-ls'
end)

return M
