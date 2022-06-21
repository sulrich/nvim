-- python setup
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}

-- null-ls is used for non-LSP sources like linters, etc.
local null_ls = require("null-ls")
local null_sources = {
  null_ls.builtins.diagnostics.vale,
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.formatting.black,
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.flake8,
  -- null_ls.builtins.completion.spell
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({ 
  sources = null_sources,

  -- the following is to address format on save behavior
  -- ref: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
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
  }, {
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
local lsp = require('lspconfig')
servers = {
   'gopls',
   'pyright'
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, server in ipairs(servers) do
  lsp[server].setup( { on_attach=on_attach, capabilities = capabilities } )
end

