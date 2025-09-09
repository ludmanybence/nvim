return {
  {
    'voldikss/vim-floaterm',
    keys = {
      { '<leader>t', ':FloatermToggle<CR>', desc = 'Open floaterm' },
      { '<leader>nn', '<C-\\><C-n>:FloatermNext<CR>', desc = 'Next floating terminal', mode = 't' },
      { '<leader>cc', '<C-\\><C-n>:FloatermNew<CR>', desc = 'Next floating terminal', mode = 't' },
      { '<leader>xx', '<C-\\><C-n>:FloatermKill<CR>', desc = 'Next floating terminal', mode = 't' },
      { '<Esc>', '<C-\\><C-n>:FloatermToggle<CR>', desc = 'Toggle floaterm off', mode = 't' },
    },
  },
}
