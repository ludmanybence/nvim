require 'bence'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.nuuid_no_mappings = 1

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.yaml'] = 'helm',
  },
}

local function ClearRegisters()
  local regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
  for i = 1, #regs do
    local reg = regs:sub(i, i)
    vim.fn.setreg(reg, '')
  end
end

vim.api.nvim_create_user_command('ClearRegisters', ClearRegisters, {})

require('lazy').setup 'plugins'
