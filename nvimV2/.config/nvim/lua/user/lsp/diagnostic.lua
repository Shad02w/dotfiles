local M = {}

local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
}

local config = {
    virtual_text = true,
    -- show signs
    signs = {
        active = signs,
    },
    severity_sort = true,
    float = {
        focusable = false,
        border = 'rounded',
        source = 'always',
    },
}

function M.setup()
    vim.diagnostic.config(config)
end

return M
