local files = require 'user.util.files'

local M = {}

-- @param string type
function M.create_prettier_source(type)
    local root = require('null-ls.utils').get_root()

    local ignore_file_path = root .. '/.prettierignore'
    local extra_args = files.exists(ignore_file_path) and { '--ignore-path', ignore_file_path } or {}

    local have_local_config = files.path_have_files(root, {
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

    if not have_local_config then
        table.insert(extra_args, '--tab-width')
        table.insert(extra_args, '4')
        table.insert(extra_args, '--no-semi')
        table.insert(extra_args, '--single-quote')
        table.insert(extra_args, '--trailing-comma')
        table.insert(extra_args, 'none')
        table.insert(extra_args, '--print-width')
        table.insert(extra_args, '120')
    end

    return require('null-ls').builtins[type].prettier.with {
        prefer_local = 'node_modules/.bin',
        extra_args = extra_args,
    }
end

return M
