return {
    {
        "ThePrimeagen/harpoon",
        config = function()
            for i = 1, 9 do
                vim.keymap.set("n", "<leader>" .. i, function() require("harpoon.ui").nav_file(i) end)
            end
        end,
        keys = {
            { "<leader>a", function() require("harpoon.mark").add_file() end,        desc = "Set marker at current file" },
            { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Open Harpoon UI" }

        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                    custom = { '.git$' }
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                },
                update_focused_file = {
                    enable = true,
                }
            })
        end,
        keys = {
            { '<C-n>', ':NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            }

            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')

            local function find_git_root()
                -- Use the current buffer's path as the starting point for the git search
                local current_file = vim.api.nvim_buf_get_name(0)
                local current_dir
                local cwd = vim.fn.getcwd()
                -- If the buffer is not associated with a file, return nil
                if current_file == "" then
                    current_dir = cwd
                else
                    -- Extract the directory from the current file's path
                    current_dir = vim.fn.fnamemodify(current_file, ":h")
                end

                -- Find the Git root directory from the current file's path
                local git_root = vim.fn.systemlist("git -C " ..
                    vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
                if vim.v.shell_error ~= 0 then
                    print("Not a git repository. Searching on current working directory")
                    return cwd
                end
                return git_root
            end

            -- Custom live_grep function to search in git root
            local function live_grep_git_root()
                local git_root = find_git_root()
                if git_root then
                    require('telescope.builtin').live_grep({
                        search_dirs = { git_root },
                    })
                end
            end

            vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
        end,
        keys = { -- See `:help telescope.builtin`
            { '<leader>?',  function() require('telescope.builtin').oldfiles() end,    desc = '[?] Find recently opened files' },
            { '<leader>b',  function() require('telescope.builtin').buffers() end,     desc = '[ ] Find existing buffers' },
            { '<leader>gf', function() require('telescope.builtin').git_files() end,   desc = 'Search [G]it [F]iles' },
            { '<leader>pf', function() require('telescope.builtin').find_files() end,  desc = '[P]roject [F]iles' },
            { '<leader>sh', function() require('telescope.builtin').help_tags() end,   desc = '[S]earch [H]elp' },
            { '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = '[S]earch current [W]ord' },
            { '<leader>ps', function() require('telescope.builtin').live_grep() end,   desc = '[P]roject [S]earch' },
            { '<leader>sG', ':LiveGrepGitRoot<cr>',                                    desc = '[S]earch by [G]rep on Git Root' },
            { '<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = '[S]earch [D]iagnostics' },
            { '<leader>sr', function() require('telescope.builtin').resume() end,      desc = '[S]earch [R]esume' },
            {
                '<leader>/',
                function()
                    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    })
                end,
                desc = '[/] Fuzzily search in current buffer'
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            -- { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    }
}
