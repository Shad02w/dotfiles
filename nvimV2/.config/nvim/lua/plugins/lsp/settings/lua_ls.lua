local library = {}

---@param path_like string
local function addLibrary(path_like)
    for _, p in pairs(vim.fn.expand(path_like, false, true)) do
        p = vim.loop.fs_realpath(p)
        table.insert(library, p)
    end
end

addLibrary '$VIMRUNTIME'
addLibrary '~/.config/nvim'
addLibrary '~/.local/share/nvim/lazy/*'

return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                path = {
                    -- Setup your lua path
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            format = {
                enable = false,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = library,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
