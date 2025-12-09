local getcwd = function()
  local file = vim.api.nvim_buf_get_name(0)
  local start_dir = vim.fn.fnamemodify(file ~= '' and file or vim.fn.getcwd(), ':p:h')
  local root_markers = { 'package.json', 'jest.config.js', 'jest.config.ts', 'jest.config.cjs' }
  local found = vim.fs.find(root_markers, { path = start_dir, upward = true })
  if found and #found > 0 then
    return vim.fn.fnamemodify(found[1], ':h')
  end
  return vim.fn.getcwd()
end

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'haydenmeade/neotest-jest',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'marilari88/neotest-vitest',
      'thenbe/neotest-playwright',
      'Issafalcon/neotest-dotnet',
      'adrigzr/neotest-mocha',
      'rouge8/neotest-rust',
      { 'fredrikaverpil/neotest-golang', version = '*' }, -- Installation,
    },
    opts = {
      discovery = {
        enabled = true,
      },
    },
    config = function(_, opts)
      -- Import Neotest
      local neotest = require 'neotest'

      neotest.setup {
        opts,
        adapters = {
          -- require 'neotest-vitest',
          require 'neotest-jest' {
            jestCommand = 'npm run test --',
            -- Resolve Jest config from package.json scripts or common defaults
            jestConfigFile = function()
              local cwd = vim.fn.getcwd()

              local function file_exists(path)
                local stat = vim.loop.fs_stat(path)
                return stat ~= nil
              end

              local package_json_path = cwd .. '/package.json'
              local ok, lines = pcall(vim.fn.readfile, package_json_path)
              if ok and type(lines) == 'table' and next(lines) ~= nil then
                local joined = table.concat(lines, '\n')
                local decoded = nil
                pcall(function()
                  decoded = vim.fn.json_decode(joined)
                end)
                if decoded and decoded.scripts and decoded.scripts.test then
                  local test_script = decoded.scripts.test
                  -- Match --config <path> with or without quotes
                  local config_path = test_script:match '%-%-config%s+"([^"]+)"'
                    or test_script:match "%-%-config%s+'([^']+)'"
                    or test_script:match '%-%-config%s+([^%s]+)'
                  if config_path and #config_path > 0 then
                    return config_path
                  end
                end
              end

              -- Fallbacks in repo root
              local candidates = {
                cwd .. '/jest.config.ts',
                cwd .. '/jest.config.js',
                cwd .. '/jest.config.cjs',
              }
              for _, path in ipairs(candidates) do
                if file_exists(path) then
                  return path
                end
              end
              return nil
            end,
            -- Avoid forcing CI which may change Jest behavior
            env = {},
            cwd = getcwd,
          },
          -- require("neotest-playwright").adapter({
          -- }),
          require 'neotest-dotnet',
          require 'neotest-mocha' {},
          require 'neotest-golang' {
            dependencies = {
              'leoluz/nvim-dap-go',
            },
            adapters = {
              go_test_args = {
                './...',
                '-v',
                '-race',
                '-count=1',
                '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
              },
            },
          }, -- Registration
          require 'neotest-rust' {
            args = { '--no-capture' },
          },
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        summary = {
          enabled = true,
          open = 'topleft vsplit | vertical resize 50',
        },
      }

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*.go', -- Trigger for any Go file
        callback = function()
          local current_file = vim.fn.expand '<afile>'
          if not current_file:match '_test%.go$' then -- Ignore test files
            local test_file = current_file:gsub('%.go$', '_test.go')
            if vim.fn.filereadable(test_file) == 1 then
              require('neotest').run.run(test_file)
            else
              print('No test file found for ' .. current_file)
            end
          end
        end,
      })
    end,
    keys = {
      {
        '<leader>mr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest',
      },
      {
        '<leader>mt',
        function()
          local dir = (type(getcwd) == 'function') and getcwd() or vim.fn.getcwd()
          require('neotest').run.run(dir)
        end,
        desc = 'Run tests',
      },
      {
        '<leader>mi',
        function()
          require('neotest').summary.toggle()
          require('neotest').summary.expand_all()
        end,
        desc = 'Toggle Summary',
      },
      {
        '<leader>mo',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show Output',
      },
      {
        '<leader>mO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel',
      },
      {
        '<leader>ms',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop',
      },
      {
        '<leader>ma',
        function()
          require('neotest').run.run { suite = true }
        end,
        desc = 'Run All',
      },

      {
        '<leader>md',
        function()
          vim.schedule(function()
            require('neotest').run.run { strategy = 'dap' }
          end)
        end,
        desc = 'Debug Nearest',
      },
      {
        '<leader>mX',
        function()
          require('neotest').run.attach()
        end,
        desc = 'Attach',
      },
    },
  },
  { 'mfussenegger/nvim-dap' },
}
