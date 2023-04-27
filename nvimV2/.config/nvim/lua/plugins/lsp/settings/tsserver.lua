return {
    init_options = {
        preferences = {
            disableSuggestions = true,
        },
    },
    root_dir = function(fname)
        local files = {
            'pnpm-workspace.yaml',
            'pnpm-lock.yaml',
            'yarn.lock',
            '.git',
            'bun.lockb',
            'package.json',
            'tsconfig.json',
        }

        for index, filename in ipairs(files) do
            -- Do not use glob pattern here, it is too slow
            local result = require('lspconfig.util').root_pattern(filename)(fname)
            if result == '/' or result == nil then
                if index == #files then
                    return result
                end
            elseif result ~= nil then
                return result
            end
        end
    end,
}
