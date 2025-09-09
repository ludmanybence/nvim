return {
  {
    'dracula/vim',
    priority = 1000,
    config = function()
      -- vim.cmd 'colorscheme dracula'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd 'colorscheme nightfox'
    -- end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    -- config = function()
    --   vim.cmd 'colorscheme everforest'
    -- end,
  },
  {
    'folke/tokyonight.nvim',
    -- config = function()
    --     vim.cmd("colorscheme tokyonight")
    -- end
  },
  {
    'ellisonleao/gruvbox.nvim',
    -- config = function()
    --   vim.cmd 'colorscheme gruvbox'
    -- end,
  },
  {
    'catppuccin/nvim',
    config = function()
      -- vim.cmd 'colorscheme catppuccin'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    -- config = function()
    --   vim.cmd 'colorscheme rose-pine-moon'
    -- end,
  },
  -- Lazy
  {
    'vague2k/vague.nvim',
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme vague'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    priority = 1000,
    config = function()
      local transparent = require 'transparent'
      transparent.clear_prefix 'lualine_b'
      transparent.clear_prefix 'lualine_c'
      transparent.clear_prefix 'lualine_d'
      transparent.clear_prefix 'BufferLine'
      transparent.clear_prefix 'NvimTree'
      transparent.clear_prefix 'Notify'
      transparent.setup { -- Optional, you don't have to run setup.
        groups = { -- table: default groups
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLine',
          'CursorLineNr',
          'EndOfBuffer',
        },
        extra_groups = {
          -- 'NvimTreeNormal',
          -- 'NvimTreeNormalNC',
          -- 'NvimTreeRepeat',
          -- 'NvimTreeNonText',
          -- 'NvimTreeEndOfBuffer',
          -- "NormalFloat"
        }, -- table: additional groups that should be cleared
        exclude_groups = {

          'NvimTreeCursorLine',
        }, -- table: groups you don't want to clear
      }
    end,
  },
  {
    'RRethy/vim-illuminate',
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function()
      require('illuminate').configure()
    end,
  },
  {
    'goolord/alpha-nvim',
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-telescope/telescope.nvim' },
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {}

      dashboard.section.buttons.val = {
        dashboard.button('f', '󰍉  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '󰄉  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('t', '󰊄  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.vim<CR>'),
        dashboard.button('q', '󰩈  Quit Neovim', ':qa<CR>'),
      }

      local function footer()
        return '張り切って 移行!'
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = 'Type'
      dashboard.section.header.opts.hl = 'Include'
      dashboard.section.buttons.opts.hl = 'Keyword'

      dashboard.opts.opts.noautocmd = true
      require('alpha').setup(dashboard.opts)
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
    end,
  },
}
