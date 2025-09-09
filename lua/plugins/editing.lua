return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'javascript',
          'typescript',
          'go',
          'svelte',
          'tsx',
          'html',
          'css',
          'scss',
          'json',
          'c',
          'lua',
          'rust',
          'c_sharp',
          'dockerfile',
          'proto',
          'make',
          'vim',
          'vimdoc',
          'query',
          'yaml',
        },
        sync_install = false,
        auto_install = true,
        autotag = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    'tpope/vim-surround',
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    dependencies = {
      'numToStr/Comment.nvim',
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
            {
              "<leader>xx",
              "<cmd>Trouble diagnostics toggle<cr>",
              desc = "Diagnostics (Trouble)",
            },
            {
              "<leader>xX",
              "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              desc = "Buffer Diagnostics (Trouble)",
            },
            {
              "<leader>cs",
              "<cmd>Trouble symbols toggle focus=false<cr>",
              desc = "Symbols (Trouble)",
            },
            {
              "<leader>cl",
              "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
              desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
              "<leader>xL",
              "<cmd>Trouble loclist toggle<cr>",
              desc = "Location List (Trouble)",
            },
            {
              "<leader>xQ",
              "<cmd>Trouble qflist toggle<cr>",
              desc = "Quickfix List (Trouble)",
            },
        },
    },
{
    'mbbill/undotree',
    keys = {
      { '<leader>u', ':UndotreeToggle<CR>', desc = 'Toggle Undo tree' },
    },
  },
  { 'Raimondi/delimitMate' },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = 'C-l',
          accept_word = '<C-j>',
        },
      }
    end,
  },
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-completion' },
  { 'kristijanhusak/vim-dadbod-ui' },
  {
    'kburdett/vim-nuuid',
  },
  {
    'stephpy/vim-yaml',
    config = function()
      vim.cmd [[ autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab ]]
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      require('mini.ai').setup()
    end,
  },
}
