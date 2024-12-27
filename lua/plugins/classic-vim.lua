-- classic vim plugins
return {
    {
      'nvim-lualine/lualine.nvim',
      lazy = false,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
        theme = 'NeoSolarized',
      }
    },
    { 'bfredl/nvim-miniyank', lazy = false }, -- addresses some visual block pasting oddities
    { 'junegunn/vim-peekaboo', lazy = false },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
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
  { 'tpope/vim-commentary', lazy = true },
  {
    'tpope/vim-surround',
    lazy = true,
    event = 'BufWinEnter',
  },
  { 'axieax/urlview.nvim', lazy = true }, -- enables urls within a buffer
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  }
}
