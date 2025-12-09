vim.lsp.set_log_level 'off'

local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

vim.o.winborder = 'rounded'

return {
  {
    'williamboman/mason.nvim',
    opts = { ui = { border = border }, PATH = 'prepend' },
    config = function()
      require('mason').setup {
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      }
    end,
  },
  -- lsp servers
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
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
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            remap = false,
            desc = desc,
          })
          print('LSP ' .. client.name .. ' attached to buffer ' .. bufnr)
        end

        map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
        map('n', 'K', vim.lsp.buf.hover, 'Hover info')
        map('n', '<leader>vws', vim.lsp.buf.workspace_symbol, 'Workspace symbols')
        map('n', '<leader>vd', vim.diagnostic.open_float, 'Open diagnostics')
        map('n', '[d', vim.diagnostic.goto_next, 'Next diagnostic')
        map('n', ']d', vim.diagnostic.goto_prev, 'Prev diagnostic')
        map('n', '<leader>vca', vim.lsp.buf.code_action, 'Code action')
        map('n', '<leader>vrr', vim.lsp.buf.references, 'References')
        map('n', '<leader>vrn', vim.lsp.buf.rename, 'Rename symbol')
        map('i', '<C-h>', vim.lsp.buf.signature_help, 'Signature help')
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

      -- Global LSP keymaps that work for all LSPs including roslyn
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local opts = { buffer = ev.buf, remap = false }

          -- Only set keymaps if the client supports the features
          if client.server_capabilities.definitionProvider then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          end

          if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          end

          if client.server_capabilities.workspaceSymbolProvider then
            vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
          end

          if client.server_capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
          end

          if client.server_capabilities.referencesProvider then
            vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
          end

          if client.server_capabilities.renameProvider then
            vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
          end

          if client.server_capabilities.signatureHelpProvider then
            vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
          end

          -- Diagnostic keymaps (these should always work)
          vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
        end,
      })
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
  {
    'scalameta/nvim-metals',
    ft = { 'scala', 'sbt', 'java' },
    opts = function()
      local metals_config = require('metals').bare_config()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local api = vim.api
      local cmd = vim.cmd
      local metals_config = require('metals').bare_config()

      -- Example of settings
      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to true, however if you do,
      -- you *have* to have a setting to display this in your statusline or else
      -- you'll not see any messages from metals. There is more info in the help
      -- docs about this
      -- metals_config.init_options.statusBarProvider = "on"

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      metals_config.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      -- Debug settings if you're using nvim-dap
      local dap = require 'dap'

      dap.configurations.scala = {
        {
          type = 'scala',
          request = 'launch',
          name = 'RunOrTest',
          metals = {
            runType = 'runOrTestFile',
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
          },
        },
        {
          type = 'scala',
          request = 'launch',
          name = 'Test Target',
          metals = {
            runType = 'testTarget',
          },
        },
      }

      metals_config.on_attach = function(client, bufnr)
        require('metals').setup_dap()
      end

      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = api.nvim_create_augroup('nvim-metals', { clear = true })
      api.nvim_create_autocmd('FileType', {
        -- NOTE: You may or may not want java included here. You will need it if you
        -- want basic Java support but it may also conflict if you are using
        -- something like nvim-jdtls which also works on a java filetype autocmd.
        pattern = { 'scala', 'sbt', 'java' },
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
  {
    'seblyng/roslyn.nvim',
    opts = {},
  },
}
