local utils = require 'heirline.utils'
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
        mode_names = { -- change the strings if you like it vvvvverbose!
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
            i = 'purple',
            v = 'cyan',
            V = 'cyan',
            ['\22'] = 'cyan',
            c = 'orange',
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
                bg = self.mode_colors[self.mode],
                fg = 'dark_text',
            }
        end,
    },
    {
        provider = '',
        hl = function(self)
            return {
                fg = self.mode_colors[self.mode],
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

local Macro = {
    update = { 'RecordingEnter', 'RecordingLeave' },
    condition = function()
        return vim.fn.reg_recording() ~= ''
    end,
    provider = function()
        return ' [' .. vim.fn.reg_recording() .. '] '
    end,
}

local Encoding = utils.surround({ '', '' }, 'text', {
    provider = '%{&encoding}',
    hl = {
        bg = 'text',
        fg = 'dark_text',
    },
})

local Ruler = {
    provider = [[%8(%l:%-3c%)]],
}

local Filetype = {
    provider = function()
        local filetype = vim.bo.filetype
        local fileicon = devicons.get_icon_by_filetype(filetype)
        return '%7(' .. filetype .. ' ' .. (fileicon or '') .. ' %)'
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
    Align,
    Macro,
    Space,
    Ruler,
    Space,
    Filetype,
}
