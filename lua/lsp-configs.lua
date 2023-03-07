-- python setup
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}


-- null-ls is used for non-LSP sources like linters, etc.
local null_ls = require("null-ls")
local null_sources = {
  -- diagnostics
  null_ls.builtins.diagnostics.vale,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.yamllint,
  -- code 
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.code_actions.shellcheck,
  -- formatting
  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.black,
  -- null_ls.builtins.completion.spell
}


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({ 
  sources = null_sources,
  -- some elements need to be overridden on buffer attachment. 
  on_attach = function(client, bufnr) 
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
    -- this seems to have changed in nvim 0.8, we'll need to set the formatexpr
    -- to "" in order to make sure that it isn't swallowed by the lsp.format() 
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")

    -- 20230307 (sulrich) - it might make sense to implement the following
    -- workaround in the noted issue to be more selective about the setting of
    -- the formatexpr.
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131#issuecomment-1273843531

    -- the following is to address format on save behavior
    -- ref: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    -- you can reuse a shared lspconfig on_attach callback here
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,  -- end callback
      })
    end  -- end textDocument/formatting check
  end,  -- end on_attach function
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

-- setup lspconfig
-- TODO(sulrich): it kind of feels like i should merge this with the folding
-- requirements in init.lua
local lsp = require('lspconfig')
servers = {
   'gopls',
   'pyright'
}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, server in ipairs(servers) do
  lsp[server].setup( { on_attach=on_attach, capabilities = capabilities } )
end

