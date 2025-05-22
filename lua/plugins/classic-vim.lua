-- classic vim plugins
return {
    { 'bfredl/nvim-miniyank', lazy = false }, -- addresses some visual block pasting oddities
    {
      'dhruvasagar/vim-table-mode',
      lazy = true,
      init = function()
        -- for vim-table-mode use markdown stule corners
        vim.g.table_mode_corner='|'
      end,
    },
    { 
      'godlygeek/tabular', 
      lazy = true,
      cmd = "Tabularize",
    },
    {
      'nathanalderson/yang.vim',
      ft = "yang",
      lazy = true
    },
    { 'rizzatti/dash.vim',
    lazy = true,
    keys = {
      { '<leader>d', '<Plug>DashSearch' },
    },
  },
  { 'axieax/urlview.nvim', 
    lazy = true,
  }, -- enables urls within a buffer
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  }
}
