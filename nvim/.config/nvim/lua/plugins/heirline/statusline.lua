local devicons = require 'nvim-web-devicons'
local conditions = require 'heirline.conditions'

local Space = { provider = ' ' }
local Align = { provider = '%=' }

-- 1. **Arrow Separators**:
--    - `` (Powerline arrow right)
--    - `` (Powerline arrow left)
--    - `` (Powerline arrow right small)
--    - `` (Powerline arrow left small)
-- 2. **Rounded Separators**:
--    - `` (Powerline rounded right)
--    - `` (Powerline rounded left)
-- 3. **Flame Separators**:
--    - `` (Powerline flame right)
--    - `` (Powerline flame left)
-- 4. **Block Separators**:
--    - `█` (Full block)
--    - `▓` (Dark shade block)
--    - `▒` (Medium shade block)
--    - `░` (Light shade block)
-- 5. **Slant Separators**:
--    - `` (Powerline slant right)
--    - `` (Powerline slant left)
--
local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    static = {
        mode_names = {
            n = 'N',
            no = 'N?',
            nov = 'N?',
            noV = 'N?',
            ['no\22'] = 'N?',
            niI = 'Ni',
            niR = 'Nr',
            niV = 'Nv',
            nt = 'Nt',
            v = 'V',
            vs = 'Vs',
            V = 'V_',
            Vs = 'Vs',
            ['\22'] = '^V',
            ['\22s'] = '^V',
            s = 'S',
            S = 'S_',
            ['\19'] = '^S',
            i = 'I',
            ic = 'Ic',
            ix = 'Ix',
            R = 'R',
            Rc = 'Rc',
            Rx = 'Rx',
            Rv = 'Rv',
            Rvc = 'Rv',
            Rvx = 'Rv',
            c = 'C',
            cv = 'Ex',
            r = '...',
            rm = 'M',
            ['r?'] = '?',
            ['!'] = '!',
            t = 'T',
        },
        mode_colors = {
            n = 'white',
            i = 'line_highlight',
            v = 'cyan',
            V = 'cyan',
            ['\22'] = 'cyan',
            c = 'purple',
            s = 'green',
            S = 'green',
            ['\19'] = 'green',
            R = 'orange',
            r = 'orange',
            ['!'] = 'red',
            t = 'red',
        },
    },
    update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
            vim.cmd 'redrawstatus'
        end),
    },
    {
        provider = function(self)
            return '  %2(' .. self.mode_names[self.mode] .. '%)'
        end,
        hl = function(self)
            return {
                bg = self.mode_colors[self.mode] or 'green',
                fg = 'dark_text',
            }
        end,
    },
    {
        provider = '',
        hl = function(self)
            return {
                fg = self.mode_colors[self.mode] or 'green',
            }
        end,
    },
}
local Git = {
    condition = conditions.is_git_repo,
    hl = {
        fg = 'git_text',
        bold = true,
    },
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
        provider = function(self)
            return '󰘬 ' .. self.status_dict.head
        end,
    },
    {
        condition = function(self)
            return self.has_changes and type(self.status_dict.added) == 'number'
        end,
        { provider = '(' },
        {
            provider = function(self)
                return '+' .. self.status_dict.added
            end,
            hl = {
                fg = 'git_add',
            },
        },
        {
            provider = function(self)
                return '~' .. self.status_dict.changed
            end,
            hl = {
                fg = 'git_change',
            },
        },
        {
            provider = function(self)
                return '-' .. self.status_dict.removed
            end,
            hl = {
                fg = 'git_delete',
            },
        },
        { provider = ')' },
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
        'LspAttach',
    },
}

local LspInfo = {
    static = {
        icons = {
            ['typescript-tools'] = ' ',
            ['biome'] = '󰔶 ',
            ['cssmodules_ls'] = ' Module',
            ['jsonls'] = ' ',
            ['dockerls'] = ' ',
            ['docker_compose_language_service'] = ' ',

            ['lua_ls'] = ' ',
            ['rust_analyzer'] = ' ',
            ['tailwindcss'] = '󱏿 ',
            ['gopls'] = ' ',
            ['copilot'] = ' ',
            ['null-ls'] = '󰱺 ',
            ['pyright'] = ' ',
            ['ruff_lsp'] = ' ',
            ['elixirls'] = ' ',
        },
    },
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },
    hl = {
        fg = 'green',
    },
    provider = ' LSP: ',
    {
        hl = { bold = false },
        provider = function(self)
            -- get_active_clients will be deprecated in nvim 0.10
            local get_clients = vim.lsp.get_clients ~= nil and vim.lsp.get_clients or vim.lsp.get_active_clients
            local clients = get_clients { bufnr = 0 }
            local names = {}
            for _, client in ipairs(clients) do
                table.insert(names, self.icons[client.name] or client.name)
            end
            return table.concat(names, ' ')
        end,
    },
    on_click = {
        callback = function()
            vim.cmd 'LspInfo'
        end,
        name = 'heirline_lsp_info',
    },
}

local Macro = {
    update = { 'RecordingEnter', 'RecordingLeave' },
    condition = function()
        return vim.fn.reg_recording() ~= ''
    end,
    provider = function()
        return ' [' .. vim.fn.reg_recording() .. '] '
    end,
}

local FindResult = {
    condition = function()
        return vim.v.hlsearch == 1
    end,
    provider = function()
        local max_count = 999

        local ok, search = pcall(vim.fn.searchcount, { maxcount = max_count })

        if not ok then
            return ' [0/0] '
        end

        local total = search.total
        if search.total > max_count then
            total = '<' .. max_count
        end
        return ' [' .. search.current .. '/' .. total .. '] '
    end,
}

local Ruler = {
    provider = [[ %2l:%-2c ]],
}

local Filetype = {
    provider = function()
        local filetype = vim.bo.filetype
        local fileicon = devicons.get_icon_by_filetype(filetype)
        return filetype .. ' ' .. (fileicon or '') .. ' '
    end,
    update = { 'BufEnter' },
}

return {
    hl = {
        fg = 'text',
        bold = true,
    },
    -- vi mode
    ViMode,
    Space,
    Space,
    Git,
    Space,
    Space,
    Navic,
    Align,
    Macro,
    FindResult,
    Space,
    LspInfo,
    Space,
    Ruler,
    Space,
    Filetype,
}
