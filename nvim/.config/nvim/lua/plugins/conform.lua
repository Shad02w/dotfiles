local disabled_lsp_formatters = { 'typescript-tools' }

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

return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
        local function jsFormatter()
            ---@type conform.FiletypeFormatterInternal
            local formatter = {}

            if has_biome_config() then
                table.insert(formatter, 'biome')
            end

            if has_eslint_config() then
                formatter.lsp_format = 'last'
            end

            if has_prettier_config() then
                ---@type conform.FiletypeFormatterInternal
                table.insert(formatter, 'prettierd')
            end

            return formatter
        end

        require('conform').setup {
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { 'stylua' },
                typescript = jsFormatter,
                javascript = jsFormatter,
                typescriptreact = jsFormatter,
                javascriptreact = jsFormatter,
                json = jsFormatter,
                jsonc = jsFormatter,
                go = { lsp_format = 'prefer' },
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
