return {
  {
    'stevearc/conform.nvim',
    opts = {
      stop_after_first = true,
    },
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettier', 'prettierd' },
          typescript = { 'prettier', 'prettierd' },
          typescriptreact = { 'prettier', 'prettierd' },
          json = { 'prettier', 'prettierd' },
          jsonc = { 'prettier', 'prettierd' },
          css = { 'prettier', 'prettierd' },
          svelte = { 'prettier', 'prettierd' },
          sql = { 'sqlfluff ' },
          cs = { 'csharpier' },
          go = { 'gofmt', stop_after_first = true },
          php = { 'pint' },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = false,
        },
      }
    end,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = false, lsp_fallback = false }
        end,
      },
    },
  },
  -- {
  --   'sbdchd/neoformat',
  --   config = function()
  --     vim.cmd [[
  --           autocmd BufWritePre *.js,*.ts,*.tsx,*.svelte,*.jsx,*.html,*.json Neoformat
  --      ]]
  --
  --     vim.g.neoformat_try_node_exe = 1
  --   end,
  -- },
  -- {
  --     'mhartington/formatter.nvim',
  --     config = function()
  --         require('formatter').setup({
  --             filetype = {
  --                 javascript = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 typescript = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true

  --                         }
  --                     end
  --                 },
  --                 svelte = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 html = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 json = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 css = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 scss = {
  --                     function()
  --                         return {
  --                             exe = "prettier",
  --                             args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 lua = {
  --                     function()
  --                         return {
  --                             exe = "stylua",
  --                             args = { "--search-parent-directories", "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 sql = {
  --                     function()
  --                         return {
  --                             exe = "sleek",
  --                             args = { "--uppercase", vim.api.nvim_buf_get_name(0) },
  --                             stdin = true
  --                         }
  --                     end
  --                 },
  --                 ["*"] = {
  --                     -- "formatter.filetypes.any" defines default configurations for any
  --                     -- filetype
  --                     require("formatter.filetypes.any").remove_trailing_whitespace
  --                 }
  --             }
  --         })
  --     end
  -- }
}
