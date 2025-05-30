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
    cmd = { 'cspell-lsp', '--stdio' },
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
    root_markers = { '.git', 'cspell.json', 'package.json' },
    -- handlers = {
    --     ['textDocument/publishDiagnostics'] = function(_, result, ctx)
    --         -- Filter or modify diagnostics for this specific server
    --         for _, diagnostic in ipairs(result.diagnostics) do
    --             diagnostic.severity = vim.diagnostic.severity.WARN
    --         end
    --         return vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
    --     end,
    -- },
}
