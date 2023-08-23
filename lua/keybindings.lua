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

-- the following is to enable classic cut and paste in neovide
if vim.g.neovide then
  vim.keymap.set('n', '<M-s>', ':w<CR>') -- save
  vim.keymap.set('v', '<M-c>', '"+y') -- copy
  vim.keymap.set('n', '<M-v>', '"+P') -- paste normal mode
  vim.keymap.set('v', '<M-v>', '"+P') -- paste visual mode
  vim.keymap.set('c', '<M-v>', '<C-R>+') -- paste command mode
  vim.keymap.set('i', '<M-v>', '<ESC>l"+Pli') -- paste insert mode
end
