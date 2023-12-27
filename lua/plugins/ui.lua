return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "folke/noice.nvim",
        },
        opts = {
            options = {
                icons_enabled = false,
                theme = 'nightfox',
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
    }
}
