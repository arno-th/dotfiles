return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("fidget").setup({})
      require("mason").setup()

      -- LSP server config
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright"
        },
      })

      vim.lsp.config('*', {
          capabilities = capabilities
      })

      vim.lsp.config('lua_ls', {
          capabilities = capabilities,
          settings = {
              Lua = {
                  diagnostics = {
                      globals = { "vim" }, -- avoid "vim is undefined"
                  },
                  format = {
                      enable = true,
                      defaultConfig = {
                          indent_style = "space",
                          indent_size = "2",
                      }
                  },
              }
          }
      })

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",  -- could use "" to disable icon
          spacing = 2,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN]  = ' ',
            [vim.diagnostic.severity.HINT]  = ' ',
            [vim.diagnostic.severity.INFO]  = ' ',
          },
        },
        float = {
          border = "rounded",
          source = "always",
          focusable = false,
          style = "minimal",
          header = "",
          prefix = "",
        },
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
}
