local files = require 'user.util.files'

local M = {}

---Create eslint_d null-ls source
---@param type 'formatting' | 'diagnostics'
---@return unknown
function M.create_prettier_source(type)
    local root = require('null-ls.utils').get_root()

    local ignore_file_path = root .. '/.prettierignore'
    local extra_args = files.exists(ignore_file_path) and { '--ignore-path', ignore_file_path } or {}

    local prettier_config_files = {
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
    }

    return require('null-ls').builtins[type].prettierd.with {
        filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
            'css',
            'scss',
            'less',
            'html',
            'json',
            'jsonc',
            'yaml',
            'markdown',
            'markdown.mdx',
            'graphql',
            'handlebars',
            'svelte',
        },
        prefer_local = 'node_modules/.bin',
        condition = function(utils)
            return utils.root_has_file(prettier_config_files)
        end,
        extra_args = extra_args,
    }
end

return M
