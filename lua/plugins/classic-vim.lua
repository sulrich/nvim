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
      'fatih/vim-go', 
      ft = "go",
      lazy = true 
    },
    { 
      'godlygeek/tabular', 
      lazy = true,
      cmd = "Tabularize",
    },
    {
      'mzlogin/vim-markdown-toc',
      ft = "markdown",
      lazy = true,
      init = function()
        vim.g.vmt_dont_insert_fence = 1
        vim.g.vmt_list_item_char = "-"
      end,
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
  {
    'kylechui/nvim-surround',
    version = '*', -- use for stability; omit to use `main` branch for the latest features
    lazy = 'true',
    event = 'BufWinEnter',
    config = function()
        require("nvim-surround").setup()
    end
  },
  { 'axieax/urlview.nvim', lazy = true }, -- enables urls within a buffer
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  }
}
