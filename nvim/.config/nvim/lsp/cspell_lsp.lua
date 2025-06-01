vim.diagnostic.config {
    virtual_text = {
        format = function(diagnostic)
            if diagnostic.source == 'cSpell' then
                diagnostic.severity = vim.diagnostic.severity.WARN
            end
            return diagnostic.message
        end,
    },
}

---@type vim.lsp.ClientConfig
return {
    cmd = { 'cspell-lsp', '--stdio', '--config', vim.fn.expand '~/cspell.json' },
    filetypes = {
        'go',
        'rust',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'svelte',
        'astro',
        'vue',
        'html',
        'css',
        'json',
        'yaml',
        'markdown',
        'gitcommit',
        'txt',
        'text',
        'python',
        'lua',
        'vim',
        'sh',
        'bash',
        'zsh',
        'fish',
        'dockerfile',
        'sql',
        'xml',
        'toml',
        'ini',
        'conf',
        'log',
        'tex',
        'latex',
        'org',
        'rst',
        'asciidoc',
    },
}
