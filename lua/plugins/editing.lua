return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'windwp/nvim-ts-autotag'
        },
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "go",
                    "svelte",
                    "tsx",
                    "html",
                    "css",
                    "scss",
                    "json",
                    "c",
                    "lua",
                    "rust",
                    "c_sharp",
                    "dockerfile",
                    "proto",
                    "make",
                    "vim",
                    "vimdoc",
                    "query"
                },
                sync_install = false,
                auto_install = true,
                autotag = {
                    enable = true
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
    {
        'tpope/vim-surround'
    },
    { 'numToStr/Comment.nvim', opts = {} },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { "<leader>xx", function() require("trouble").open() end,                        desc = "Open" },
            { "<leader>xw", function() require("trouble").open("workspace_diagnostics") end, desc = "Open Workspace Diagnostics" },
            { "<leader>xd", function() require("trouble").open("document_diagnostics") end,  desc = "Open Document Diagnostics" },
            { "<leader>xq", function() require("trouble").open("quickfix") end,              desc = "Open Quickfix list" },
            { "<leader>xl", function() require("trouble").open("loclist") end,               desc = "Open Location list" },
        }
    },
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", ":UndotreeToggle<CR>", desc = "Toggle Undo tree" }

        }
    },
    { 'Raimondi/delimitMate' }
}
