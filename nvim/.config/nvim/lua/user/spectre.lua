local saferequire = require 'user.util.saferequire'
local spectre = saferequire 'spectre'
if not spectre then
    return
end

spectre.setup {
    find_engine = {
        -- rg is map with finder_cmd
        ['rg'] = {
            cmd = 'rg',
            -- default args
            args = {
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
            },
            options = {
                ['ignore-case'] = {
                    value = '--ignore-case',
                    icon = '[I]',
                    desc = 'ignore case',
                },
                ['hidden'] = {
                    value = '--hidden',
                    desc = 'hidden file',
                    icon = '[H]',
                },
                ['vsc'] = {
                    value = '--no-ignore-vcs',
                    desc = 'allow .ignore',
                    icon = '[G]',
                },
            },
        },
    },
}
