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
-- clear search highlights
vimp.nnoremap('<leader><space>', ':nohlsearch<cr>')

-- open markdown files in marked2
vimp.nnoremap({'silent'}, '<leader>m', [[:!open -a 'Marked 2.app' "%:p"<cr>]])

-- dash documentation - search for what the cursor is over
vimp.nmap({'silent'}, '<leader>d', '<Plug>DashSearch')

-- move thru ALE errors
vimp.nmap({'silent'}, '<C-k>', ':ALEPrevious<cr>')
vimp.nmap({'silent'}, '<C-j>', ':ALENext<cr>')

vimp.map('p', '<Plug>(miniyank-autoput)')
vimp.map('P', '<Plug>(miniyank-autoPut)')

-- telescope
vimp.nnoremap('<leader>ff', function() require('telescope.builtin').find_files() end )
vimp.nnoremap('<leader>fg', function() require('telescope.builtin').live_grep() end )
vimp.nnoremap('<leader>fb', function() require('telescope.builtin').buffers() end )
vimp.nnoremap('<leader>fh', function() require('telescope.builtin').help_tags() end )
vimp.nnoremap('<leader>gf', function() require('telescope.builtin').git_files() end )

vim.cmd([[
" this seems to cause problems when moved to lua native config
" set spellfile = "~/iCloud/src/configs/aspell/aspell.en.pws"
]])

