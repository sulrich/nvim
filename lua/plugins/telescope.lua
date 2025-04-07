return {
  {
    'nvim-telescope/telescope.nvim', 
    lazy = true,
    keys = {
      -- telescope
      { '<leader>ff', function() require('telescope.builtin').find_files() end },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end },
      { '<leader>fb', function() require('telescope.builtin').buffers() end },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end },
      { '<leader>gf', function() require('telescope.builtin').git_files() end },
    },
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
}
