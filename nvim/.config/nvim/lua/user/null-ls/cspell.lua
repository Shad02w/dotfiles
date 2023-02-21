local M = {}

function M.create_diagnostics_source()
    return require('null-ls').builtins.diagnostics.cspell.with {
        diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity['WARN']
        end,
    }
end

return M
