require("mason").setup()
require("mason-lspconfig").setup()

require('lint').linters_by_ft = {
  markdown = {'vale', 'markdownlint',}
}

vim.api.nvim_create_autocmd({ "bufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- go setup
require'lspconfig'.gopls.setup{}


-- python misc.

-- python: black format on save
-- 20240105 disabled to clean up a couple of PRs
-- local group = vim.api.nvim_create_augroup("Black", { clear = true })
-- vim.api.nvim_create_autocmd("bufWritePost", {
-- 	pattern = "*.py",
-- 	command = "silent !black %",
-- 	group = group,
-- })

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

-- setup lspconfig
-- TODO(sulrich): it kind of feels like i should merge this with the folding
-- requirements in init.lua
local lsp = require('lspconfig')
servers = {
   'gopls', 'pyright'
}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, server in ipairs(servers) do
  lsp[server].setup( { on_attach=on_attach, capabilities = capabilities } )
end

 lsp.pyright.setup({
      before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(config.root_dir)
      end,
      -- on_attach = on_attach,
      -- capabilities = capabilities,
    })
