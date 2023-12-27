return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
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

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'windwp/nvim-autopairs',
        opts = {
            disable_filetype = { "TelescopePrompt" },
            disable_in_macro = false,
            disable_in_visualblock = false,
            disable_in_replace_mode = true,
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_moveright = true,
            enable_afterquote = true,
            enable_check_bracket_line = true,
            enable_bracket_in_quote = true,
            enable_abbr = false,
            break_undo = true,
            check_ts = false,
            map_cr = true,
            map_bs = true,
            map_c_h = false,
            map_c_w = false,
        }
    },
}
