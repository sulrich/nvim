return {
  "neovim/nvim-lspconfig",
  event = "BufWinEnter",
  dependencies = { 'saghen/blink.cmp' },
  -- using `opts` for defining servers and complementary config
  opts = {
    servers = {
      gopls = {},
      ruff = {
        on_attach = on_attach,
        init_options = {
          settings = {
            -- any extra CLI arguments for `ruff` go here.
            args = {},
          }
        },
      },
      pyright = {
        on_attach = on_attach,
        settings = {
          pyright = {
            -- using ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- ignore all files for analysis to exclusively use ruff for linting
              -- ignore = { '*' },
            },
          },
        },
      },
    },
  },

  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end

  -- 20250507(sulrich) - nvim-cmp lsp setup
  -- config = function()
  --   require('lspconfig').gopls.setup{}
  --
  --   -- python setup 
  --   -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
  --   -- For the default config, along with instructions on how to customize the settings
  --   require('lspconfig').ruff.setup{
  --     on_attach = on_attach,
  --     init_options = {
  --       settings = {
  --         -- any extra CLI arguments for `ruff` go here.
  --         args = {},
  --       }
  --     }
  --   }
  --   require('lspconfig').pyright.setup {
  --     on_attach = on_attach,
  --     settings = {
  --       pyright = {
  --         -- using ruff's import organizer
  --         disableOrganizeImports = true,
  --       },
  --       python = {
  --         analysis = {
  --           -- ignore all files for analysis to exclusively use ruff for linting
  --           ignore = { '*' },
  --         },
  --       },
  --     },
  --   }
  -- end,
}
