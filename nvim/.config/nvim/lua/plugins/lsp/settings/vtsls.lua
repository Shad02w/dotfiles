-- { {
--    range = {
--      ["end"] = {
--        character = 61,
--        line = 2
--      },
--      start = {
--        character = 32,
--        line = 2
--      }
--    },
--    uri = "file:///Users/alvistse/Documents/dev/lab/react-compiler-rc/src/App.tsx"
--  } }
local utils = require 'plugins.lsp.utils'
utils.create_lsp_attach_autocmd('vtsls_on_attach', function(client, bufnr)
    if client.name ~= 'vtsls' then
        return
    end

    vim.keymap.set('n', 'gF', function()
        local uri = vim.lsp.util.make_text_document_params(bufnr).uri
        client:exec_cmd({
            title = 'FindFileReferences',
            command = 'typescript.findAllFileReferences',
            arguments = {
                uri,
            },
        }, { bufnr = bufnr }, function(err, result)
            if err then
                vim.notify(err.message, vim.log.levels.ERROR)
                return
            end
            vim.notify(vim.inspect(result))
            -- local locations = result.body.result
            -- if not locations or vim.tbl_isempty(locations) then
            --     return
            -- end
            -- local location = locations[1]
        end)
    end)
end)

return {
    settings = {
        enableMoveToFileCodeAction = true,
    },
}
