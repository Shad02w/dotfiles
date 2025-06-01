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
    'cssls',
    'cssmodules_ls',
    'stylelint_lsp',
    -- 'ts_ls',
    'vtsls',
    'tailwindcss',
    'astro',
    'denols',
    'svelte',

    -- python
    'pyright',
    'ruff',

    -- elixir
    'elixirls',

    -- DevOps
    'dockerls',
    'docker_compose_language_service',
    'terraformls',
}

local svelte_didchange_group = vim.api.nvim_create_augroup('svelte_didchange_group', {})
---@alias LspServerName string

---@class LspEnabledServerConfig
---@field enabled? boolean @default true
---@field cond? fun(): boolean
---@field on_attach? fun(client: vim.lsp.Client, bufnr: integer): nil

---@type table<LspServerName, LspEnabledServerConfig | boolean>
M.lsp_server_config = {
    gopls = {
        cond = function()
            return has_root_file { 'go.mod' }
        end,
    },
    rust_analyzer = {
        cond = function()
            return has_root_file { 'Cargo.toml' }
        end,
    },
    jsonls = true,
    yamlls = true,
    lua_ls = true,

    -- python
    pyright = true,
    ruff = {
        cond = function()
            return has_root_file { 'pyproject.toml', 'ruff.toml', '.ruff.toml' }
        end,
    },

    --css
    cssls = true,
    cssmodules_ls = true,
    stylelint_lsp = {
        cond = function()
            return has_root_file {
                'stylelint.config.js',
                'stylelint.config.cjs',
                'stylelint.config.mjs',
                '.stylelintrc.js',
                '.stylelintrc.cjs',
                '.stylelintrc.mjs',
                '.stylelintrc.json',
                '.stylelintrc.yaml',
                '.stylelintrc.yml',
                '.stylelintrc',
            }
        end,
    },

    -- js
    tailwindcss = true,
    vtsls = {
        cond = function()
            return has_root_file { 'package.json' }
        end,
    },
    -- tsserver = {
    --     cond = function()
    --         return has_root_file { 'package.json' }
    --     end,
    -- },
    biome = {
        cond = function()
            return has_root_file { 'biome.json' }
        end,
    },
    eslint = {
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
    svelte = {
        cond = function()
            return has_root_file { 'svelte.config.js', 'svelte.config.cjs', 'svelte.config.mjs', 'svelte.config.ts' }
        end,
        on_attach = function(client)
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = svelte_didchange_group,
                pattern = { '*.js', '*.ts' },
                callback = function(ctx)
                    client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
                end,
            })
        end,
    },
    astro = {
        cond = function()
            return has_root_file { 'package.json' }
        end,
    },
    denols = {
        cond = function()
            return has_root_file { 'deno.json' }
        end,
    },

    elixirls = {
        enabled = false,
        cond = function()
            return has_root_file { 'mix.exs' }
        end,
        on_attach = function(_, bufnr)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr })
        end,
    },

    -- DevOps
    terraformls = true,
    dockerls = {
        cond = function()
            return has_root_file { 'Dockerfile' }
        end,
    },
    docker_compose_language_service = {
        cond = function()
            return has_root_file { 'docker-compose.yaml', 'compose.yaml' }
        end,
    },
}

return M
