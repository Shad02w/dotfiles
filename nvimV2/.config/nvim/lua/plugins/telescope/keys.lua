local M = {}

local opts = {
    layout_strategy = 'vertical',
}

function M.recent_files()
    require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown {
        layout_strategy = 'center',
        layout_config = { width = 0.6 },
        previewer = false,
    })
end

function M.buffers()
    require('telescope.builtin').buffers(require('telescope.themes').get_dropdown {
        layout_strategy = 'center',
        layout_config = { width = 0.6 },
        previewer = false,
    })
end

function M.find_files()
    require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
        hidden = true,
        layout_strategy = 'vertical',
        layout_config = {
            width = 0.6,
            height = 0.8,
        },
    })
end

function M.find_all_files()
    require('telescope.builtin').find_files { no_ignore = true, hidden = true }
end

function M.live_grep()
    require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown {
        layout_strategy = 'center',
        layout_config = {
            width = 0.7,
        },
    })
end

function M.live_grep_with_default()
    local text = vim.fn.trim(vim.fn.getreg '0')
    require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy {
        default_text = text,
    })
end

function M.live_grep_raw()
    require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy())
end

function M.help()
    require('telescope.builtin').help_tags(opts)
end

function M.find_projects()
    require('telescope').extensions.project.project()
end

function M.clipboard()
    require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown {
        layout_strategy = 'center',
    })
end

return M
