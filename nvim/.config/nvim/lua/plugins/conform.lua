local disabled_lsp_formatters = { 'tsserver', 'vtsls', 'jsonls' }

local function has_prettier_config()
    local prettier_config_path = vim.fs.root(0, {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.json',
        '.prettierrc.yml',
        '.prettierrc.yaml',
        '.prettierrc.json5',
        '.prettierrc.js',
        '.prettierrc.cjs',
        'prettier.config.js',
        'prettier.config.cjs',
        '.prettierrc.toml',
    })

    return prettier_config_path
end

local function has_biome_config()
    local biome_json_path = vim.fs.root(0, 'biome.json')

    return biome_json_path
end

local function has_eslint_config()
    local eslint_config_path = vim.fs.root(0, {
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
    })

    return eslint_config_path
end

local function has_stylelint_config()
    return vim.fs.root(0, {
        '.stylelintrc.js',
        '.stylelintrc.cjs',
        '.stylelintrc.yaml',
        '.stylelintrc.yml',
        '.stylelintrc.json',
        'stylelint.config.js',
        'stylelint.config.cjs',
        '.stylelintrc.toml',
    })
end

local function has_deno_config()
    local deno_config_path = vim.fs.root(0, {
        'deno.json',
    })

    return deno_config_path
end

local function jsFormatter()
    ---@type conform.FiletypeFormatterInternal
    local formatter = {}

    -- only use deno fmt if deno.json exist
    if has_deno_config() then
        return { lsp_format = 'prefer' }
    end

    if has_biome_config() then
        table.insert(formatter, 'biome')
    end

    if has_eslint_config() then
        -- use eslint-lsp
        formatter.lsp_format = 'first'
    end

    if has_prettier_config() then
        table.insert(formatter, 'prettierd')
    end

    return formatter
end

local function cssFormatter()
    ---@type conform.FiletypeFormatterInternal
    local formatter = {}

    if has_biome_config() then
        table.insert(formatter, 'biome')
    end

    if has_prettier_config() then
        table.insert(formatter, 'prettierd')
    end

    if has_stylelint_config() then
        table.insert(formatter, 'stylelint')
    end

    return formatter
end

local function htmlFormatter()
    ---@type conform.FiletypeFormatterInternal
    local formatter = {}

    if has_biome_config() then
        table.insert(formatter, 'biome')
    end

    if has_prettier_config() then
        table.insert(formatter, 'prettierd')
    end

    return formatter
end

local function jsonFormatter()
    ---@type conform.FiletypeFormatterInternal
    local formatter = {}

    -- only use deno fmt if deno.json exist
    if has_deno_config() then
        return { lsp_format = 'prefer' }
    end

    if has_biome_config() then
        table.insert(formatter, 'biome')
    end

    if has_prettier_config() then
        table.insert(formatter, 'prettierd')
    end

    return formatter
end

return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
        require('conform').setup {
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { 'stylua' },
                typescript = jsFormatter,
                javascript = jsFormatter,
                typescriptreact = jsFormatter,
                javascriptreact = jsFormatter,
                astro = jsFormatter,
                svelte = jsFormatter,
                yaml = jsFormatter,
                html = htmlFormatter,
                css = cssFormatter,
                scss = cssFormatter,
                go = { lsp_format = 'prefer' },
                json = jsonFormatter,
                jsonc = jsonFormatter,
            },
            format_after_save = {
                timeout_ms = 1000,
                ---@param client vim.lsp.Client
                filter = function(client)
                    return not vim.tbl_contains(disabled_lsp_formatters, client.name)
                end,
            },
        }
    end,
}
