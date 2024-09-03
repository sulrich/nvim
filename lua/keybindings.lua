vim.g.mapleader = ' '
vim.keymap.set('i', 'kj', '<Esc>', {})

 vim.keymap.set('n', '<leader>w', [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]], {noremap = true})
-- spell check mappings.
-- note: use 'zg' to add the current word to the dictionary
-- use z= to get a list of the possible spelling suggestions.
-- --------------------------------------------------------------------
-- spell check the buffer
vim.keymap.set('n', '<leader>s', ':set spell!<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>S', [[ea<C-X><C-S>]], {noremap = true, silent = true})
-- replace the current word with the 1st suggestion.
-- this works - most of the time
vim.keymap.set('n', '<leader>r', '1z=', {noremap = true, silent = true})
vim.keymap.set('i', '<C-;>','<Esc>[s1z=`]a', {silent = true})

-- clear search highlights
vim.keymap.set('n', '<leader><space>', ':nohlsearch<cr>', {noremap = true, silent = true})

-- open markdown files in marked2
vim.keymap.set('n', '<leader>m', [[:!open -a 'Marked 2.app' "%:p"<cr>]], {noremap = true, silent = true})

-- search for the visual selection with //
vim.keymap.set('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], {noremap = true, silent = true})

-- allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>',  { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- see: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- mappings.
  -- see `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
