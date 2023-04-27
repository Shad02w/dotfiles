local files = require 'user.util.files'

local M = {}

---Create eslint_d null-ls source
---@param type 'formatting' | 'diagnostics'
---@return unknown
function M.create_stylelint_source(type)
    local root = require('null-ls.utils').get_root()

    local ignore_file_path = root .. '/.stylelintignore'
    local extra_args = files.exists(ignore_file_path) and { '--ignore-path', ignore_file_path } or {}

    local stylelint_config_files = {
        '.stylelintrc',
        '.stylelintrc.cjs',
        '.stylelintrc.js',
        '.stylelintrc.json',
        '.stylelintrc.yaml',
        '.stylelintrc.yml',
        'stylelint.config.cjs',
        'stylelint.config.js',
    }

    return require('null-ls').builtins[type].stylelint.with {
        prefer_local = 'node_modules/.bin',
        condition = function(utils)
            return utils.root_has_file(stylelint_config_files)
        end,
        extra_args = extra_args,
    }
end

return M
