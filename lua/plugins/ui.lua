local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

return {
  {

    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        -- other stuff
        background_colour = '#000000',
      }
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      vim.keymap.set('n', '<leader>nd', '<cmd>NoiceDismiss<CR>', { desc = 'Dismiss Noice notifications' })
      require('noice').setup {
        lsp = {
          hover = {
            enabled = false,
            silent = true,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            -- ['cmp.entry.get_documentation'] = true,
          },
          documentation = {
            view = 'hover',
            opts = { -- lsp_docs settings
              lang = 'markdown',
              replace = true,
              render = 'plain',
              format = { '{message}' },
              position = { row = 2, col = 2 },
              size = {
                max_width = math.floor(0.8 * vim.api.nvim_win_get_width(0)),
                max_height = 15,
              },
              border = {
                border = border,
              },
              win_options = {
                concealcursor = 'n',
                conceallevel = 3,
                winhighlight = {
                  Normal = 'CmpPmenu',
                  FloatBorder = 'DiagnosticSignInfo',
                },
              },
            },
          },
          progress = {
            enabled = false, -- Disable LSP progress to avoid roslyn.nvim conflicts
          },
          signature = {
            enabled = false,
          },
          message = {
            enabled = true,
          },
        },
        messages = {
          enabled = true,
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'glepnir/nerdicons.nvim',
        cmd = 'NerdIcons',
        config = function()
          require('nerdicons').setup {}
        end,
      },
    },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'nordfox',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          -- {
          --   'copilot',
          --   symbols = {
          --     status = {
          --       hl = {
          --         enabled = '#50FA7B',
          --         sleep = '#AEB7D0',
          --         disabled = '#6272A4',
          --         warning = '#FFB86C',
          --         unknown = '#FF5555',
          --       },
          --     },
          --     spinners = require('copilot-lualine.spinners').dots,
          --     spinner_color = '#6272A4',
          --   },
          --   show_colors = false,
          --   show_loading = true,
          -- },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {
        enable_tailwind = true,
      }
    end,
  },
  -- { 'folke/zen-mode.nvim' },
  {
    'shortcuts/no-neck-pain.nvim',
    config = function()
      require('no-neck-pain').setup {
        width = 150,
        autocmds = {
          enableOnVimEnter = false,
          skipEnteringNoNeckPainBuffer = true,
        },
        mappings = {
          enabled = true,
        },
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#15abff' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },
    },
  },
}
