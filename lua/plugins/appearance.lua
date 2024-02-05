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
        "folke/tokyonight.nvim"
    },
    {
        "ellisonleao/gruvbox.nvim"
    },
    {
        "catppuccin/nvim"
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
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'EndOfBuffer'
                },
                extra_groups = {
                    'StatusLine'
                    -- 'NvimTreeNormal',
                    -- 'NvimTreeNormalNC',
                    -- 'NvimTreeRepeat',
                    -- 'NvimTreeNonText',
                    -- 'NvimTreeEndOfBuffer',
                    -- "NormalFloat"
                }, -- table: additional groups that should be cleared
                exclude_groups = {

                    'NvimTreeCursorLine'
                }, -- table: groups you don't want to clear
            })
        end
    },
    {
        "RRethy/vim-illuminate",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function()
            require("illuminate").configure()
        end,
    }
}
