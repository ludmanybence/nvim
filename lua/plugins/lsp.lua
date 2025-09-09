vim.lsp.set_log_level 'off'

local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

vim.o.winborder = 'rounded'

return {
  -- lsp servers
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = { ui = { border = border }, PATH = 'prepend' } },
      'williamboman/mason-lspconfig.nvim',
      'Hoffs/omnisharp-extended-lsp.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local function on_attach(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
      end

      vim.diagnostic.config { virtual_text = { prefix = '●' } }

      require('mason-lspconfig').setup { ensure_installed = {} }
      local lspconfig = require 'lspconfig'

      lspconfig.vtsls.setup { on_attach = on_attach, capabilities = capabilities }
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            misc = {},
            hover = { expandAlias = false },
            type = { castNumberToInteger = true, inferParamType = true },
            diagnostics = {
              globals = { 'vim' },
              disable = { 'incomplete-signature-doc', 'trailing-space' },
              groupSeverity = { strong = 'Warning', strict = 'Warning' },
              groupFileStatus = {
                ambiguity = 'Opened',
                await = 'Opened',
                codestyle = 'None',
                duplicate = 'Opened',
                global = 'Opened',
                luadoc = 'Opened',
                redefined = 'Opened',
                strict = 'Opened',
                strong = 'Opened',
                ['type-check'] = 'Opened',
                unbalanced = 'Opened',
                unused = 'Opened',
              },
              unusedLocalExclude = { '_*' },
            },
          },
        },
      }

      lspconfig.intelephense.setup {
        root_dir = function()
          return vim.loop.cwd()
        end,
      }

      lspconfig.emmet_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          'css',
          'eruby',
          'html',
          'javascriptreact',
          'less',
          'sass',
          'scss',
          'svelte',
          'pug',
          'typescriptreact',
          'vue',
        },
        init_options = { html = { options = { ['bem.enabled'] = true } } },
      }

      lspconfig.omnisharp.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = { ['textDocument/definition'] = require('omnisharp_extended').handler },
      }
    end,
  },

  {
    {
      'gbprod/phpactor.nvim',
      ft = 'php',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
        'folke/noice.nvim',
      },
      opts = {},
    },
  },

  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = { 'selene', 'luacheck' },
      }
      local selene = lint.linters.selene
      if selene then
        selene.condition = function(ctx)
          local root = vim.uv.cwd()
          return vim.fs.find({ 'selene.toml' }, { path = root, upward = true })[1]
        end
      end
      local luacheck = lint.linters.luacheck
      if luacheck then
        luacheck.condition = function(ctx)
          local root = vim.uv.cwd()
          return vim.fs.find({ '.luacheckrc' }, { path = root, upward = true })[1]
        end
      end
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'petertriho/cmp-git',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'kristijanhusak/vim-dadbod-completion',
    },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = cmp.config.window.bordered {
            border = border,
          },
          documentation = cmp.config.window.bordered {
            border = border,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.confirm { select = true }
            else
              fallback()
            end
          end,
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'vim-dadbod-completion' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        }),
      }
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'avneesh0612/react-nextjs-snippets',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      require('luasnip').filetype_extend('typescript', { 'typescriptreact' })
      require('luasnip').config.setup {}
    end,
  },
  {
    'Issafalcon/lsp-overloads.nvim',
    config = function()
      require('lsp-overloads').setup {}
    end,
  },
}
