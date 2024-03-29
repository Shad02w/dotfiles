-- highlight color string
local ft = {
    'less',
    'scss',
    'css',
    'html',
    'lua',
    'typescript',
}
return {
    'norcalli/nvim-colorizer.lua', -- highlight color string
    ft = ft,
    config = function()
        require('colorizer').setup(ft)
    end,
}
