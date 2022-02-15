-- packer setup
return require('packer').startup(function()
  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  -- local plugins can be included

  -- classic vim plugins
  use 'nathanalderson/yang.vim'
  use 'lifepillar/vim-solarized8'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'fatih/vim-go'
  use 'godlygeek/tabular'
  use 'hkupty/iron.nvim'  -- repl
  use 'editorconfig/editorconfig-vim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'mattn/gist-vim'
  use 'rizzatti/dash.vim'
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'tpope/vim-commentary'
  use 'bfredl/nvim-miniyank'
  use 'svermeulen/vimpeccable'
  use 'shumphrey/fugitive-gitlab.vim'
  use 'dhruvasagar/vim-table-mode'
  use 'mzlogin/vim-markdown-toc'
  use 'dense-analysis/ale'
  use 'psf/black'                  -- python formatting
  use 'tpope/vim-rhubarb'
  use 'junegunn/vim-peekaboo'

  -- reasonable wiki/markdown editing
  use { 'raghur/vim-ghost', run = ":GhostInstall" } 

  -- completion plugins
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- new hotness plugins
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- replacement for vimscript gitgutter
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup() end
  }

  -- easy language server protocol installation
  use 'neovim/nvim-lspconfig'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- load on a combination of conditions: specific filetypes or commands
  -- also run code after load (see the "config" key)
  -- use {
  -- 'dense-analysis/ale',
  --   ft = {'sh', 'zsh', 'bash', 'cmake', 'html', 'markdown' },
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- }


  -- url = https://github.com/honza/vim-snippets.git
  -- url = https://github.com/fisadev/vim-isort.git
  -- url = https://github.com/mattn/webapi-vim.git
  -- url = https://github.com/tpope/vim-rhubarb.git

  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Plugins can have dependencies on other plugins
  -- use {
  --   'haorenW1025/completion-nvim',
  --   opt = true,
  --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  -- }

  -- -- Plugins can also depend on rocks from luarocks.org:
  -- use {
  --   'my/supercoolplugin',
  --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  -- }

  -- -- You can specify rocks in isolation
  -- use_rocks 'penlight'
  -- use_rocks {'lua-resty-http', 'lpeg'}

  -- -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- -- Plugins can have post-install/update hooks
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- -- Post-install/update hook with call of vimscript function with argument
  -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- -- Use specific branch, dependency and run lua file after load
  -- use {
  --   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- }

  -- -- You can specify multiple plugins in a single call
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
	  require('packer').sync()
  end
end)


