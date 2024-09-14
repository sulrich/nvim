-- classic vim plugins
return {
  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = { 'nvim-lualine/lualine.nvim' },
    config = function()
      local ok_status, NeoSolarized = pcall(require, "NeoSolarized")

      if not ok_status then
        return
      end
      -- settings for NeoSolarized
      NeoSolarized.setup {
        style = "dark", -- "dark" or "light"
        transparent = false, -- true/false; Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        enable_italics = false, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
        styles = {
          -- Style to be applied to different syntax groups
          comments = { italic = false },
          keywords = { italic = false },
          functions = { bold = true },
          variables = {},
          string = { italic = false },
          underline = true, -- true/false; for global underline
          undercurl = true, -- true/false; for global undercurl
        },
        -- add specific hightlight groups
        -- on_highlights = function(highlights, colors)
          --    highlights.Include.fg = colors.red -- Using `red` foreground for Includes
          -- end,
        }
        vim.cmd [[ colorscheme NeoSolarized ]]
      end
    },
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
    "folke/trouble.nvim",
    keys = {
      -- trouble bindings
      { '<leader>xx', '<cmd>Trouble<cr>'},
      { '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>'},
      { '<leader>xd', "<cmd>Trouble document_diagnostics<cr>" },
      { '<leader>xl', "<cmd>Trouble loclist<cr>" },
      { '<leader>xq', "<cmd>Trouble quickfix<cr>", },
      { '<leader>gR', "<cmd>Trouble lsp_references<cr>" },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  }
}
