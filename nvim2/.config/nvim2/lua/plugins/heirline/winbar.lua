local conditions = require 'heirline.conditions'

local Space = { provider = ' ' }

local Filename = {
    init = function(self)
        self.modified = vim.api.nvim_get_option_value('modified', {})
        self.readonly = vim.api.nvim_get_option_value('readonly', {})
    end,
    hl = function(self)
        if self.modified then
            return {
                fg = 'yellow',
            }
        else
            return {
                fg = 'text',
            }
        end
    end,
    update = { 'TextChanged', 'TextChangedI', 'TextChangedP', 'TextChangedT', 'ModeChanged' },
    {
        provider = '%f',
    },
    {
        condition = function(self)
            return self.modified
        end,
        provider = '',
        hl = { bold = false },
    },
    {
        condition = function(self)
            return self.readonly
        end,
        provider = '󰌾 ',
    },
}

local LspDiagnostic = {
    condition = conditions.has_diagnostics,
    static = {
        -- copy from lsp setup
        error_icon = ' ',
        warn_icon = ' ',
        info_icon = ' ',
        hint_icon = ' ',
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    update = { 'DiagnosticChanged', 'BufEnter' },
    Space,
    {
        provider = function(self)
            return self.error_icon .. self.errors
        end,
        hl = {
            fg = 'diagnostic_error',
        },
    },
    Space,
    {
        provider = function(self)
            return self.warn_icon .. self.warns
        end,
        hl = {
            fg = 'diagnostic_warn',
        },
    },
    Space,
    {
        provider = function(self)
            return self.info_icon .. self.info
        end,
        hl = {
            fg = 'diagnostic_info',
        },
    },
    Space,
    {
        provider = function(self)
            return self.hint_icon .. self.hints
        end,
        hl = {
            fg = 'diagnostic_hint',
        },
    },
}
return {
    hl = {
        fg = 'text',
        bold = true,
    },
    Space,
    Space,
    Filename,
    Space,
    LspDiagnostic,
}
