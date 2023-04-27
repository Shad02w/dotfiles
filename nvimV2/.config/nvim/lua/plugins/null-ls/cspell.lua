local M = {}

function M.create_diagnostics_source()
    return require('null-ls').builtins.diagnostics.cspell.with {
        diagnostic_config = {
            underline = true,
            virtual_text = false,
            signs = false,
            update_in_insert = false,
            severity_sort = true,
        },
        diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity['WARN']
            diagnostic.virtual_text = false
        end,
    }
end

return M
