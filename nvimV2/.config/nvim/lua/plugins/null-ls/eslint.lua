local files = require 'user.util.files'

local M = {}

---Create eslint_d null-ls source
---@param type 'formatting' | 'diagnostics' | 'code_actions'
---@return unknown
function M.create_eslint_d_source(type)
    local root = require('null-ls.utils').get_root()

    local ignore_file_path = root .. '/.eslintignore'
    local extra_args = files.exists(ignore_file_path) and { '--ignore-path', ignore_file_path } or {}

    return require('null-ls').builtins[type].eslint_d.with {
        extra_args = extra_args,
        condition = function(utils)
            return utils.root_has_file {
                '.eslintrc.js',
                '.eslintrc.cjs ',
                '.eslintrc.yaml',
                '.eslintrc.yml',
                '.eslintrc.json',
            }
        end,
        runtime_condition = function(params)
            local full_path = vim.inspect(vim.fn.expand '%:p')
            if string.match(full_path, 'node_modules/') then
                return false
            end
            return true
        end,
    }
end

---Create eslint null-ls source
---@param type StylelintNullLsType
---@return any
function M.create_eslint_source(type)
    local root = require('null-ls.utils').get_root()

    local ignore_file_path = root .. '/.eslintignore'
    local extra_args = files.exists(ignore_file_path) and { '--ignore-path', ignore_file_path } or {}

    return require('null-ls').builtins[type].eslint.with {
        extra_args = extra_args,
    }
end

return M
