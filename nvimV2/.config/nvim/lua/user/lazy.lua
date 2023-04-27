local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

-- TODO: Move all plugins config to `plugins` directory
require('lazy').setup({
    import = 'plugins',
}, {
    defaults = {
        lazy = true,
        ---@type boolean|fun(self:LazyPlugin):boolean|nil
        cond = function(self)
            if vim.g.vscode then
                if self.name == 'neovim-session-manager' then
                    self.enabled = true
                end
                return false
            else
                return true
            end
        end,
    },
})
