local conditions = require 'heirline.conditions'

local Space = { provider = ' ' }

local Align = { provider = '%=' }

local Filename = {
    init = function(self)
        self.modified = vim.api.nvim_get_option_value('modified', {})
        self.readonly = vim.api.nvim_get_option_value('readonly', {})
        self.has_error = conditions.has_diagnostics()
                and (#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0)
            or false
    end,
    hl = function(self)
        if self.has_error then
            return {
                fg = 'diagnostic_error',
            }
        elseif self.modified then
            return {
                fg = 'yellow',
            }
        else
            return {
                fg = 'text',
            }
        end
    end,
    update = {
        'TextChanged',
        'TextChangedI',
        'TextChangedP',
        'TextChangedT',
        'ModeChanged',
        'DiagnosticChanged',
        'BufEnter',
    },
    provider = function()
        local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
        if git_root.match(git_root, 'fatal: not a git repository') then
            return vim.fn.expand '%:.'
        end

        local Path = require 'plenary.path'
        local full_path = vim.fn.expand '%:p'

        if full_path == '' then
            return '[No Name]'
        end

        return Path:new(full_path):make_relative(git_root) .. '%<'
    end,
    fallthrough = false,
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
    {
        provider = ' ',
    },
}

local Navic = {
    condition = function()
        return require('nvim-navic').is_available()
    end,
    provider = function()
        return require('nvim-navic').get_location { highlight = true }
    end,
    update = {
        'CursorMoved',
        'BufEnter',
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
    Space,
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
    Space,
    Navic,
    Align,
    LspDiagnostic,
}
