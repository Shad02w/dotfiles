local M = {}

---@param pattern string[]
---@return boolean
local function has_root(pattern)
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
            return has_root { 'go.mod' }
        end,
    },
    {
        'rust_analyzer',
        cond = function()
            return has_root { 'Cargo.toml' }
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
            return has_root { 'pyproject.toml', 'ruff.toml', '.ruff.toml' }
        end,
    },

    -- js
    'cssls',
    'tailwindcss',
    {
        'tsserver',
        cond = function()
            return has_root { 'package.json' }
        end,
    },
    {
        'biome',
        cond = function()
            return has_root { 'biome.json' }
        end,
    },
    {
        'eslint',
        cond = function()
            return has_root {
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
    'astro',
    -- ruby
    {
        'solargraph',
        cond = function()
            return has_root { 'Gemfile', 'Gemfile.lock', '.solargraph.yml' }
        end,
    },

    {
        'elixirls',
        cond = function()
            return has_root { 'mix.exs' }
        end,
    },

    -- DevOps
    'terraformls',
    {
        'dockerls',
        cond = function()
            return has_root { 'Dockerfile' }
        end,
    },
    {
        'docker_compose_language_service',
        cond = function()
            return has_root { 'docker-compose.yaml', 'compose.yaml' }
        end,
    },
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
