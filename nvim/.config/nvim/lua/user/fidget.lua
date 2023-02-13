local saferequire = require 'user.util.saferequire'
local fidget = saferequire 'fidget'
if not fidget then
    return
end

fidget.setup {
    text = {
        spinner = 'moon',
    },
    align = {
        bottom = true,
    },
    window = {
        relative = 'editor',
    },
}
