local plugins = {
  -- TS 
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "go", "typescript" },
      highlight = { enable = true },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach = function(_, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set(
          "n",
          "gd",
          vim.lsp.buf.definition,
          vim.tbl_extend("force", bufopts, { desc = "LSP: Go to definition" })
        )

        vim.keymap.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          vim.tbl_extend("force", bufopts, { desc = "LSP: Hover information" })
        )
      end

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ on_attach = on_attach })
      lspconfig.gopls.setup({ on_attach = on_attach }) -- Add configuration for gopls
      lspconfig.eslint.setup({ on_attatch = on_attatch })
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "astro", "bashls", "clangd", "cssls",
          "tailwindcss", "dockerls", "gopls", "html",
          "eslint", "pyright",
        },
      })
    end,
  },

  -- Completion
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    module = "blink.cmp",
    type = "blink.cmp.Config",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = { documentation = { auto_show = true } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
  'kiddos/gemini.nvim',
  opts = {}
  },


  -- Theme
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}

local opts = {
  defaults = { lazy = false },
  install = { missing = true },
  change_detection = { enabled = true },
}

require("lazy").setup(plugins, opts)
