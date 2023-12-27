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
    { 'sbdchd/neoformat' }
}
