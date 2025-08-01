return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-cmdline',
      {'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'},
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        -- Snippet engine
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        -- Key mappings
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),

        -- Completion sources
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end
  }
}
