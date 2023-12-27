return {
    {
        "ThePrimeagen/harpoon",
        config = function()
            vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
            vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
            for i = 1, 9 do
                vim.keymap.set("n", "<leader>" .. i, function() require("harpoon.ui").nav_file(i) end)
            end
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                },
                update_focused_file = {
                    enable = true,
                }
            })

            vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
}
