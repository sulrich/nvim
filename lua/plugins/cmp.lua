return {
  -- nvim-cmp configuration
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    lazy = true,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      "garymjr/nvim-snippets",  -- necessary glue even though we're using the native snippets engine.
    },
    config = function()
      -- setup nvim-cmp - from the installation docs
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.snippet.expand(args.body) -- for native neovim snippets (Neovim v0.10+) 
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- ref: https://github.com/hrsh7th/nvim-cmp/discussions/1498
          -- basically the operation here is to use 'tab' to cycle through the
          -- options with 'tab', then use <cr> to select one.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entries = cmp.get_entries()
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })

              if #entries == 1 then
                cmp.confirm()
              end
            else
              fallback()
            end
          end, { "i", "s" }),
          -- accept currently selected item. set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({ select = true }), 
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'snippets' },
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
  },
  {
    "garymjr/nvim-snippets",
    keys = {
      {
        "<Tab>",
        function()
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
            return
          end
          return "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        end,
        expr = true,
        silent = true,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          if vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
            return
          end
          return "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      friendly_snippets = true, 
    },
  },

  { 
    "rafamadriz/friendly-snippets",
    lazy = true,
  }
} -- end of overall return 
