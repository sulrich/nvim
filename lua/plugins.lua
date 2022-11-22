-- packer setup
return require('packer').startup(function()
  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  -- local plugins can be included

  -- classic vim plugins
  use 'SirVer/ultisnips'
  use 'bfredl/nvim-miniyank'
  use 'dhruvasagar/vim-table-mode'
  use 'editorconfig/editorconfig-vim'
  use 'fatih/vim-go'
  use 'godlygeek/tabular'
  use 'hkupty/iron.nvim'  -- repl
  use 'honza/vim-snippets'
  use 'junegunn/vim-peekaboo'
  use 'mzlogin/vim-markdown-toc'
  use 'nathanalderson/yang.vim'
  use 'rizzatti/dash.vim'
  use 'shumphrey/fugitive-gitlab.vim'
  use 'svermeulen/vimpeccable'  -- used for keybindings
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'       -- open associated github URL
  use 'tpope/vim-surround'

  use {
    'mattn/gist-vim',
    requires = {
      'mattn/webapi-vim'
    },
  }

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
    config = function() 
      require('gitsigns').setup() 
    end
  }

  -- easy language server protocol installation
  use { 'neovim/nvim-lspconfig' }
  use { 'jose-elias-alvarez/null-ls.nvim' }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- future configuration comes here
      }
    end
  }

  -- let's give this a whirl
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- a new folding plugin folks are raving about 
  use {
    'kevinhwang91/nvim-ufo', 
    requires = 'kevinhwang91/promise-async'
  }

  use({
    "shaunsingh/nord.nvim", -- colorscheme
    -- commit = "78f5f001709b5b321a35dcdc44549ef93185e024",
  })

  -- Post-install/update hook with neovim command
  -- updates treesitter parsers with packer automatically
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icon
  --   },
  --   config = function() require'nvim-tree'.setup {} end
  -- }

  -- use {
  --   'mrjones2014/dash.nvim',
  --   run = 'make install',
  -- }

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


