return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'f-person/git-blame.nvim',
  -- nvim v0.7.2
  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    requires = {
      'nvim-lua/plenary.nvim',
    },

    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
