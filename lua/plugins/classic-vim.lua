-- classic vim plugins - these are typically written in vimscript
return {
    { 'bfredl/nvim-miniyank', lazy = false }, -- addresses some visual block pasting oddities
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
      { '<leader>D', '<Plug>DashSearch' },
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
