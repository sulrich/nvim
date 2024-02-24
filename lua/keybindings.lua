vim.g.mapleader = ' '
local vimp = require('vimp')
vimp.imap('kj', '<Esc>')

vimp.nnoremap('<leader>w', [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]])
-- spell check mappings.
-- note: use 'zg' to add the current word to the dictionary
-- use z= to get a list of the possible spelling suggestions.
-- --------------------------------------------------------------------
-- spell check the buffer
vimp.noremap({'silent'}, '<leader>s', [[:set spell!<cr>]])
vimp.nnoremap({'silent'}, '<leader>S', [[ea<C-X><C-S>]])
-- replace the current word with the 1st suggestion.
-- this works - most of the time
vimp.nnoremap({'silent'}, '<leader>r', '1z=')
vimp.imap({'silent'}, '<C-;>', '<Esc>[s1z=`]a')

-- clear search highlights
vimp.nnoremap('<leader><space>', ':nohlsearch<cr>')

-- open markdown files in marked2
vimp.nnoremap({'silent'}, '<leader>m', [[:!open -a 'Marked 2.app' "%:p"<cr>]])

-- dash documentation - search for what the cursor is over
vimp.nmap({'silent'}, '<leader>d', '<Plug>DashSearch')

vimp.map('p', '<Plug>(miniyank-autoput)')
vimp.map('P', '<Plug>(miniyank-autoPut)')

-- search for the visual selection with //
vimp.vnoremap({'silent'}, '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])

-- telescope
vimp.nnoremap('<leader>ff', function() require('telescope.builtin').find_files() end )
vimp.nnoremap('<leader>fg', function() require('telescope.builtin').live_grep() end )
vimp.nnoremap('<leader>fb', function() require('telescope.builtin').buffers() end )
vimp.nnoremap('<leader>fh', function() require('telescope.builtin').help_tags() end )
vimp.nnoremap('<leader>gf', function() require('telescope.builtin').git_files() end )

-- trouble bindings
vimp.nnoremap({'silent'}, "<leader>xx", "<cmd>Trouble<cr>")
vimp.nnoremap({'silent'}, "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
vimp.nnoremap({'silent'}, "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
vimp.nnoremap({'silent'}, "<leader>xl", "<cmd>Trouble loclist<cr>")
vimp.nnoremap({'silent'}, "<leader>xq", "<cmd>Trouble quickfix<cr>")
vimp.nnoremap({'silent'}, "gR", "<cmd>Trouble lsp_references<cr>")

-- gitsigns bindings
vimp.nnoremap({'silent'}, "<leader>hs", ':Gitsigns stage_hunk<CR>')
vimp.vnoremap({'silent'}, "<leader>hs", ':Gitsigns stage_hunk<CR>')

-- allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>',  { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
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
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
