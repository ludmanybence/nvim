return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "marilari88/neotest-vitest",
            "thenbe/neotest-playwright",
            "Issafalcon/neotest-dotnet",
        },
        config = function(_, opts)
            require("neotest").setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-playwright").adapter({
                        options = {
                            filter_dir = function(name, rel_path, root)
                                return name == "e2e"
                            end,
                        }
                    }),
                    require("neotest-dotnet")
                },
                status = { virtual_text = true },
                output = { open_on_run = true },
            })
        end,
        keys = {
            { "<leader>mr", function() require("neotest").run.run() end,                                        desc = "Run Nearest" },
            { "<leader>mi", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary" },
            { "<leader>mo", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
            { "<leader>mO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel" },
            { "<leader>ms", function() require("neotest").run.stop() end,                                       desc = "Stop" },
        },
    },
}
