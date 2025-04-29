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
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
     local capabilities = vim.lsp.protocol.make_client_capabilities()

      local on_attach = function(client, bufnr) 

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

        vim.diagnostic.config({
          signs = true,
          underline = true,
          virtual_text = true, -- Set to false to disable inline messages
          float = {
            source = "always", 
            border = "rounded",
          },
          severity_sort = true,
          update_in_insert = false, 
      })


      require("mason").setup()

      local servers = {
        "lua_ls",
        "astro",
        "bashls",
        "clangd",
        "cssls",
        "tailwindcss",
        "dockerls",
        "gopls",
        "html",
        "eslint",
        "pyright",
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities 
            })
          end,
        }
      })
    end,  
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

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

  -- Theme
  { "projekt0n/github-nvim-theme", name = "github-theme" },
}

local opts = {
  defaults = { lazy = false },
  install = { missing = true },
  change_detection = { enabled = true },
}

require("lazy").setup(plugins, opts)
