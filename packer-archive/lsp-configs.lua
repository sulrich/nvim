require('lint').linters_by_ft = {
  markdown = { 'markdownlint', 'vale' },
  python = { 'ruff' }
}

vim.api.nvim_create_autocmd({ "bufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- conform provides formatting hooks
require("conform").setup({
    formatters_by_ft = {
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    },
})


-- go setup
require('lspconfig').gopls.setup{}


-- disable this when working on misc. packages.
-- python misc.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- setup nvim-cmp - from the installation docs
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    { name = 'ultisnips' }, -- For ultisnips users.
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
require('lspconfig').ruff_lsp.setup{
  on_attach = on_attach,
  init_options = {
    settings = {
      -- any extra CLI arguments for `ruff` go here.
      args = {},
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
