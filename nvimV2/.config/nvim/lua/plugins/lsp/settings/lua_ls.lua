return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- path = {
                --     -- Setup your lua path
                --     'lua/?.lua',
                --     'lua/?/init.lua',
                -- },
            },
            completion = {
                callSnippet = 'Replace',
            },
            format = {
                enable = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
