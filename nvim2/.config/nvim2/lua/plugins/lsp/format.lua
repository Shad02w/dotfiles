local config = require 'plugins.lsp.config'

---@param client lsp.Client
---@param bufnr number
local function async_format(client, bufnr)
    client.request('textDocument/formatting', vim.lsp.util.make_formatting_params(), function(err, res)
        if err then
            vim.notify('Format Error: ' .. err.message, vim.log.levels.ERROR)
            return
        end

        -- don't apply results if buffer is unloaded or has been modified
        if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
            return
        end

        if res then
            vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or 'utf-16')
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd 'silent noautocmd update'
            end)
        end
    end, bufnr)
end

---set default formatter in plugins.lsp.config
---@param bufnr number
return function(bufnr)
    local TITLE = 'Formatting'
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- get all clients of current buffer
    -- get filetype of current buffer
    -- if default formatter of given filetype is specify
    --      then check if client exist
    --          then format
    --          else notify error
    --      else check if only one formatter
    --          then format
    --          else notify me to select one

    local all_clients = vim.lsp.get_clients { bufnr = bufnr }
    local filetype = vim.bo[bufnr].filetype

    --- @type table<string, lsp.Client>
    local client_maps = {}
    for _, client in ipairs(all_clients) do
        client_maps[client.name] = client
    end

    local all_client_names = vim.tbl_keys(client_maps)

    -- check default formatter
    local default_formatter = config.default_formatter[filetype]
    if default_formatter ~= nil then
        local formatter_name = type(default_formatter) == 'string' and default_formatter or default_formatter()
        if vim.tbl_contains(all_client_names, formatter_name) then
            async_format(client_maps[formatter_name], bufnr)
        else
            vim.notify(
                'Default formatter for `' .. filetype .. '` is not found: ' .. formatter_name,
                vim.log.levels.ERROR,
                { title = TITLE }
            )
        end
        return
    end

    -- if no default_formatter specify

    ---@type table<lsp.Client>
    local formatable_clients = {}

    for _, client in ipairs(all_clients) do
        if client.server_capabilities.documentFormattingProvider ~= false then
            table.insert(formatable_clients, client)
        end
    end

    if vim.tbl_isempty(formatable_clients) then
        vim.notify('Formatter not found', vim.log.levels.ERROR, { title = TITLE })
        return
    end

    -- if there are more than one formatter, notify me
    if #formatable_clients > 1 then
        vim.notify(
            'Have more than one formatter:\n'
                .. table.concat(
                    vim.tbl_map(function(_)
                        return '\t- ' .. _.name
                    end, formatable_clients),
                    '\n'
                )
                .. '\nPlease disable the others, leave only one',
            vim.log.levels.WARN,
            { title = TITLE }
        )
        return
    end

    async_format(formatable_clients[1], bufnr)
end
