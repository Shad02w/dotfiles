local lspconfig = require 'lspconfig'
local config = require 'plugins.lsp.config'
local utils = require 'plugins.lsp.utils'

---inject extra logic when lsp, extra logic can be declare in plugins.lsp.config
local special_lsp_attach_group = vim.api.nvim_create_augroup('special_lsp_attach_group', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = special_lsp_attach_group,
    callback = function(ev)
        local client_id = ev.data.client_id
        local bufnr = ev.buf
        if not client_id or not bufnr then
            return
        end

        local client = vim.lsp.get_client_by_id(client_id)
        if not client then
            return
        end

        utils.on_attach(client, bufnr)
    end,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
    width = 60,
})

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
        },
    },
    severity_sort = true,
    float = {
        focusable = false,
        border = 'rounded',
        source = 'always',
    },
}

for _, s in ipairs(config.enabled_server) do
    local server_name
    if type(s) == 'string' then
        server_name = s
    else
        if s.cond() then
            server_name = s[1]
        end
    end

    if server_name then
        local settings = utils.get_settings(server_name) or {}
        local opts = vim.tbl_deep_extend('force', {
            capabilities = utils.capabilities,
        }, settings)

        if server_name == 'tsserver' then
            require('typescript-tools').setup(opts)
        else
            lspconfig[server_name].setup(opts)
        end
    end
end
