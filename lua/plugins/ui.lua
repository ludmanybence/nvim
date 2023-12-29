return {
    {

        "rcarriga/nvim-notify",
        config = function()
            require('notify').setup({
                -- other stuff
                background_colour = "#000000"
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                presets = {
                    command_palette = true
                }
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "folke/noice.nvim",
        },
        opts = {
            options = {
                icons_enabled = false,
                theme = 'everforest',
                component_separators = '|',
                section_separators = '',
            },
        },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_x = {
                        {
                            require("noice").api.statusline.mode.get,
                            cond = require("noice").api.statusline.mode.has,
                            color = { fg = "#ff9e64" },
                        }
                    },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 1
                        }
                    }
                }
            })
        end
    },
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup {
                enable_tailwind = true
            }
        end
    },
    { "folke/zen-mode.nvim" },
    {
        "folke/twilight.nvim",
        opts = {}
    }
}
