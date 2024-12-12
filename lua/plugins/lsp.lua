return {
  "neovim/nvim-lspconfig",
  event = "BufWinEnter",
  config = function()
    require('lspconfig').gopls.setup{}

    -- python setup 
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
    -- For the default config, along with instructions on how to customize the settings
    require('lspconfig').ruff.setup{
      on_attach = on_attach,
      init_options = {
        settings = {
          -- any extra CLI arguments for `ruff` go here.
          configurationPreference = "filesystemFirst",
          lint = { },
          args = { },
        }
      }
    }
    require('lspconfig').pyright.setup {
      on_attach = on_attach,
      settings = {
        pyright = {
          -- using ruff's import organizer
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            -- ignore all files for analysis to exclusively use ruff for linting
            ignore = { '*' },
          },
        },
      },
    }
  end,
}
