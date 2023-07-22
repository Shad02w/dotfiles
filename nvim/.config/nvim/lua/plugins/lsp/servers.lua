local M = {}

M.ensure_installed_servers = {
    'vimls',
    'gopls',
    'rust_analyzer',
    'lua_ls',
    'taplo',
    'jsonls',
    'yamlls',
    'lemminx',
    -- web
    -- 'rome',
    'tsserver',
    'tailwindcss',
    'cssls',
    'cssmodules_ls',
    'html',
    'svelte',
    'astro',
}

M.skip_default_setup_servers = {
    'rust_analyzer',
    'tsserver',
}

M.disable_default_formatting_servers = {
    'html',
    'lua_ls',
    'tsserver',
    'cssls',
    'jsonls',
}

return M
