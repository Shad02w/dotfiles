local function jump_to_word()
    require('hop').hint_words()
end

local function jump_to_line()
    vim.cmd 'HopLine'
end
return {
    'phaazon/hop.nvim',
    keys = {
        { '<leader>j', jump_to_word, 'Jump to word' },
        { '<leader>J', jump_to_line, 'Jump to line' },
    },
    config = true,
}
