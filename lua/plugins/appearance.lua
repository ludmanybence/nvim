return {
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
            -- vim.cmd("colorscheme nightfox")
        end
    },
    {
        "sainnhe/everforest",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme everforest")
        end
    },
    {
        "xiyaowong/transparent.nvim",
        priority = 1000,
        config = function()
            local transparent = require('transparent')
            transparent.clear_prefix('lualine')
            transparent.clear_prefix('BufferLine')
            transparent.clear_prefix('NvimTree')
            transparent.clear_prefix('Notify')
            transparent.setup({ -- Optional, you don't have to run setup.
                groups = {      -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer'
                },
                extra_groups = {
                    -- 'NvimTreeNormal',
                    -- 'NvimTreeNormalNC',
                    -- 'NvimTreeRepeat',
                    -- 'NvimTreeNonText',
                    -- 'NvimTreeEndOfBuffer',
                    -- "NormalFloat"
                },                   -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    }
}
