local M = {}

---@param pattern string[]
---@return boolean
local function has_root_file(pattern)
    local util = require 'lspconfig.util'
    return util.root_pattern(pattern)(vim.loop.cwd()) ~= nil
end

---@type string[]
M.ensure_installed = {
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'yamlls',
    'jsonls',

    -- js
    'biome',
    'eslint',
    'ts_ls',
    'cssls',
    'tailwindcss',
    'astro',
    'denols',

    -- ruby
    'solargraph',

    -- python
    'pyright',
    'ruff_lsp',

    -- elixir
    'elixirls',

    -- DevOps
    'dockerls',
    'docker_compose_language_service',
    'terraformls',

    -- general
    'typos_lsp',
}

---@class LspEnabledServerConfig
---@field [1] string
---@field cond fun(): boolean
---@field setup nil|fun(): boolean

---@type (LspEnabledServerConfig | string)[]
M.enabled_server = {
    {
        'gopls',
        cond = function()
            return has_root_file { 'go.mod' }
        end,
    },
    {
        'rust_analyzer',
        cond = function()
            return has_root_file { 'Cargo.toml' }
        end,
    },
    'jsonls',
    'yamlls',
    'lua_ls',

    -- python
    'pyright',
    {
        'ruff_lsp',
        cond = function()
            return has_root_file { 'pyproject.toml', 'ruff.toml', '.ruff.toml' }
        end,
    },

    -- js
    'cssls',
    'tailwindcss',
    {
        'tsserver',
        cond = function()
            return has_root_file { 'package.json' }
        end,
    },
    {
        'biome',
        cond = function()
            return has_root_file { 'biome.json' }
        end,
    },
    {
        'eslint',
        cond = function()
            return has_root_file {
                '.eslintrc.js',
                '.eslintrc.cjs',
                '.eslintrc.yaml',
                '.eslintrc.yml',
                '.eslintrc.json',
                'eslint.config.js',
                'eslint.config.mjs',
                'eslint.config.cjs',
                'eslint.config.ts',
                'eslint.config.mts',
                'eslint.config.cts',
            }
        end,
    },
    -- 'astro',
    {
        'denols',
        cond = function()
            return has_root_file { 'deno.json' }
        end,
    },

    -- ruby
    {
        'solargraph',
        cond = function()
            return has_root_file { 'Gemfile', 'Gemfile.lock', '.solargraph.yml' }
        end,
    },

    {
        'elixirls',
        cond = function()
            return has_root_file { 'mix.exs' }
        end,
    },

    -- DevOps
    'terraformls',
    {
        'dockerls',
        cond = function()
            return has_root_file { 'Dockerfile' }
        end,
    },
    {
        'docker_compose_language_service',
        cond = function()
            return has_root_file { 'docker-compose.yaml', 'compose.yaml' }
        end,
    },

    -- general
    'typos_lsp',
}

-- M.disable_server_formatter = {
--     'lua_ls',
--     -- disable copilot formatting capability
--     'copilot',
--     'tailwindcss',
--     'cssls',
--     'dockerls',
--     'docker_compose_language_service',
-- }

return M
