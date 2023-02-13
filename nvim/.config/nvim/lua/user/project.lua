local saferequire = require 'user.util.saferequire'
local project_nvim = saferequire 'project_nvim'
if not project_nvim then
    return
end

project_nvim.setup {
    detection_methods = { 'pattern' },
    patterns = {
        '.git',
        '.svn',
        'pnpm-workspace.yaml',
        'yarn.lock',
        'pnpm-lock.yaml',
    },
}

local telescope = saferequire 'telescope'
if not telescope then
    return
end

telescope.load_extension 'projects'
