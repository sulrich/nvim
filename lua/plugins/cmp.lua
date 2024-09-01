return {
  { 
    'SirVer/ultisnips', 
    lazy = true,
    dependencies = { 'honza/vim-snippets' },
    init = function()
      -- snippets
      vim.g.UltiSnipsExpandTrigger='<tab>'
      -- shortcut to go to next position
      vim.g.UltiSnipsJumpForwardTrigger='<C-j>'
      -- shortcut to go to previous position
      vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'
      vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "custom-snippets"}
    end,
  },
  -- this is a collection of useful snippets
  { 'honza/vim-snippets', lazy = true },

  -- nvim-cmp configuration
  {
    'hrsh7th/nvim-cmp',
    event = 'BufWinEnter',
    lazy = true,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'quangnguyen30192/cmp-nvim-ultisnips',
    },
    config = function()
      -- setup nvim-cmp - from the installation docs
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- for `ultisnips`
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({ select = true }), 
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'ultisnips' },
          { name = 'buffer' },
        })
      })

      -- use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })

      -- use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  }
}
