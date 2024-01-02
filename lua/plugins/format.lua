return {
    {
        'stevearc/conform.nvim',
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    javascript = { { "prettierd", "prettier" } },
                },
            })
        end
    },
    {
        'sbdchd/neoformat',
        config = function()
            vim.cmd [[
                 autocmd BufWritePre *.js,*.ts,*.tsx,*.svelte,*.jsx Neoformat
            ]]

            vim.g.neoformat_try_node_exe = 1
        end
    }
}
