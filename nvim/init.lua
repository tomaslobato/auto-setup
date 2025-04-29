vim.keymap.set('n', '<space>e', function()
	vim.cmd('Ex')
end, {desc = 'Open explorer'})

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.cmd('set relativenumber')

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

vim.diagnostic.config({
  virtual_text = true
})

require('core.plugins')

vim.cmd("coloscheme github_dark_default")
