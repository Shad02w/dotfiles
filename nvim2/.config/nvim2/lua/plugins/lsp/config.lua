local M = {}

---@param pattern table<string>
---@return boolean
local function has_root(pattern)
    local util = require 'lspconfig.util'
    return util.root_pattern(pattern)(vim.loop.cwd()) ~= nil
end

---@param filetypes table<string>
---@param formatter string | LspDefaultFormatterFilter
local function set_default_formatter(filetypes, formatter)
    for _, filetype in ipairs(filetypes) do
        M.default_formatter[filetype] = formatter
    end
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
    -- disable copilot as the formatter
    'copilot',
}

---@alias LspDefaultFormatterFilter fun(): string
---@type table<string, string | LspDefaultFormatterFilter>
M.default_formatter = {}

set_default_formatter({ 'lua' }, 'null-ls')
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
