return {
    {
        'voldikss/vim-floaterm',
        keys = {
            { "<leader>t", ":FloatermToggle<CR>",            desc = "Open floaterm" },
            { "<Esc>",     "<C-\\><C-n>:FloatermToggle<CR>", desc = "Toggle floaterm off", mode = "t" }
        }
    }
}
