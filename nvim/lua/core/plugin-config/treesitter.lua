require 'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "lua", "go", "typescript", "javascript", "vim","tsx","astro","html","css","markdown","gomod","dockerfile","gitignore","yaml","sql","bash","json"},

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
