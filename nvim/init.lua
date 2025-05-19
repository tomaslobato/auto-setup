-- Set leader key
vim.g.mapleader = " "

-- Keymaps
vim.keymap.set('n', '<space>e', function()
  vim.cmd('Ex')
end, { desc = 'Open explorer' })

-- Options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.cmd('set number')

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true
})

-- Plugin configuration
require('core.plugins')

-- Colorscheme
vim.cmd("colorscheme moonfly")
