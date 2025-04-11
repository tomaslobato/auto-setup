local builtin = require('telescope.builtin')

vim.keymap.set('n', '<space>f', builtin.find_files)
vim.keymap.set('n', '<space>fg', builtin.live_grep)
