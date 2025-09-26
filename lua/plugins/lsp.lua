return {
  "neovim/nvim-lspconfig",
  event = "BufWinEnter",
  dependencies = { 'saghen/blink.cmp' },
  -- using `opts` for defining servers and complementary config
  opts = {
    servers = {
      gopls = {},
      marksman = {  -- markdown lsp
        on_attach = on_attach,
      },
      basedpyright = {
        on_attach = on_attach,
        settings = {
          basedpyright = {
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
      }, -- end: pyright
      ruff = {
        on_attach = on_attach,
        init_options = {
          settings = {
            -- any extra CLI arguments for `ruff` go here.
            args = {},
          }
        },
      },
      -- lua_ls = {},

    }, -- end: servers
  },

  config = function(_, opts)
    -- local lspconfig = vim.lsp.config()
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      vim.lsp.enable(server)
    end
  end,
}
