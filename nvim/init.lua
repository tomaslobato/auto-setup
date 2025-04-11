vim.keymap.set('n', '<space>e', function()
	vim.cmd('Ex')
end, {desc = 'Open explorer'})

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

require("core.keymaps")
require("core.plugins")
require("core.plugin-config")
